import '../config/constants.dart';

class CrisisDetector {
  static bool detect(String message) {
    final lower = message.toLowerCase();
    return AppConstants.crisisTriggers.any((t) => lower.contains(t));
  }
}
