import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_colors.dart';
import 'onboarding_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _ctrl.forward();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    final prefs = await SharedPreferences.getInstance();
    final done = prefs.getBool('onboarding_done') ?? false;
    final name = prefs.getString('user_name') ?? '';
    if (!mounted) return;
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (_) => done && name.isNotEmpty ? HomeScreen(userName: name) : const OnboardingScreen(),
    ));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fade,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80, height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(child: Text('🛏️', style: TextStyle(fontSize: 40))),
              ),
              const SizedBox(height: 20),
              const Text('Pillow Bud', style: TextStyle(fontFamily: 'Lora', fontSize: 28, fontWeight: FontWeight.w600, color: AppColors.textPrimaryDark)),
              const SizedBox(height: 8),
              Text('YOUR EMOTIONAL COMPANION', style: TextStyle(fontFamily: 'DM Sans', fontSize: 10, color: Colors.white.withOpacity(0.4), letterSpacing: 1.5)),
            ],
          ),
        ),
      ),
    );
  }
}
