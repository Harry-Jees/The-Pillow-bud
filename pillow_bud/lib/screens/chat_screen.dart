import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../theme/app_colors.dart';
import '../theme/theme_colors.dart';
import '../models/chat_message.dart';
import '../services/crisis_detector.dart';
import '../services/emotion_detector.dart';
import '../config/constants.dart';
import '../providers/app_providers.dart';
import '../providers/llm_provider.dart';
import '../providers/ai_service_provider.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _ctrl = TextEditingController();
  final _scroll = ScrollController();
  final _uuid = const Uuid();
  bool _typing = false;
  String _lastEmotion = 'neutral';

  Future<void> _send() async {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;
    _ctrl.clear();

    _lastEmotion = EmotionDetector.detect(text);
    final intensity = EmotionDetector.getIntensity(text);
    ref.read(currentEmotionProvider.notifier).state = _lastEmotion;
    ref.read(emotionIntensityProvider.notifier).state = intensity;

    final userMessage = ChatMessage(
      id: _uuid.v4(),
      text: text,
      isFromBud: false,
      timestamp: DateTime.now(),
    );
    await ref.read(chatStateProvider.notifier).addMessage(userMessage);
    _scrollDown();

    if (CrisisDetector.detect(text)) {
      _showCrisisDialog();
    }

    final history = ref.read(chatStateProvider);
    final userName = await ref.read(userNameProvider.future);
    final personality = await ref.read(personalityProvider.future);
    setState(() => _typing = true);
    try {
      final response = await ref.read(llmServiceProvider).getResponse(
        text,
        conversationHistory: history,
        userName: userName,
        personalityMode: personality,
      );
      if (!mounted) return;

      final budMessage = ChatMessage(
        id: _uuid.v4(),
        text: response,
        isFromBud: true,
        timestamp: DateTime.now(),
      );
      await ref.read(chatStateProvider.notifier).addMessage(budMessage);
    } catch (e) {
      if (!mounted) return;
      final errMsg = ChatMessage(
        id: _uuid.v4(),
        text: 'Bud is having trouble responding right now. Please try again in a moment.',
        isFromBud: true,
        timestamp: DateTime.now(),
      );
      await ref.read(chatStateProvider.notifier).addMessage(errMsg);
    }
    if (!mounted) return;
    setState(() => _typing = false);
    _scrollDown();
  }

  Future<void> _confirmClearChat(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Clear chat?', style: TextStyle(fontFamily: 'Caveat', fontSize: 18, color: Theme.of(context).colorScheme.onSurface)),
        content: Text('All messages will be deleted. This can\'t be undone.', style: TextStyle(fontFamily: 'Nunito', fontSize: 13, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7))),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Clear', style: TextStyle(color: AppColors.danger))),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      await ref.read(chatStateProvider.notifier).clearHistory();
    }
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _showCrisisDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.themeCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('I care about you 💙',
            style: TextStyle(
                fontFamily: 'Caveat',
                fontSize: 18,
                color: context.themeOnSurface)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Please reach out to someone right now:',
                style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 13,
                    color: context.themeOnSurface.withValues(alpha: 0.7))),
            const SizedBox(height: 16),
            _crisisItem(context, AppConstants.icallName, AppConstants.icallNumber),
            _crisisItem(context,
                AppConstants.vandrevalaName, AppConstants.vandrevalaNumber),
            _crisisItem(context, AppConstants.aasraName, AppConstants.aasraNumber),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Close',
                style: TextStyle(color: context.themePrimary)),
          )
        ],
      ),
    );
  }

  Widget _crisisItem(BuildContext context, String name, String number) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(children: [
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: context.themeOnSurface)),
                  Text(number,
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 12,
                          color: context.themeOnSurface.withValues(alpha: 0.5))),
                ]),
          ),
          Icon(Icons.call, color: context.themePrimary, size: 18),
        ]),
      );

  @override
  void dispose() {
    _ctrl.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatStateProvider);

    // Watch AI initialization state
    final aiInitAsync = ref.watch(llmInitProvider);
    final isAiLoading = aiInitAsync.isLoading;
    final llmInitError = aiInitAsync.hasError ? aiInitAsync.error.toString() : null;

    // Watch whether Gemma or fallback is active
    final aiNameAsync = ref.watch(aiServiceNameProvider);
    final aiName = aiNameAsync.valueOrNull ?? '…';
    final isGemma = aiName == 'Gemma';

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                const Text('Bud'),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: isGemma
                        ? AppColors.success.withValues(alpha: 0.2)
                        : AppColors.warning.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    isGemma ? 'Gemma' : 'Fallback',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 9,
                      color: isGemma ? AppColors.success : AppColors.warning,
                    ),
                  ),
                ),
              ],
            ),
            if (_lastEmotion != 'neutral')
              Text(
                'I sense you\'re feeling $_lastEmotion',
                style: TextStyle(
                  fontSize: 10,
                  color: context.themeOnSurface.withValues(alpha: 0.5),
                ),
              ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, size: 20),
            tooltip: 'Clear chat',
            onPressed: () => _confirmClearChat(context),
          ),
        ],
      ),
      body: Column(
        children: [
          if (isAiLoading)
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: AppColors.warning.withValues(alpha: 0.12),
              child: Row(
                children: [
                  SizedBox(
                    width: 12, height: 12,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.warning.withValues(alpha: 0.8)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Loading AI… Bud is using a simple fallback in the meantime.',
                      style: TextStyle(
                          fontFamily: 'Nunito', fontSize: 12, color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          else if (llmInitError != null)
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: AppColors.warning.withValues(alpha: 0.12),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, size: 14, color: AppColors.warning),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'AI setup incomplete. Bud will use a simple fallback.',
                      style: TextStyle(
                          fontFamily: 'Nunito', fontSize: 12, color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          else if (!isGemma)
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: AppColors.warning.withValues(alpha: 0.12),
              child: const Row(
                children: [
                  Icon(Icons.smart_toy_outlined, size: 14, color: AppColors.warning),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Using fallback responses. Go to Profile to activate Gemma AI for richer replies.',
                      style: TextStyle(
                          fontFamily: 'Nunito', fontSize: 11, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: ListView.builder(
              controller: _scroll,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: messages.length + (_typing ? 1 : 0),
              itemBuilder: (ctx, i) {
                if (_typing && i == messages.length) return _buildTyping();
                final msg = messages[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: msg.isFromBud
                      ? _buildBud(msg.text)
                      : _buildUser(msg.text),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: context.themeOnSurface.withValues(alpha: 0.08)))),
            child: Row(children: [
              Expanded(
                child: TextField(
                  controller: _ctrl,
                  maxLines: null,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _send(),
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 14,
                      color: context.themeOnSurface),
                  decoration: InputDecoration(
                    hintText: 'Share your thoughts...',
                    hintStyle: TextStyle(
                        fontFamily: 'Nunito',
                        color: context.themeOnSurface.withValues(alpha: 0.35)),
                    filled: true,
                    fillColor: context.themeOnSurface.withValues(alpha: 0.04),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            BorderSide(color: context.themeOnSurface.withValues(alpha: 0.1))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            BorderSide(color: context.themeOnSurface.withValues(alpha: 0.1))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            BorderSide(color: context.themePrimary)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: _send,
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                      color: context.themePrimary, shape: BoxShape.circle),
                  child: const Icon(Icons.send_rounded,
                      color: Colors.white, size: 18),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildBud(String text) => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                  color: context.themePrimary.withValues(alpha: 0.2),
                  shape: BoxShape.circle),
              child:
                  const Center(child: Text('🌸', style: TextStyle(fontSize: 14)))),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: context.themePrimary.withValues(alpha: 0.12),
                border: Border.all(
                    color: context.themePrimary.withValues(alpha: 0.2)),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(14),
                    bottomLeft: Radius.circular(14),
                    bottomRight: Radius.circular(14)),
              ),
              child: Text(text,
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 13,
                      color: context.themeOnSurface.withValues(alpha: 0.85),
                      height: 1.6)),
            ),
          ),
        ],
      );

  Widget _buildUser(String text) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: context.themePrimary,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(4),
                    bottomLeft: Radius.circular(14),
                    bottomRight: Radius.circular(14)),
              ),
              child: Text(text,
                  style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 13,
                      color: Colors.white,
                      height: 1.6)),
            ),
          ),
        ],
      );

  Widget _buildTyping() => Row(
        children: [
          Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                  color: context.themePrimary.withValues(alpha: 0.2),
                  shape: BoxShape.circle),
              child:
                  const Center(child: Text('🌸', style: TextStyle(fontSize: 14)))),
          const SizedBox(width: 8),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
                color: context.themePrimary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14)),
            child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(3, (i) => _Dot(delay: i * 200))),
          ),
        ],
      );
}

class _Dot extends StatefulWidget {
  final int delay;
  const _Dot({required this.delay});

  @override
  State<_Dot> createState() => _DotState();
}

class _DotState extends State<_Dot> with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _a;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 600));
    _a = Tween(begin: 0.4, end: 1.0)
        .animate(CurvedAnimation(parent: _c, curve: Curves.easeInOut));
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _c.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: FadeTransition(
            opacity: _a,
            child: Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                    color: context.themePrimary, shape: BoxShape.circle))),
      );
}
