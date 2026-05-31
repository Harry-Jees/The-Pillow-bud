import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

import '../theme/theme_colors.dart';
import '../providers/ai_service_provider.dart';
import '../providers/llm_provider.dart';
import '../providers/storage_provider.dart';
import '../providers/theme_provider.dart';
import 'onboarding_screen.dart';
import 'home_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  String _status = 'Initialising...';

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _ctrl.forward();
    _navigate();
  }

  Future<void> _navigate() async {
    // Start AI initialization in background
    final aiInit = ref.read(localAIServiceProvider.future)
        .then((_) {
          if (mounted) {
            setState(() => _status = 'Ready');
            ref.read(llmInitProvider);
          }
        })
        .onError((_, __) {
          if (mounted) {
            setState(() => _status = 'Ready');
            ref.read(llmInitProvider);
          }
        });

    // Wait a short moment for UI, then proceed regardless of AI state
    await Future.any([
      aiInit,
      Future.delayed(const Duration(milliseconds: 500)),
    ]);
    if (!mounted) return;

    final storage = await ref.read(storageServiceProvider.future);
    final pref = await storage.loadPreference();

    if (pref != null) {
      ref.read(themeStateProvider.notifier).initFromSaved(
        pref.themeName,
        pref.isDarkMode,
      );
    }

    if (pref != null && pref.lockScreenEnabled) {
      final authed = await _authenticate();
      if (!mounted) return;
      if (!authed) {
        _status = 'Authentication required';
        return;
      }
    }

    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;

    final done = pref?.onboardingCompleted ?? false;
    final name = pref?.userName ?? '';

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => done && name.isNotEmpty
            ? const HomeScreen()
            : const OnboardingScreen(),
      ),
    );
  }

  Future<bool> _authenticate() async {
    setState(() => _status = 'Authentication required');
    final auth = LocalAuthentication();
    try {
      final canCheck = await auth.canCheckBiometrics;
      final isSupported = await auth.isDeviceSupported();
      if (!canCheck && !isSupported) return true;
      return await auth.authenticate(
        localizedReason: 'Unlock Pillow Bud to continue',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
        ),
      );
    } catch (_) {
      return true;
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fade,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/app_icon.png',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Text('Pillow Bud',
                  style: TextStyle(
                      fontFamily: 'Caveat',
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: context.themeOnSurface)),
              const SizedBox(height: 8),
              Text('YOUR EMOTIONAL COMPANION',
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 10,
                      color: context.themeOnSurface.withValues(alpha: 0.4),
                      letterSpacing: 1.5)),
              const SizedBox(height: 24),
              SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    context.themePrimary.withValues(alpha: 0.6),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(_status,
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 11,
                      color: context.themeOnSurface.withValues(alpha: 0.35))),
            ],
          ),
        ),
      ),
    );
  }
}
