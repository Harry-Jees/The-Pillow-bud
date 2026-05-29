import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../config/constants.dart';
import 'chat_screen.dart';
import 'journal_screen.dart';
import 'insights_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userName;
  const HomeScreen({super.key, required this.userName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;
  String _mood = '😌';

  @override
  Widget build(BuildContext context) {
    final tabs = [
      _HomeTab(userName: widget.userName, mood: _mood, onMoodChanged: (m) => setState(() => _mood = m)),
      const ChatScreen(),
      const JournalScreen(),
      const InsightsScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: tabs[_tab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tab,
        onTap: (i) => setState(() => _tab = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), activeIcon: Icon(Icons.chat_bubble), label: 'Bud'),
          BottomNavigationBarItem(icon: Icon(Icons.book_outlined), activeIcon: Icon(Icons.book), label: 'Journal'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined), activeIcon: Icon(Icons.bar_chart), label: 'Insights'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Me'),
        ],
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  final String userName;
  final String mood;
  final ValueChanged<String> onMoodChanged;

  const _HomeTab({required this.userName, required this.mood, required this.onMoodChanged});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text('Hey, $userName 👋', style: const TextStyle(fontFamily: 'Lora', fontSize: 24, fontWeight: FontWeight.w500, color: AppColors.textPrimaryDark)),
            const SizedBox(height: 24),
            // Mood picker
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                border: Border.all(color: Colors.white.withOpacity(0.07)),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('How are you feeling?', style: TextStyle(fontFamily: 'DM Sans', fontSize: 12, color: Colors.white.withOpacity(0.4))),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: AppConstants.moods.map((m) => GestureDetector(
                      onTap: () => onMoodChanged(m['emoji']!),
                      child: Column(children: [
                        Text(m['emoji']!, style: TextStyle(fontSize: 26, color: mood == m['emoji'] ? null : const Color(0x99FFFFFF))),
                        const SizedBox(height: 4),
                        Text(m['label']!, style: TextStyle(fontFamily: 'DM Sans', fontSize: 9, color: Colors.white.withOpacity(mood == m['emoji'] ? 0.8 : 0.35))),
                      ]),
                    )).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Bud preview
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('🌸', style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 12),
                  Expanded(child: Text('I\'m here whenever you need to talk. No judgment, just listening.', style: TextStyle(fontFamily: 'DM Sans', fontSize: 13, color: Colors.white.withOpacity(0.75), height: 1.6))),
                ],
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity, height: 50,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ChatScreen())),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Talk to Bud', style: TextStyle(fontFamily: 'DM Sans', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
