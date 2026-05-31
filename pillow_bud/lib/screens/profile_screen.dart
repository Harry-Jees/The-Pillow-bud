import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme_state.dart';
import '../theme/theme_colors.dart';
import '../config/constants.dart';
import '../providers/app_providers.dart';
import '../providers/storage_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/llm_provider.dart';
import '../services/gemma_native_ai.dart';
import '../services/personalization_service.dart';
import '../models/user_preference.dart';
import 'onboarding_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameAsync = ref.watch(userNameProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Me')),
      body: nameAsync.when(
        data: (name) => _buildBody(context, ref, name),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => _buildBody(context, ref, 'Friend'),
      ),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, String name) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Container(
            width: 64, height: 64,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [context.themePrimary, context.themeSecondary]),
              shape: BoxShape.circle,
            ),
            child: Center(child: Text(name.isNotEmpty ? name[0].toUpperCase() : 'B',
                style: const TextStyle(fontFamily: 'Caveat', fontSize: 26, fontWeight: FontWeight.w600, color: Colors.white))),
          ),
          const SizedBox(height: 12),
          Text(name, style: TextStyle(fontFamily: 'Caveat', fontSize: 18, fontWeight: FontWeight.w500, color: context.themeOnSurface)),
                  Text('Member since today', style: TextStyle(fontFamily: 'Nunito', fontSize: 11, color: context.themeOnSurface.withValues(alpha: 0.4))),
          const SizedBox(height: 28),
          _section('SETTINGS', context),
          _themeSelector(context, ref),
          const SizedBox(height: 12),
          _darkModeToggle(context, ref),
          const SizedBox(height: 12),
          _personalitySelector(context, ref),
          const SizedBox(height: 12),
          _aiSetupCard(context, ref),
          const SizedBox(height: 12),
          _section('ABOUT', context),
          _item(context, 'App Name', 'Pillow Bud'),
          _item(context, 'Version', '1.0.0'),
          const SizedBox(height: 20),
          _section('CRISIS RESOURCES', context),
          _crisisItem(context, AppConstants.icallName, AppConstants.icallNumber),
          _crisisItem(context, AppConstants.vandrevalaName, AppConstants.vandrevalaNumber),
          _crisisItem(context, AppConstants.aasraName, AppConstants.aasraNumber),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity, height: 46,
            child: OutlinedButton(
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (c) => AlertDialog(
                    backgroundColor: context.themeCard,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    title: Text('Reset App',
                        style: TextStyle(fontFamily: 'Caveat', fontSize: 18, color: context.themeOnSurface)),
                    content: Text('This will clear all your data, including chat history and journal entries. Are you sure?',
                        style: TextStyle(fontFamily: 'Nunito', fontSize: 13, color: context.themeOnSurface)),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(c, false),
                          child: Text('Cancel', style: TextStyle(color: context.themeOnSurface))),
                      TextButton(onPressed: () => Navigator.pop(c, true),
                          child: const Text('Reset', style: TextStyle(color: AppColors.danger))),
                    ],
                  ),
                );
                if (confirm != true) return;
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                try {
                  final storage = await ref.read(storageServiceProvider.future);
                  await storage.clearAll();
                } catch (_) {}
                if (!context.mounted) return;
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const OnboardingScreen()),
                  (_) => false,
                );
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: context.themeOnSurface.withValues(alpha: 0.15)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text('Reset App',
                  style: TextStyle(fontFamily: 'Nunito', fontSize: 13, color: context.themeOnSurface.withValues(alpha: 0.5))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _themeSelector(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeStateProvider);
    final currentPreset = themeState.preset;
    final solids = AppThemePreset.values.where((p) => !isGradientPreset(p)).toList();
    final gradients = AppThemePreset.values.where((p) => isGradientPreset(p)).toList();

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.themeOnSurface.withValues(alpha: 0.04),
        border: Border.all(color: context.themeOnSurface.withValues(alpha: 0.07)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Theme — Solid',
              style: TextStyle(fontFamily: 'Nunito', fontSize: 13, color: context.themeOnSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: solids.map((preset) {
              final colors = themePresetColors[preset]!;
              final isSelected = currentPreset == preset;
              return GestureDetector(
                onTap: () => _selectTheme(ref, preset),
                child: Column(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: colors.primary,
                        borderRadius: BorderRadius.circular(12),
                        border: isSelected
                            ? Border.all(color: Colors.white, width: 2.5)
                            : null,
                        boxShadow: isSelected
                            ? [BoxShadow(color: colors.primary.withValues(alpha: 0.5), blurRadius: 8)]
                            : null,
                      ),
                      child: isSelected
                          ? const Icon(Icons.check, color: Colors.white, size: 20)
                          : null,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _shortPresetName(preset),
                      style: TextStyle(
                        fontFamily: 'Nunito', fontSize: 8,
                        color: isSelected
                            ? colors.primary
                            : context.themeOnSurface.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          if (gradients.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text('Theme — Gradient',
                style: TextStyle(fontFamily: 'Nunito', fontSize: 13, color: context.themeOnSurface.withValues(alpha: 0.7))),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: gradients.map((preset) {
                final g = themeGradientColors[preset]!;
                final isSelected = currentPreset == preset;
                return GestureDetector(
                  onTap: () => _selectTheme(ref, preset),
                  child: Column(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [g.from, g.to],
                            begin: const Alignment(0, 0),
                            end: const Alignment(0, 1),
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: isSelected
                              ? Border.all(color: Colors.white, width: 2.5)
                              : null,
                        ),
                        child: isSelected
                            ? const Icon(Icons.check, color: Colors.white, size: 20)
                            : null,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _shortPresetName(preset),
                        style: TextStyle(
                          fontFamily: 'Nunito', fontSize: 8,
                          color: isSelected
                              ? Colors.white
                              : context.themeOnSurface.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  String _shortPresetName(AppThemePreset p) {
    switch (p) {
      case AppThemePreset.azureSerenity: return 'Azure';
      case AppThemePreset.oceanDream: return 'Ocean';
      case AppThemePreset.polarFrost: return 'Frost';
      case AppThemePreset.twilightSky: return 'Twilight';
      case AppThemePreset.cosmicBlue: return 'Cosmic';
      case AppThemePreset.softWhisper: return 'Whisper';
      case AppThemePreset.daylightBlue: return 'Daylight';
      case AppThemePreset.depthDiscovery: return 'Depth';
      case AppThemePreset.morningCalm: return 'Morning';
      case AppThemePreset.silverLining: return 'Silver';
      case AppThemePreset.aquamarineDream: return 'Aqua';
      case AppThemePreset.cornflowerBliss: return 'Cornflwr';
      case AppThemePreset.steelSanctuary: return 'Steel';
      case AppThemePreset.periwinklePeace: return 'Periwinkl';
      case AppThemePreset.slateHarmony: return 'Slate';
      case AppThemePreset.azureToTeal: return '→Teal';
      case AppThemePreset.oceanDepths: return '→Depths';
      case AppThemePreset.skyToHorizon: return '→Horizon';
      case AppThemePreset.aquaGlow: return '→Glow';
      case AppThemePreset.twilightAurora: return '→Aurora';
      case AppThemePreset.mintBreeze: return '→Mint';
      case AppThemePreset.seafoamDrift: return '→Seafoam';
      case AppThemePreset.stellarBlue: return '→Stellar';
      case AppThemePreset.lavenderSky: return '→Lav Sky';
      case AppThemePreset.silverStream: return '→Stream';
    }
  }

  Future<void> _selectTheme(WidgetRef ref, AppThemePreset preset) async {
    ref.read(themeStateProvider.notifier).setPreset(preset);
    try {
      final storage = await ref.read(storageServiceProvider.future);
      final pref = await storage.loadPreference() ?? UserPreference.empty();
      await storage.savePreference(pref.copyWith(
        themeName: preset.name,
        isDarkMode: ref.read(themeStateProvider).isDarkMode,
      ));
    } catch (_) {}
  }

  Widget _darkModeToggle(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeStateProvider).isDarkMode;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: context.themeOnSurface.withValues(alpha: 0.04),
        border: Border.all(color: context.themeOnSurface.withValues(alpha: 0.07)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            isDark ? Icons.dark_mode : Icons.light_mode,
            color: context.themePrimary, size: 20,
          ),
          const SizedBox(width: 12),
          Text(
            isDark ? 'Dark Mode' : 'Light Mode',
            style: TextStyle(fontFamily: 'Nunito', fontSize: 13, color: context.themeOnSurface),
          ),
          const Spacer(),
          Switch(
            value: isDark,
            activeTrackColor: context.themePrimary.withValues(alpha: 0.3),
            onChanged: (v) => _toggleDarkMode(ref, v),
          ),
        ],
      ),
    );
  }

  Future<void> _toggleDarkMode(WidgetRef ref, bool isDark) async {
    ref.read(themeStateProvider.notifier).setDarkMode(isDark);
    try {
      final storage = await ref.read(storageServiceProvider.future);
      final pref = await storage.loadPreference() ?? UserPreference.empty();
      await storage.savePreference(pref.copyWith(
        isDarkMode: isDark,
        themeName: ref.read(themeStateProvider).preset.name,
      ));
    } catch (_) {}
  }

  Widget _personalitySelector(BuildContext context, WidgetRef ref) {
    final currentPersonality = ref.watch(personalityProvider).value ?? 'balanced';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.themeOnSurface.withValues(alpha: 0.04),
        border: Border.all(color: context.themeOnSurface.withValues(alpha: 0.07)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Bud Personality',
              style: TextStyle(fontFamily: 'Nunito', fontSize: 13, color: context.themeOnSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 10),
          ...AppConstants.personalities.map((p) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: InkWell(
              onTap: () async {
                await PersonalizationService.setPersonalityMode(p['key']!);
                ref.invalidate(personalityProvider);
              },
              child: Row(children: [
                Icon(
                  currentPersonality == p['key']
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: context.themePrimary, size: 18,
                ),
                const SizedBox(width: 10),
                Text(p['label']!,
                    style: TextStyle(
                      fontFamily: 'Nunito', fontSize: 13,
                      color: currentPersonality == p['key']
                          ? context.themePrimary
                          : context.themeOnSurface,
                    )),
                const Spacer(),
                Text(p['desc']!,
                    style: TextStyle(
                      fontFamily: 'Nunito', fontSize: 11,
                      color: context.themeOnSurface.withValues(alpha: 0.4),
                    )),
              ]),
            ),
          )),
        ],
      ),
    );
  }

  Widget _aiSetupCard(BuildContext context, WidgetRef ref) {
    final llm = ref.watch(llmServiceProvider);
    final isGemma = llm.hasActiveAI;
    final aiStatus = llm.aiStatus;
    final isDownloading = aiStatus.startsWith('downloading') || aiStatus == 'downloading';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.themeOnSurface.withValues(alpha: 0.04),
        border: Border.all(color: context.themeOnSurface.withValues(alpha: 0.07)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(
              isGemma ? Icons.check_circle : Icons.smart_toy_outlined,
              size: 18,
              color: isGemma ? AppColors.success : context.themeOnSurface.withValues(alpha: 0.7),
            ),
            const SizedBox(width: 8),
            Text(
              'Bud AI',
              style: TextStyle(fontFamily: 'Nunito', fontSize: 13, color: context.themeOnSurface.withValues(alpha: 0.7)),
            ),
            const Spacer(),
            Text(
              isGemma ? 'Gemma ✓' : 'Fallback',
              style: TextStyle(fontFamily: 'Nunito', fontSize: 10, color: isGemma ? AppColors.success : AppColors.warning),
            ),
          ]),
          if (isDownloading) ...[
            const SizedBox(height: 12),
            LinearProgressIndicator(
              backgroundColor: context.themeOnSurface.withValues(alpha: 0.06),
              valueColor: AlwaysStoppedAnimation<Color>(context.themePrimary),
            ),
            const SizedBox(height: 6),
              Text('Installing AI model…',
                style: TextStyle(fontFamily: 'Nunito', fontSize: 11, color: context.themeOnSurface.withValues(alpha: 0.5))),
          ] else if (!isGemma) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _setupBudDialog(context, ref),
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.themePrimary,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Activate Bud',
                    style: TextStyle(fontFamily: 'Nunito', fontSize: 13, fontWeight: FontWeight.w500, color: Colors.white)),
              ),
            ),
            Text('Install SmolLM 135M model for on-device AI (no download needed)',
                style: TextStyle(fontFamily: 'Nunito', fontSize: 10, color: context.themeOnSurface.withValues(alpha: 0.4))),
          ],
        ],
      ),
    );
  }

  Future<void> _setupBudDialog(BuildContext context, WidgetRef ref) async {
    final completer = Completer<void>();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => _SetupBudDialogContent(completer: completer, ref: ref),
    );
    await completer.future;
  }

  Widget _section(String title, BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Align(alignment: Alignment.centerLeft, child: Text(title,
        style: TextStyle(
          fontFamily: 'Nunito', fontSize: 11, fontWeight: FontWeight.w500,
          color: context.themeOnSurface.withValues(alpha: 0.4), letterSpacing: 0.8,
        ))),
  );

  Widget _item(BuildContext context, String label, String value) => Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(
      color: context.themeOnSurface.withValues(alpha: 0.04),
      border: Border.all(color: context.themeOnSurface.withValues(alpha: 0.07)),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: TextStyle(fontFamily: 'Nunito', fontSize: 13, color: context.themeOnSurface)),
      Text(value, style: TextStyle(fontFamily: 'Nunito', fontSize: 12, color: context.themePrimary)),
    ]),
  );

  Widget _crisisItem(BuildContext context, String name, String number) => Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(
      color: AppColors.danger.withValues(alpha: 0.06),
      border: Border.all(color: AppColors.danger.withValues(alpha: 0.15)),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(children: [
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(name, style: TextStyle(fontFamily: 'Nunito', fontSize: 13, fontWeight: FontWeight.w500, color: context.themeOnSurface)),
        Text(number, style: TextStyle(fontFamily: 'Nunito', fontSize: 11, color: context.themeOnSurface.withValues(alpha: 0.5))),
      ])),
      Icon(Icons.call_outlined, color: context.themePrimary, size: 20),
    ]),
  );
}

