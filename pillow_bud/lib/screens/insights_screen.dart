import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../theme/app_colors.dart';
import '../theme/theme_colors.dart';
import '../models/journal_entry.dart';
import '../providers/app_providers.dart';

class InsightsScreen extends ConsumerWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(journalEntriesProvider);
    return _InsightsBody(entries: entries);
  }
}

class _InsightsBody extends StatelessWidget {
  final List<JournalEntry> entries;

  const _InsightsBody({required this.entries});

  // Map emoji mood keys to category labels for display.
  static const _moodLabels = {
    '😤': 'Stressed',
    '😢': 'Sad',
    '😌': 'Calm',
    '😊': 'Happy',
    '😟': 'Anxious',
    '😄': 'Great',
  };

  Color _moodColor(String mood, BuildContext context) {
    switch (mood) {
      case '😤': return AppColors.warning;
      case '😢': return AppColors.danger;
      case '😌': return context.themeSecondary;
      case '😊': return AppColors.success;
      case '😟': return AppColors.warning;
      case '😄': return AppColors.success;
      default: return AppColors.success;
    }
  }

  @override
  Widget build(BuildContext context) {
    final streak = _computeStreak();
    final weekMoods = _computeWeekMoods();
    final moodCounts = _computeMoodCounts(context);

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
                color: context.themePrimary.withValues(alpha: 0.1),
                border: Border.all(color: context.themePrimary.withValues(alpha: 0.2)),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(children: [
                const Text('🔥', style: TextStyle(fontSize: 28)),
                const SizedBox(width: 14),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('$streak days',
                      style: TextStyle(
                          fontFamily: 'Caveat',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: context.themePrimary)),
                  Text('Current check-in streak',
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 11,
                          color: context.themeOnSurface.withValues(alpha: 0.5))),
                ]),
              ]),
            ),
            const SizedBox(height: 24),
            Text('Mood this week',
                style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 12,
                    color: context.themeOnSurface.withValues(alpha: 0.4))),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.themeOnSurface.withValues(alpha: 0.04),
                border: Border.all(color: context.themeOnSurface.withValues(alpha: 0.07)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: weekMoods.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Text('No mood data this week',
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 12,
                                color: context.themeOnSurface.withValues(alpha: 0.35))),
                      ),
                    )
                  : Column(
                      children: weekMoods.map((wm) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(children: [
                              SizedBox(
                                  width: 32,
                                  child: Text(wm['day'] as String,
                                      style: TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: 11,
                                           color: context.themeOnSurface.withValues(alpha: 0.4)))),
                              const SizedBox(width: 8),
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: LinearProgressIndicator(
                                    value: wm['value'] as double,
                                    backgroundColor:
                                        context.themeOnSurface.withValues(alpha: 0.06),
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        _moodColor(wm['mood'] as String, context)),
                                    minHeight: 8,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(wm['mood'] as String,
                                  style: const TextStyle(fontSize: 14)),
                            ]),
                          )).toList(),
                    ),
            ),
            const SizedBox(height: 24),
            Text('Emotional patterns',
                style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 12,
                    color: context.themeOnSurface.withValues(alpha: 0.4))),
            const SizedBox(height: 12),
            if (moodCounts.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text('No journal entries yet',
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 12,
                          color: context.themeOnSurface.withValues(alpha: 0.35))),
                ),
              )
            else
              ...moodCounts.map(
                (mc) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: context.themeOnSurface.withValues(alpha: 0.04),
                    border: Border.all(color: context.themeOnSurface.withValues(alpha: 0.07)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(children: [
                    Text(mc['emoji'] as String,
                        style: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 12),
                    Text(mc['label'] as String,
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 13,
                            color: context.themeOnSurface)),
                    const Spacer(),
                    Text(mc['count'] as String,
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 12,
                            color: mc['color'] as Color)),
                  ]),
                ),
              ),
          ],
        ),
      ),
    );
  }

  int _computeStreak() {
    if (entries.isEmpty) return 0;
    final uniqueDates = entries
        .map((e) => DateTime(e.date.year, e.date.month, e.date.day))
        .toSet()
        .toList()
      ..sort((a, b) => b.compareTo(a));

    int streak = 0;
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    final yesterdayDate = todayDate.subtract(const Duration(days: 1));

    if (uniqueDates.isNotEmpty && uniqueDates.first == todayDate) {
      streak = 1;
      for (int i = 1; i < uniqueDates.length; i++) {
        final expected = uniqueDates[i - 1].subtract(const Duration(days: 1));
        if (uniqueDates[i] == expected) {
          streak++;
        } else {
          break;
        }
      }
    } else if (uniqueDates.isNotEmpty && uniqueDates.first == yesterdayDate) {
      streak = 1;
      for (int i = 1; i < uniqueDates.length; i++) {
        final expected = uniqueDates[i - 1].subtract(const Duration(days: 1));
        if (uniqueDates[i] == expected) {
          streak++;
        } else {
          break;
        }
      }
    }
    return streak;
  }

  List<Map<String, dynamic>> _computeWeekMoods() {
    final daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final now = DateTime.now();
    final result = <Map<String, dynamic>>[];

    for (int i = 6; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      final dateStr = DateFormat('yyyyMMdd').format(date);
      final dayIndex = (now.weekday - i - 1) % 7;
      final dayLabel = daysOfWeek[dayIndex < 0 ? dayIndex + 7 : dayIndex];

      final dayEntries = entries.where((e) =>
          DateFormat('yyyyMMdd').format(e.date) == dateStr);
      if (dayEntries.isNotEmpty) {
        // Use the mood from the last entry of that day.
        final mood = dayEntries.last.mood;
        // Assign a value 0.3–1.0 based on mood positivity.
        final value = _moodValue(mood);
        result.add({
          'day': dayLabel,
          'mood': mood,
          'value': value,
        });
      }
    }
    return result;
  }

  double _moodValue(String mood) {
    switch (mood) {
      case '😄':
        return 1.0;
      case '😊':
        return 0.85;
      case '😌':
        return 0.7;
      case '😟':
        return 0.5;
      case '😤':
        return 0.4;
      case '😢':
        return 0.3;
      default:
        return 0.6;
    }
  }

  List<Map<String, dynamic>> _computeMoodCounts(BuildContext context) {
    if (entries.isEmpty) return [];

    final counts = <String, int>{};
    for (final e in entries) {
      counts[e.mood] = (counts[e.mood] ?? 0) + 1;
    }

    final sorted = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sorted
        .map((e) => {
              'emoji': e.key,
              'label': _moodLabels[e.key] ?? e.key,
              'count': '${e.value} time${e.value == 1 ? '' : 's'}',
              'color': _moodColor(e.key, context),
            })
        .toList();
  }
}
