import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_colors.dart';
import '../config/constants.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageCtrl = PageController();
  final _nameCtrl = TextEditingController();
  int _page = 0;
  String _personality = 'balanced';

  @override
  void dispose() { _pageCtrl.dispose(); _nameCtrl.dispose(); super.dispose(); }

  void _next() {
    if (_page < 4) {
      _pageCtrl.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      _finish();
    }
  }

  Future<void> _finish() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', _nameCtrl.text.trim());
    await prefs.setString('personality', _personality);
    await prefs.setBool('onboarding_done', true);
    if (!mounted) return;
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (_) => HomeScreen(userName: _nameCtrl.text.trim()),
    ));
  }

  Widget _btn(String label, {bool enabled = true}) => SizedBox(
    width: 280, height: 50,
    child: ElevatedButton(
      onPressed: enabled ? _next : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        disabledBackgroundColor: AppColors.primary.withOpacity(0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Text(label, style: const TextStyle(fontFamily: 'DM Sans', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageCtrl,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (i) => setState(() => _page = i),
        children: [_page0(), _page1(), _page2(), _page3(), _page4()],
      ),
    );
  }

  Widget _page0() => Center(child: Padding(padding: const EdgeInsets.all(24), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    const Text('Welcome to Pillow Bud', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Lora', fontSize: 28, fontWeight: FontWeight.w600, color: AppColors.textPrimaryDark)),
    const SizedBox(height: 16),
    Text('Your emotional companion, always listening', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'DM Sans', fontSize: 14, color: Colors.white.withOpacity(0.65))),
    const SizedBox(height: 40),
    _btn('Begin'),
  ])));

  Widget _page1() => Padding(padding: const EdgeInsets.all(24), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    const Text('What\'s your name?', style: TextStyle(fontFamily: 'Lora', fontSize: 24, fontWeight: FontWeight.w500, color: AppColors.textPrimaryDark)),
    const SizedBox(height: 32),
    TextField(
      controller: _nameCtrl,
      autofocus: true,
      onChanged: (_) => setState(() {}),
      style: const TextStyle(color: AppColors.textPrimaryDark, fontFamily: 'DM Sans'),
      decoration: InputDecoration(
        hintText: 'Enter your name...',
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.4), fontFamily: 'DM Sans'),
        filled: true, fillColor: Colors.white.withOpacity(0.04),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: AppColors.primary)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    ),
    const SizedBox(height: 32),
    _btn('Continue', enabled: _nameCtrl.text.trim().isNotEmpty),
  ]));

  Widget _page2() => Padding(padding: const EdgeInsets.all(24), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    const Text('How should Bud be with you?', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Lora', fontSize: 22, fontWeight: FontWeight.w500, color: AppColors.textPrimaryDark)),
    const SizedBox(height: 32),
    ...AppConstants.personalities.map((p) => Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () => setState(() => _personality = p['key']!),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _personality == p['key'] ? AppColors.primary.withOpacity(0.12) : Colors.white.withOpacity(0.04),
            border: Border.all(color: _personality == p['key'] ? AppColors.primary.withOpacity(0.4) : Colors.white.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(children: [
            Icon(_personality == p['key'] ? Icons.radio_button_checked : Icons.radio_button_unchecked, color: AppColors.primary, size: 18),
            const SizedBox(width: 12),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(p['label']!, style: const TextStyle(fontFamily: 'DM Sans', fontSize: 14, color: AppColors.textPrimaryDark)),
              Text(p['desc']!, style: TextStyle(fontFamily: 'DM Sans', fontSize: 12, color: Colors.white.withOpacity(0.5))),
            ]),
          ]),
        ),
      ),
    )),
    const SizedBox(height: 24),
    _btn('Continue'),
  ]));

  Widget _page3() => Center(child: Padding(padding: const EdgeInsets.all(32), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    const Text('Important', style: TextStyle(fontFamily: 'Lora', fontSize: 24, fontWeight: FontWeight.w500, color: AppColors.textPrimaryDark)),
    const SizedBox(height: 24),
    Text('Bud is your emotional companion, not a licensed therapist. For serious mental health concerns, please talk to a professional or call a crisis helpline.', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'DM Sans', fontSize: 14, color: Colors.white.withOpacity(0.7), height: 1.6)),
    const SizedBox(height: 40),
    _btn('I understand'),
  ])));

  Widget _page4() => Center(child: Padding(padding: const EdgeInsets.all(24), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    const Text('You\'re all set!', style: TextStyle(fontFamily: 'Lora', fontSize: 28, fontWeight: FontWeight.w600, color: AppColors.textPrimaryDark)),
    const SizedBox(height: 16),
    Text('Bud is ready to listen. Let\'s begin.', style: TextStyle(fontFamily: 'DM Sans', fontSize: 14, color: Colors.white.withOpacity(0.65))),
    const SizedBox(height: 40),
    _btn('Let\'s go'),
  ])));
}
