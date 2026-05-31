import 'package:intl/intl.dart';

class DateUtils {
  static String formatTime(DateTime dt) {
    final now = DateTime.now();
    if (dt.day == now.day && dt.month == now.month && dt.year == now.year) {
      return 'Today';
    }
    if (dt.day == now.day - 1 && dt.month == now.month && dt.year == now.year) {
      return 'Yesterday';
    }
    return DateFormat('MMM d').format(dt);
  }

  static String formatTimeOfDay(DateTime dt) {
    return DateFormat('h:mm a').format(dt);
  }

  static String formatDateTime(DateTime dt) {
    final now = DateTime.now();
    if (dt.day == now.day && dt.month == now.month && dt.year == now.year) {
      return 'Today at ${DateFormat("h:mm a").format(dt)}';
    }
    return DateFormat('MMM d, yyyy').format(dt);
  }

  static int calculateStreak(List<DateTime> dates) {
    if (dates.isEmpty) return 0;
    final sorted = List<DateTime>.from(dates)..sort((a, b) => b.compareTo(a));
    int streak = 0;
    DateTime? lastDate;
    for (final date in sorted) {
      if (lastDate == null) {
        streak = 1;
        lastDate = date;
      } else {
        final diff = lastDate.difference(date).inDays;
        if (diff == 1) {
          streak++;
          lastDate = date;
        } else {
          break;
        }
      }
    }
    return streak;
  }

  static bool isToday(DateTime dt) {
    final now = DateTime.now();
    return dt.day == now.day && dt.month == now.month && dt.year == now.year;
  }
}
