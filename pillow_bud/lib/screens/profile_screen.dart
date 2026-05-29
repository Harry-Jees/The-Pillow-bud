import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_colors.dart';
import '../config/constants.dart';
import 'onboarding_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Me')),
      body: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (ctx, snap) {
          final name = snap.data?.getString('user_name') ?? 'Friend';
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 16),
                // Avatar
                Container(
                  width: 64, height: 64,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [AppColors.primary, AppColors.secondary]),
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: Text(name.isNotEmpty ? name[0].toUpperCase() : 'B', style: const TextStyle(fontFamily: 'Lora', fontSize: 26, fontWeight: FontWeight.w600, color: Colors.white))),
                ),
                const SizedBox(height: 12),
                Text(name, style: const TextStyle(fontFamily: 'Lora', fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.textPrimaryDark)),
                Text('Member since today', style: TextStyle(fontFamily: 'DM Sans', fontSize: 11, color: Colors.white.withOpacity(0.4))),
                const SizedBox(height: 28),
                _section('ABOUT'),
                _item('App Name', 'Pillow Bud'),
                _item('Version', '1.0.0'),
                const SizedBox(height: 20),
                _section('CRISIS RESOURCES'),
                _crisisItem(AppConstants.icallName, AppConstants.icallNumber),
                _crisisItem(AppConstants.vandrevalaName, AppConstants.vandrevalaNumber),
                _crisisItem(AppConstants.aasraName, AppConstants.aasraNumber),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity, height: 46,
                  child: OutlinedButton(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.clear();
                      if (!ctx.mounted) return;
                      Navigator.of(ctx).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const OnboardingScreen()), (_) => false);
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.white.withOpacity(0.15)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text('Reset App', style: TextStyle(fontFamily: 'DM Sans', fontSize: 13, color: Colors.white.withOpacity(0.5))),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _section(String title) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Align(alignment: Alignment.centerLeft, child: Text(title, style: TextStyle(fontFamily: 'DM Sans', fontSize: 11, fontWeight: FontWeight.w500, color: Colors.white.withOpacity(0.4), letterSpacing: 0.8))),
  );

  Widget _item(String label, String value) => Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(color: Colors.white.withOpacity(0.04), border: Border.all(color: Colors.white.withOpacity(0.07)), borderRadius: BorderRadius.circular(10)),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: const TextStyle(fontFamily: 'DM Sans', fontSize: 13, color: AppColors.textPrimaryDark)),
      Text(value, style: const TextStyle(fontFamily: 'DM Sans', fontSize: 12, color: AppColors.primary)),
    ]),
  );

  Widget _crisisItem(String name, String number) => Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(color: AppColors.danger.withOpacity(0.06), border: Border.all(color: AppColors.danger.withOpacity(0.15)), borderRadius: BorderRadius.circular(10)),
    child: Row(children: [
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(name, style: const TextStyle(fontFamily: 'DM Sans', fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textPrimaryDark)),
        Text(number, style: TextStyle(fontFamily: 'DM Sans', fontSize: 11, color: Colors.white.withOpacity(0.5))),
      ])),
      const Icon(Icons.call_outlined, color: AppColors.primary, size: 20),
    ]),
  );
}
