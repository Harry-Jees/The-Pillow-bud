import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../theme/app_colors.dart';
import '../models/chat_message.dart';
import '../services/llm_service.dart';
import '../services/crisis_detector.dart';
import '../config/constants.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _ctrl = TextEditingController();
  final _scroll = ScrollController();
  final _uuid = const Uuid();
  bool _typing = false;

  final List<ChatMessage> _messages = [
    ChatMessage(id: '0', text: 'Hey! I\'m here to listen. What\'s on your mind?', isFromBud: true, timestamp: DateTime.now()),
  ];

  Future<void> _send() async {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;
    _ctrl.clear();

    setState(() {
      _messages.add(ChatMessage(id: _uuid.v4(), text: text, isFromBud: false, timestamp: DateTime.now()));
    });
    _scrollDown();

    if (CrisisDetector.detect(text)) {
      _showCrisisDialog();
    }

    setState(() => _typing = true);
    final response = await LLMService.getResponse(text);
    if (!mounted) return;
    setState(() {
      _typing = false;
      _messages.add(ChatMessage(id: _uuid.v4(), text: response, isFromBud: true, timestamp: DateTime.now()));
    });
    _scrollDown();
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(_scroll.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    });
  }

  void _showCrisisDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('I care about you 💙', style: TextStyle(fontFamily: 'Lora', fontSize: 18, color: AppColors.textPrimaryDark)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Please reach out to someone right now:', style: TextStyle(fontFamily: 'DM Sans', fontSize: 13, color: Colors.white.withOpacity(0.7))),
            const SizedBox(height: 16),
            _crisisItem(AppConstants.icallName, AppConstants.icallNumber),
            _crisisItem(AppConstants.vandrevalaName, AppConstants.vandrevalaNumber),
            _crisisItem(AppConstants.aasraName, AppConstants.aasraNumber),
          ],
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close', style: TextStyle(color: AppColors.primary)))],
      ),
    );
  }

  Widget _crisisItem(String name, String number) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(children: [
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(name, style: const TextStyle(fontFamily: 'DM Sans', fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textPrimaryDark)),
        Text(number, style: TextStyle(fontFamily: 'DM Sans', fontSize: 12, color: Colors.white.withOpacity(0.5))),
      ])),
      const Icon(Icons.call, color: AppColors.primary, size: 18),
    ]),
  );

  @override
  void dispose() { _ctrl.dispose(); _scroll.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bud')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scroll,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: _messages.length + (_typing ? 1 : 0),
              itemBuilder: (ctx, i) {
                if (_typing && i == _messages.length) return _buildTyping();
                final msg = _messages[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: msg.isFromBud ? _buildBud(msg.text) : _buildUser(msg.text),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.white.withOpacity(0.08)))),
            child: Row(children: [
              Expanded(
                child: TextField(
                  controller: _ctrl,
                  maxLines: null,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _send(),
                  style: const TextStyle(fontFamily: 'DM Sans', fontSize: 14, color: AppColors.textPrimaryDark),
                  decoration: InputDecoration(
                    hintText: 'Share your thoughts...',
                    hintStyle: TextStyle(fontFamily: 'DM Sans', color: Colors.white.withOpacity(0.35)),
                    filled: true, fillColor: Colors.white.withOpacity(0.04),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: AppColors.primary)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: _send,
                child: Container(
                  width: 42, height: 42,
                  decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                  child: const Icon(Icons.send_rounded, color: Colors.white, size: 18),
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
      Container(width: 28, height: 28, decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.2), shape: BoxShape.circle), child: const Center(child: Text('🌸', style: TextStyle(fontSize: 14)))),
      const SizedBox(width: 8),
      Flexible(child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.12),
          border: Border.all(color: AppColors.primary.withOpacity(0.2)),
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(14), bottomLeft: Radius.circular(14), bottomRight: Radius.circular(14)),
        ),
        child: Text(text, style: TextStyle(fontFamily: 'DM Sans', fontSize: 13, color: Colors.white.withOpacity(0.85), height: 1.6)),
      )),
    ],
  );

  Widget _buildUser(String text) => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Flexible(child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: const BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(4), bottomLeft: Radius.circular(14), bottomRight: Radius.circular(14)),
        ),
        child: Text(text, style: const TextStyle(fontFamily: 'DM Sans', fontSize: 13, color: Colors.white, height: 1.6)),
      )),
    ],
  );

  Widget _buildTyping() => Row(
    children: [
      Container(width: 28, height: 28, decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.2), shape: BoxShape.circle), child: const Center(child: Text('🌸', style: TextStyle(fontSize: 14)))),
      const SizedBox(width: 8),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.12), borderRadius: BorderRadius.circular(14)),
        child: Row(mainAxisSize: MainAxisSize.min, children: List.generate(3, (i) => _Dot(delay: i * 200))),
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
    _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _a = Tween(begin: 0.4, end: 1.0).animate(CurvedAnimation(parent: _c, curve: Curves.easeInOut));
    Future.delayed(Duration(milliseconds: widget.delay), () { if (mounted) _c.repeat(reverse: true); });
  }

  @override
  void dispose() { _c.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 2),
    child: FadeTransition(opacity: _a, child: Container(width: 7, height: 7, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle))),
  );
}
