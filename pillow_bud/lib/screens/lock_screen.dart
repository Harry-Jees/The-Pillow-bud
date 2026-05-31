import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

import '../theme/theme_colors.dart';

class LockScreen extends StatefulWidget {
  final Widget child;

  const LockScreen({super.key, required this.child});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  final _auth = LocalAuthentication();
  bool _locked = true;
  bool _authenticating = false;

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  Future<void> _authenticate() async {
    setState(() => _authenticating = true);

    try {
      final canCheck = await _auth.canCheckBiometrics;
      final isDeviceSupported = await _auth.isDeviceSupported();

      if (!canCheck && !isDeviceSupported) {
        setState(() {
          _locked = false;
          _authenticating = false;
        });
        return;
      }

      final didAuth = await _auth.authenticate(
        localizedReason: 'Unlock Pillow Bud to continue',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
        ),
      );

      setState(() {
        _locked = !didAuth;
        _authenticating = false;
      });
    } catch (e) {
      setState(() {
        _locked = false;
        _authenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_locked) return widget.child;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              context.themeBg,
              context.themeBg,
              context.themePrimary.withValues(alpha: 0.15),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: context.themePrimary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text('🛏️', style: TextStyle(fontSize: 40)),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Pillow Bud',
                style: TextStyle(
                  fontFamily: 'Caveat',
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: context.themeOnSurface,
                ),
              ),
              const SizedBox(height: 40),
              if (_authenticating)
                Column(
                  children: [
                    SizedBox(
                      width: 48,
                      height: 48,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          context.themePrimary.withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Authenticating...',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 14,
                        color: context.themeOnSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    Icon(
                      Icons.fingerprint,
                      size: 64,
                      color: context.themePrimary.withValues(alpha: 0.8),
                    ),
                    const SizedBox(height: 16),
                      Text(
                        'Unlock with biometrics\nor device PIN',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 14,
                          color: context.themeOnSurface.withValues(alpha: 0.6),
                        ),
                    ),
                    const SizedBox(height: 24),
                    TextButton.icon(
                      onPressed: _authenticate,
                      icon: Icon(
                        Icons.lock_open,
                        color: context.themePrimary.withValues(alpha: 0.8),
                        size: 20,
                      ),
                      label: Text(
                        'Tap to unlock',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 14,
                          color: context.themePrimary.withValues(alpha: 0.8),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
