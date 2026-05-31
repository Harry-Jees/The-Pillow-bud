import '../config/constants.dart';

class CrisisDetector {
  static bool detect(String message) {
    final lower = message.toLowerCase();
    return AppConstants.crisisTriggers.any((t) => lower.contains(t));
  }

  static String getCrisisResourceMessage() {
    return '''I care about you deeply, and I'm concerned.

Please reach out to someone right now:

🆘 ${AppConstants.icallName}
   ${AppConstants.icallNumber}

🆘 ${AppConstants.vandrevalaName}
   ${AppConstants.vandrevalaNumber}

🆘 ${AppConstants.aasraName}
   ${AppConstants.aasraNumber}

You deserve real, professional support.
Please call now. 💙''';
  }
}
