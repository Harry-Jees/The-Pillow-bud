import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final moods = ['😤', '😌', '😢', '😊', '😌', '😊', '😊'];
    final bars = [0.4, 0.7, 0.3, 0.8, 0.6, 0.9, 0.85];

    return Scaffold(
      appBar: AppBar(title: const Text('Your Insights')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Streak card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(children: [
                const Text('🔥', style: TextStyle(fontSize: 28)),
                const SizedBox(width: 14),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('7 days', style: TextStyle(fontFamily: 'Lora', fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.primary)),
                  Text('Current check-in streak', style: TextStyle(fontFamily: 'DM Sans', fontSize: 11, color: Colors.white.withOpacity(0.5))),
                ]),
              ]),
            ),
            const SizedBox(height: 24),
            Text('Mood this week', style: TextStyle(fontFamily: 'DM Sans', fontSize: 12, color: Colors.white.withOpacity(0.4))),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                border: Border.all(color: Colors.white.withOpacity(0.07)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: List.generate(7, (i) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(children: [
                    SizedBox(width: 32, child: Text(days[i], style: TextStyle(fontFamily: 'DM Sans', fontSize: 11, color: Colors.white.withOpacity(0.4)))),
                    const SizedBox(width: 8),
                    Expanded(child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: bars[i],
                        backgroundColor: Colors.white.withOpacity(0.06),
                        valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                        minHeight: 8,
                      ),
                    )),
                    const SizedBox(width: 8),
                    Text(moods[i], style: const TextStyle(fontSize: 14)),
                  ]),
                )),
              ),
            ),
            const SizedBox(height: 24),
            Text('Emotional patterns', style: TextStyle(fontFamily: 'DM Sans', fontSize: 12, color: Colors.white.withOpacity(0.4))),
            const SizedBox(height: 12),
            ...[
              {'emoji': '😊', 'label': 'Happy', 'count': '5 times', 'color': AppColors.success},
              {'emoji': '😌', 'label': 'Calm', 'count': '4 times', 'color': AppColors.secondary},
              {'emoji': '😟', 'label': 'Anxious', 'count': '3 times', 'color': AppColors.warning},
              {'emoji': '😢', 'label': 'Sad', 'count': '2 times', 'color': AppColors.danger},
            ].map((item) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                border: Border.all(color: Colors.white.withOpacity(0.07)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(children: [
                Text(item['emoji'] as String, style: const TextStyle(fontSize: 18)),
                const SizedBox(width: 12),
                Text(item['label'] as String, style: const TextStyle(fontFamily: 'DM Sans', fontSize: 13, color: AppColors.textPrimaryDark)),
                const Spacer(),
                Text(item['count'] as String, style: TextStyle(fontFamily: 'DM Sans', fontSize: 12, color: item['color'] as Color)),
              ]),
            )),
          ],
        ),
      ),
    );
  }
}