class _SetupBudDialogContent extends StatefulWidget {
  final Completer<void> completer;
  final WidgetRef ref;

  const _SetupBudDialogContent({required this.completer, required this.ref});

  @override
  State<_SetupBudDialogContent> createState() => _SetupBudDialogContentState();
}

class _SetupBudDialogContentState extends State<_SetupBudDialogContent> {
  String? _error;
  bool _done = false;

  @override
  void initState() {
    super.initState();
    _startInstall();
  }

  Future<void> _startInstall() async {
    final result = await GemmaNativeAI.installFromAsset();
    if (!mounted) return;
    if (result == null) {
      widget.ref.invalidate(llmInitProvider);
      try {
        await widget.ref.read(llmInitProvider.future).timeout(const Duration(seconds: 30));
      } catch (_) {}
      if (mounted) { setState(() => _done = true); }
    } else {
      if (mounted) {
        setState(() {
          _error = result;
          _done = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        _error != null ? 'Setup Failed' : _done ? 'AI Ready!' : 'Setting up Bud AI',
        style: TextStyle(fontFamily: 'Caveat', fontSize: 18, color: Theme.of(context).colorScheme.onSurface),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(_error!,
                    style: const TextStyle(fontFamily: 'Nunito', fontSize: 12, color: AppColors.danger)),
              ),
            if (!_done && _error == null) ...[
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: CircularProgressIndicator(),
              ),
              const Text('Installing AI model from app bundle…',
                  style: TextStyle(fontFamily: 'Nunito', fontSize: 11)),
            ],
            if (_done && _error == null) ...[
              const Icon(Icons.check_circle, color: AppColors.success, size: 48),
              const SizedBox(height: 12),
              const Text('Gemma AI is now ready to use!',
                  style: TextStyle(fontFamily: 'Nunito', fontSize: 13)),
            ],
          ],
        ),
      ),
      actions: [
        if (_done)
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              widget.completer.complete();
            },
            child: Text('OK', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
          ),
      ],
    );
  }
}
