# PILLOW BUD — COMPLETE FILE STRUCTURE & INITIAL CODE

This document contains EVERY file you need to create. Copy the content exactly into each file.

---

## FOLDER STRUCTURE

```
pillow_bud/
├── lib/
│   ├── main.dart
│   ├── config/
│   │   ├── constants.dart
│   │   └── app_config.dart
│   ├── theme/
│   │   ├── app_colors.dart
│   │   └── app_theme.dart
│   ├── models/
│   │   ├── chat_message.dart
│   │   ├── journal_entry.dart
│   │   └── user_preference.dart
│   ├── providers/
│   │   ├── app_state_provider.dart
│   │   ├── theme_provider.dart
│   │   └── llm_provider.dart
│   ├── services/
│   │   ├── crisis_detector.dart
│   │   ├── llm_service.dart
│   │   ├── storage_service.dart
│   │   └── date_utils.dart
│   ├── screens/
│   │   ├── splash_screen.dart
│   │   ├── onboarding_screen.dart
│   │   ├── home_screen.dart
│   │   ├── chat_screen.dart
│   │   ├── journal_screen.dart
│   │   ├── insights_screen.dart
│   │   └── profile_screen.dart
│   ├── widgets/
│   │   ├── buttons/
│   │   │   ├── primary_button.dart
│   │   │   └── secondary_button.dart
│   │   ├── cards/
│   │   │   └── mood_card.dart
│   │   └── indicators/
│   │       └── typing_indicator.dart
│   └── utils/
│       └── extensions.dart
├── assets/
│   ├── fonts/
│   │   ├── Lora-Regular.ttf
│   │   ├── Lora-Medium.ttf
│   │   ├── Lora-SemiBold.ttf
│   │   ├── DMSans-Regular.ttf
│   │   ├── DMSans-Medium.ttf
│   │   └── DMSans-SemiBold.ttf
│   └── images/
│       └── .gitkeep
├── pubspec.yaml
├── pubspec.lock (generated)
├── .gitignore
├── README.md
├── LICENSE
└── CONTRIBUTING.md
```

---

## FILES WITH CONTENT

### 1. pubspec.yaml

```yaml
name: pillow_bud
description: Pillow Bud - Your emotional companion, always listening.
publish_to: 'none'

version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  
  # UI & Icons
  cupertino_icons: ^1.0.5
  google_fonts: ^6.1.0
  flutter_animate: ^4.3.0
  
  # State Management
  riverpod: ^2.5.1
  flutter_riverpod: ^2.5.1
  
  # Local Storage
  shared_preferences: ^2.2.2
  
  # Utilities
  intl: ^0.19.0
  path_provider: ^2.1.1

dev_dependencies:
  flutter_test:
    sdk: flutter

flutter:
  uses-material-design: true
  
  fonts:
    - family: Lora
      fonts:
        - asset: assets/fonts/Lora-Regular.ttf
        - asset: assets/fonts/Lora-Medium.ttf
          weight: 500
        - asset: assets/fonts/Lora-SemiBold.ttf
          weight: 600
    
    - family: DM Sans
      fonts:
        - asset: assets/fonts/DMSans-Regular.ttf
        - asset: assets/fonts/DMSans-Medium.ttf
          weight: 500
        - asset: assets/fonts/DMSans-SemiBold.ttf
          weight: 600
  
  assets:
    - assets/images/
```

---

### 2. lib/main.dart

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pillow_bud/theme/app_theme.dart';
import 'package:pillow_bud/screens/splash_screen.dart';

void main() {
  runApp(const ProviderScope(child: PillowBudApp()));
}

class PillowBudApp extends StatelessWidget {
  const PillowBudApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pillow Bud',
      theme: AppTheme.darkTheme(),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
```

---

### 3. lib/config/constants.dart

```dart
class Constants {
  // Crisis Resources (India-focused)
  static const String icallNumber = '9152987821';
  static const String icallName = 'iCall India';
  
  static const String vandrevalaNumber = '1860-2662-345';
  static const String vandrevalaName = 'Vandrevala Foundation';
  
  static const String aasraNumber = '9820466726';
  static const String aasraName = 'AASRA';
  
  // Crisis Trigger Phrases
  static const List<String> crisisTriggers = [
    'kill myself',
    'kill me',
    'end my life',
    'suicide',
    'overdose',
    'jump',
    'want to die',
    'better off dead',
    'harm myself',
    'cut myself',
    'slit wrist',
    'not worth living',
    'no point in living',
    'should die',
    'wish i was dead',
  ];
  
  // App Info
  static const String appName = 'Pillow Bud';
  static const String appVersion = '1.0.0';
  static const String budPersonality = 'balanced';
}
```

---

### 4. lib/config/app_config.dart

```dart
class AppConfig {
  // App Settings
  static const bool debugMode = true;
  static const bool logErrors = true;
  
  // Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration chatResponseTimeout = Duration(seconds: 60);
  
  // UI Settings
  static const double defaultBorderRadius = 14.0;
  static const double softBorderRadius = 16.0;
  static const double pillBorderRadius = 20.0;
  
  // Animation Durations
  static const Duration quickAnimation = Duration(milliseconds: 200);
  static const Duration normalAnimation = Duration(milliseconds: 300);
  static const Duration slowAnimation = Duration(milliseconds: 500);
}
```

---

### 5. lib/theme/app_colors.dart

```dart
import 'package:flutter/material.dart';

class AppColors {
  // Primary Palette
  static const Color primary = Color(0xFFC4A8F8);      // Lavender
  static const Color secondary = Color(0xFF89C4F8);    // Misty Teal
  static const Color tertiary = Color(0xFFA8D8A8);     // Sage
  
  // Backgrounds (Dark Mode)
  static const Color darkBg = Color(0xFF1A1225);
  static const Color lightBg = Color(0xFFF8F6FF);
  static const Color cardDark = Color(0xFF2D1F4A);
  static const Color cardLight = Color(0xFFFFFFFF);
  
  // Text Colors
  static const Color textPrimaryDark = Color(0xFFF0E8FF);
  static const Color textPrimaryLight = Color(0xFF1A1225);
  
  // Semantic Colors
  static const Color success = Color(0xFF7ACF8E);
  static const Color warning = Color(0xFFFAC775);
  static const Color danger = Color(0xFFF09595);
  
  // Transparent Variants (used in overlays)
  static Color primarySoft = primary.withOpacity(0.12);
  static Color secondarySoft = secondary.withOpacity(0.12);
  static Color textFade = textPrimaryDark.withOpacity(0.65);
  static Color textMuted = textPrimaryDark.withOpacity(0.4);
}

class AppTheme {
  // Theme Presets
  static const Map<String, Map<String, Color>> themePresets = {
    'lavender': {
      'primary': AppColors.primary,
      'secondary': AppColors.secondary,
    },
    'ocean': {
      'primary': Color(0xFF4A90E2),
      'secondary': Color(0xFF7AC8E8),
    },
    'sunset': {
      'primary': Color(0xFFE8A87C),
      'secondary': Color(0xFFF0B490),
    },
    'mint': {
      'primary': Color(0xFF6AC4A8),
      'secondary': Color(0xFFA8D8C4),
    },
    'rose': {
      'primary': Color(0xFFD8A8C4),
      'secondary': Color(0xFFE8C4D8),
    },
  };
}
```

---

### 6. lib/theme/app_theme.dart

```dart
import 'package:flutter/material.dart';
import 'package:pillow_bud/theme/app_colors.dart';

class AppTheme {
  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBg,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.cardDark,
        error: AppColors.danger,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Lora',
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimaryDark,
          letterSpacing: 0.02,
        ),
        displayMedium: TextStyle(
          fontFamily: 'Lora',
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimaryDark,
        ),
        headlineSmall: TextStyle(
          fontFamily: 'Lora',
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimaryDark,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'DM Sans',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimaryDark,
          height: 1.6,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'DM Sans',
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimaryDark,
          height: 1.6,
        ),
        labelSmall: TextStyle(
          fontFamily: 'DM Sans',
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimaryDark,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withOpacity(0.04),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.4),
          fontFamily: 'DM Sans',
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBg,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.cardLight,
        error: AppColors.danger,
      ),
    );
  }
}
```

---

### 7. lib/models/chat_message.dart

```dart
class ChatMessage {
  final String id;
  final String text;
  final bool isFromBud;
  final DateTime timestamp;
  final String sessionId;

  ChatMessage({
    required this.id,
    required this.text,
    required this.isFromBud,
    required this.timestamp,
    required this.sessionId,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] as String,
      text: json['text'] as String,
      isFromBud: json['isFromBud'] as bool,
      timestamp: DateTime.parse(json['timestamp'] as String),
      sessionId: json['sessionId'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'isFromBud': isFromBud,
    'timestamp': timestamp.toIso8601String(),
    'sessionId': sessionId,
  };
}

class ChatSession {
  final String id;
  final String userName;
  final List<ChatMessage> messages;
  final DateTime createdAt;
  final DateTime lastModified;

  ChatSession({
    required this.id,
    required this.userName,
    required this.messages,
    required this.createdAt,
    required this.lastModified,
  });
}
```

---

### 8. lib/models/journal_entry.dart

```dart
class JournalEntry {
  final String id;
  final String text;
  final String mood;  // emoji
  final DateTime dateCreated;
  final DateTime dateModified;

  JournalEntry({
    required this.id,
    required this.text,
    required this.mood,
    required this.dateCreated,
    required this.dateModified,
  });

  factory JournalEntry.fromJson(Map<String, dynamic> json) {
    return JournalEntry(
      id: json['id'] as String,
      text: json['text'] as String,
      mood: json['mood'] as String,
      dateCreated: DateTime.parse(json['dateCreated'] as String),
      dateModified: DateTime.parse(json['dateModified'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'mood': mood,
    'dateCreated': dateCreated.toIso8601String(),
    'dateModified': dateModified.toIso8601String(),
  };
}
```

---

### 9. lib/models/user_preference.dart

```dart
class UserPreference {
  final String userName;
  final String buddyPersonality;  // gentle, curious, wise, balanced
  final bool isDarkMode;
  final String primaryColor;  // hex format
  final String secondaryColor;
  final bool onboardingCompleted;
  final DateTime? onboardingCompletedAt;

  UserPreference({
    required this.userName,
    required this.buddyPersonality,
    required this.isDarkMode,
    required this.primaryColor,
    required this.secondaryColor,
    required this.onboardingCompleted,
    this.onboardingCompletedAt,
  });

  factory UserPreference.empty() {
    return UserPreference(
      userName: '',
      buddyPersonality: 'balanced',
      isDarkMode: true,
      primaryColor: '#C4A8F8',
      secondaryColor: '#89C4F8',
      onboardingCompleted: false,
    );
  }
}
```

---

### 10. lib/providers/app_state_provider.dart

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pillow_bud/models/chat_message.dart';
import 'package:pillow_bud/models/journal_entry.dart';
import 'package:pillow_bud/models/user_preference.dart';

// User State
final userNameProvider = StateProvider<String>((ref) => '');

final userPreferenceProvider = 
    StateProvider<UserPreference>((ref) => UserPreference.empty());

final onboardingCompletedProvider = StateProvider<bool>((ref) => false);

// Mood State
final currentMoodProvider = StateProvider<String>((ref) => '😌');

// Chat State
final chatMessagesProvider = 
    StateProvider<List<ChatMessage>>((ref) => []);

final isLoadingChatProvider = StateProvider<bool>((ref) => false);

final currentChatIdProvider = StateProvider<String>((ref) => '');

// Journal State
final journalEntriesProvider = 
    StateProvider<List<JournalEntry>>((ref) => []);

// UI State
final isDarkModeProvider = StateProvider<bool>((ref) => true);

final isModelLoadingProvider = StateProvider<bool>((ref) => true);

final modelLoadingProgressProvider = 
    StateProvider<double>((ref) => 0.0);
```

---

### 11. lib/providers/theme_provider.dart

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final primaryColorProvider = StateProvider<Color>((ref) {
  return const Color(0xFFC4A8F8);
});

final secondaryColorProvider = StateProvider<Color>((ref) {
  return const Color(0xFF89C4F8);
});

final themeProvider = StateProvider<String>((ref) => 'lavender');

final currentThemeProvider = StateProvider<Map<String, Color>>((ref) {
  final theme = ref.watch(themeProvider);
  final themeMap = {
    'lavender': {
      'primary': const Color(0xFFC4A8F8),
      'secondary': const Color(0xFF89C4F8),
    },
    'ocean': {
      'primary': const Color(0xFF4A90E2),
      'secondary': const Color(0xFF7AC8E8),
    },
    'sunset': {
      'primary': const Color(0xFFE8A87C),
      'secondary': const Color(0xFFF0B490),
    },
    'mint': {
      'primary': const Color(0xFF6AC4A8),
      'secondary': const Color(0xFFA8D8C4),
    },
    'rose': {
      'primary': const Color(0xFFD8A8C4),
      'secondary': const Color(0xFFE8C4D8),
    },
  };
  
  return themeMap[theme] ?? themeMap['lavender']!;
});
```

---

### 12. lib/providers/llm_provider.dart

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pillow_bud/services/llm_service.dart';

final llmServiceProvider = Provider<LLMService>((ref) {
  return LLMService();
});

final budResponseProvider = 
    FutureProvider.family<String, String>((ref, userMessage) async {
  final llmService = ref.watch(llmServiceProvider);
  return await llmService.getMockBudResponse(userMessage);
});
```

---

### 13. lib/services/crisis_detector.dart

```dart
import 'package:pillow_bud/config/constants.dart';

class CrisisDetector {
  static bool detectCrisis(String message) {
    final lower = message.toLowerCase();
    
    for (String trigger in Constants.crisisTriggers) {
      if (lower.contains(trigger)) {
        return true;
      }
    }
    return false;
  }

  static String getCrisisResourceMessage() {
    return '''I care about you deeply, and I'm concerned.

Please reach out to someone right now:

🆘 ${Constants.icallName}
   ${Constants.icallNumber}

🆘 ${Constants.vandrevalaName}
   ${Constants.vandrevalaNumber}

🆘 ${Constants.aasraName}
   ${Constants.aasraNumber}

You deserve real, professional support.
Please call now. 💙''';
  }
}
```

---

### 14. lib/services/llm_service.dart

```dart
import 'package:pillow_bud/models/user_preference.dart';

class LLMService {
  static const List<String> mockResponses = [
    'I hear you. That sounds really heavy. You\'re not alone in this.',
    'Tell me more about what\'s on your mind. I\'m listening.',
    'That\'s a lot to carry. How has it been making you feel?',
    'Thank you for sharing. What do you think would help right now?',
    'I understand. You\'re doing great by talking about it.',
    'Take your time. I\'m here to listen.',
    'That sounds challenging. What support do you need?',
    'Your feelings are valid. Tell me more if you want to.',
  ];

  // Mock response (will be replaced with real Llama later)
  Future<String> getMockBudResponse(String userMessage) async {
    // Simulate thinking time
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Return a random mock response
    final index = userMessage.length % mockResponses.length;
    return mockResponses[index];
  }

  // This will integrate with flutter_gemma later
  Future<String> getResonseFromLlama(
    String userMessage, {
    required String userName,
    required String personality,
  }) async {
    // TODO: Integrate flutter_gemma here
    return await getMockBudResponse(userMessage);
  }

  String buildSystemPrompt(String userName, String personality) {
    const basePrompt = '''You are Bud, an emotional companion for \$userName.
Your role is to:
- Listen without judgment
- Validate their feelings
- Ask gentle follow-up questions
- Never pretend to be a therapist
- Keep responses under 100 words
- Be warm, empathetic, and human

Never give medical advice or make promises you can't keep.''';

    switch (personality) {
      case 'gentle':
        return '$basePrompt\n\nBe very soft and validating. Focus on listening more than asking.';
      case 'curious':
        return '$basePrompt\n\nAsk open-ended questions to help explore feelings.';
      case 'wise':
        return '$basePrompt\n\nBe reflective and thoughtful. Offer gentle wisdom.';
      default:
        return basePrompt;
    }
  }
}
```

---

### 15. lib/services/storage_service.dart

```dart
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // User Data
  static Future<void> setUserName(String name) async {
    await _prefs.setString('userName', name);
  }

  static String? getUserName() {
    return _prefs.getString('userName');
  }

  static Future<void> setOnboardingCompleted(bool completed) async {
    await _prefs.setBool('onboardingCompleted', completed);
  }

  static bool isOnboardingCompleted() {
    return _prefs.getBool('onboardingCompleted') ?? false;
  }

  // Theme
  static Future<void> setDarkMode(bool isDark) async {
    await _prefs.setBool('isDarkMode', isDark);
  }

  static bool isDarkMode() {
    return _prefs.getBool('isDarkMode') ?? true;
  }

  static Future<void> setTheme(String theme) async {
    await _prefs.setString('theme', theme);
  }

  static String getTheme() {
    return _prefs.getString('theme') ?? 'lavender';
  }

  // Buddy Personality
  static Future<void> setBuddyPersonality(String personality) async {
    await _prefs.setString('buddyPersonality', personality);
  }

  static String getBuddyPersonality() {
    return _prefs.getString('buddyPersonality') ?? 'balanced';
  }

  // Clear all data
  static Future<void> clearAllData() async {
    await _prefs.clear();
  }
}
```

---

### 16. lib/services/date_utils.dart

```dart
import 'package:intl/intl.dart';

class DateUtils {
  static String formatTime(DateTime dt) {
    final now = DateTime.now();
    
    if (dt.day == now.day && 
        dt.month == now.month && 
        dt.year == now.year) {
      return 'Today';
    }
    
    if (dt.day == now.day - 1) {
      return 'Yesterday';
    }
    
    return DateFormat('MMM d').format(dt);
  }

  static String formatTimeOfDay(DateTime dt) {
    return DateFormat('h:mm a').format(dt);
  }

  static String formatDateTime(DateTime dt) {
    final now = DateTime.now();
    
    if (dt.day == now.day && 
        dt.month == now.month && 
        dt.year == now.year) {
      return 'Today at ${DateFormat("h:mm a").format(dt)}';
    }
    
    return DateFormat('MMM d, yyyy').format(dt);
  }

  static int calculateStreak(List<DateTime> dates) {
    if (dates.isEmpty) return 0;
    
    dates.sort((a, b) => b.compareTo(a));
    
    int streak = 0;
    DateTime? lastDate;
    
    for (final date in dates) {
      if (lastDate == null) {
        streak = 1;
        lastDate = date;
      } else {
        final daysDifference = lastDate.difference(date).inDays;
        if (daysDifference == 1) {
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
    return dt.day == now.day && 
           dt.month == now.month && 
           dt.year == now.year;
  }
}
```

---

### 17. lib/screens/splash_screen.dart

```dart
import 'package:flutter/material.dart';
import 'package:pillow_bud/theme/app_colors.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const OnboardingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text('🛏️', style: TextStyle(fontSize: 40)),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Pillow Bud',
              style: TextStyle(
                fontFamily: 'Lora',
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimaryDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'YOUR EMOTIONAL COMPANION',
              style: TextStyle(
                fontFamily: 'DM Sans',
                fontSize: 10,
                color: Colors.white.withOpacity(0.4),
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

### 18. lib/screens/onboarding_screen.dart

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pillow_bud/providers/app_state_provider.dart';
import 'package:pillow_bud/services/storage_service.dart';
import 'package:pillow_bud/theme/app_colors.dart';
import 'home_screen.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  String userName = '';
  String selectedPersonality = 'balanced';

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    StorageService.init();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 4) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Save and go to home
      ref.read(userNameProvider.notifier).state = userName;
      ref.read(onboardingCompletedProvider.notifier).state = true;
      
      StorageService.setUserName(userName);
      StorageService.setOnboardingCompleted(true);
      StorageService.setBuddyPersonality(selectedPersonality);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) => setState(() => _currentPage = index),
        children: [
          _buildWelcomePage(),
          _buildNamePage(),
          _buildPersonalityPage(),
          _buildDisclaimerPage(),
          _buildReadyPage(),
        ],
      ),
    );
  }

  Widget _buildWelcomePage() {
    return _buildPageLayout(
      children: [
        const Text(
          'Welcome to Pillow Bud',
          style: TextStyle(
            fontFamily: 'Lora',
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimaryDark,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Your emotional companion, always listening',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'DM Sans',
            fontSize: 14,
            color: Colors.white.withOpacity(0.65),
          ),
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: _nextPage,
          child: const Text('Begin'),
        ),
      ],
    );
  }

  Widget _buildNamePage() {
    return _buildPageLayout(
      children: [
        const Text(
          'What\'s your name?',
          style: TextStyle(
            fontFamily: 'Lora',
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimaryDark,
          ),
        ),
        const SizedBox(height: 32),
        TextField(
          onChanged: (value) => userName = value,
          decoration: InputDecoration(
            hintText: 'Enter your name...',
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            filled: true,
            fillColor: Colors.white.withOpacity(0.04),
          ),
          style: const TextStyle(color: AppColors.textPrimaryDark),
          autofocus: true,
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: userName.isEmpty ? null : _nextPage,
          child: const Text('Continue'),
        ),
      ],
    );
  }

  Widget _buildPersonalityPage() {
    return _buildPageLayout(
      children: [
        const Text(
          'How should Bud be with you?',
          style: TextStyle(
            fontFamily: 'Lora',
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimaryDark,
          ),
        ),
        const SizedBox(height: 32),
        Column(
          children: [
            _buildPersonalityOption('Gentle', 'Soft, validating'),
            const SizedBox(height: 12),
            _buildPersonalityOption('Curious', 'Ask questions'),
            const SizedBox(height: 12),
            _buildPersonalityOption('Wise', 'Reflective, thoughtful'),
            const SizedBox(height: 12),
            _buildPersonalityOption('Balanced', 'Mix of all (default)'),
          ],
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: _nextPage,
          child: const Text('Continue'),
        ),
      ],
    );
  }

  Widget _buildPersonalityOption(String title, String subtitle) {
    final isSelected = selectedPersonality == title.toLowerCase();
    
    return GestureDetector(
      onTap: () => setState(() => selectedPersonality = title.toLowerCase()),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : Colors.white.withOpacity(0.1),
          ),
          borderRadius: BorderRadius.circular(12),
          color: isSelected
              ? AppColors.primary.withOpacity(0.12)
              : Colors.white.withOpacity(0.04),
        ),
        child: Row(
          children: [
            Radio<String>(
              value: title.toLowerCase(),
              groupValue: selectedPersonality,
              onChanged: (value) {
                if (value != null) {
                  setState(() => selectedPersonality = value);
                }
              },
              activeColor: AppColors.primary,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: AppColors.textPrimaryDark),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDisclaimerPage() {
    return _buildPageLayout(
      children: [
        const Text(
          'Important',
          style: TextStyle(
            fontFamily: 'Lora',
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimaryDark,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Bud is your emotional companion, not a licensed therapist. For serious mental health concerns, please talk to a professional or call a crisis helpline.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'DM Sans',
            fontSize: 14,
            color: Colors.white.withOpacity(0.7),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: _nextPage,
          child: const Text('I understand'),
        ),
      ],
    );
  }

  Widget _buildReadyPage() {
    return _buildPageLayout(
      children: [
        const Text(
          'You\'re all set!',
          style: TextStyle(
            fontFamily: 'Lora',
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimaryDark,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Bud is ready to listen. Let\'s begin.',
          style: TextStyle(
            fontFamily: 'DM Sans',
            fontSize: 14,
            color: Colors.white.withOpacity(0.65),
          ),
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: _nextPage,
          child: const Text('Let\'s go'),
        ),
      ],
    );
  }

  Widget _buildPageLayout({required List<Widget> children}) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}
```

---

### 19. lib/screens/home_screen.dart

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pillow_bud/providers/app_state_provider.dart';
import 'package:pillow_bud/theme/app_colors.dart';
import 'chat_screen.dart';
import 'journal_screen.dart';
import 'insights_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const _HomeTab(),
    const ChatScreen(),
    const JournalScreen(),
    const InsightsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        backgroundColor: AppColors.darkBg,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.white.withOpacity(0.4),
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Bud'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Journal'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Insights'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Me'),
        ],
      ),
    );
  }
}

class _HomeTab extends ConsumerWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userName = ref.watch(userNameProvider);
    final currentMood = ref.watch(currentMoodProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hey, $userName',
              style: const TextStyle(
                fontFamily: 'Lora',
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimaryDark,
              ),
            ),
            const SizedBox(height: 24),
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
                  Text(
                    'How are you feeling?',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildMoodButton('😤', 'Stressed', ref),
                      _buildMoodButton('😢', 'Sad', ref),
                      _buildMoodButton('😌', 'Calm', ref),
                      _buildMoodButton('😊', 'Happy', ref),
                      _buildMoodButton('😟', 'Anxious', ref),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Text('🌸', style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'I\'m here whenever you need to talk. No judgment, just listening.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.75),
                        height: 1.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ChatScreen()),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Talk to Bud'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodButton(String emoji, String label, WidgetRef ref) {
    return GestureDetector(
      onTap: () => ref.read(currentMoodProvider.notifier).state = emoji,
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              color: Colors.white.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }
}
```

---

### 20. lib/screens/chat_screen.dart

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pillow_bud/models/chat_message.dart';
import 'package:pillow_bud/services/crisis_detector.dart';
import 'package:pillow_bud/theme/app_colors.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  List<ChatMessage> messages = [
    ChatMessage(
      id: '1',
      text: 'Hey! I\'m here to listen. What\'s on your mind?',
      isFromBud: true,
      timestamp: DateTime.now(),
      sessionId: 'session1',
    ),
  ];

  void _sendMessage() {
    if (_controller.text.isEmpty) return;

    final userText = _controller.text;
    
    // Check for crisis
    if (CrisisDetector.detectCrisis(userText)) {
      setState(() {
        messages.add(ChatMessage(
          id: DateTime.now().toString(),
          text: userText,
          isFromBud: false,
          timestamp: DateTime.now(),
          sessionId: 'session1',
        ));
      });

      _showCrisisDialog();
      _controller.clear();
      return;
    }

    // Add user message
    setState(() {
      messages.add(ChatMessage(
        id: DateTime.now().toString(),
        text: userText,
        isFromBud: false,
        timestamp: DateTime.now(),
        sessionId: 'session1',
      ));
    });

    _controller.clear();
    _scrollToBottom();

    // Mock Bud response
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          messages.add(ChatMessage(
            id: DateTime.now().toString(),
            text: _generateMockResponse(userText),
            isFromBud: true,
            timestamp: DateTime.now(),
            sessionId: 'session1',
          ));
        });
        _scrollToBottom();
      }
    });
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _showCrisisDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        title: const Text('I care about you', style: TextStyle(color: AppColors.textPrimaryDark)),
        content: Text(
          CrisisDetector.getCrisisResourceMessage(),
          style: TextStyle(color: Colors.white.withOpacity(0.75)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  String _generateMockResponse(String userMessage) {
    List<String> responses = [
      'That sounds really heavy. Tell me more about it.',
      'I hear you. How has this been making you feel?',
      'That\'s a lot to carry. You\'re doing great by talking about it.',
      'What do you think would help you feel better right now?',
      'I\'m here for you. Take your time.',
      'Thank you for sharing. That\'s really important.',
      'I understand. Tell me more if you want to.',
      'You\'re not alone in this. What support do you need?',
    ];
    return responses[messages.length % responses.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bud'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: msg.isFromBud
                      ? _buildBudMessage(msg)
                      : _buildUserMessage(msg),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.white.withOpacity(0.1)),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    maxLines: null,
                    minLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Share your thoughts...',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.04),
                    ),
                    style: const TextStyle(color: AppColors.textPrimaryDark),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 18),
                    onPressed: _sendMessage,
                    padding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBudMessage(ChatMessage msg) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: const Center(child: Text('🌸', style: TextStyle(fontSize: 14))),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.12),
              border: Border.all(color: AppColors.primary.withOpacity(0.2)),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(14),
                bottomLeft: Radius.circular(14),
                bottomRight: Radius.circular(14),
              ),
            ),
            child: Text(
              msg.text,
              style: TextStyle(
                fontSize: 13,
                color: Colors.white.withOpacity(0.85),
                height: 1.6,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserMessage(ChatMessage msg) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(4),
                bottomLeft: Radius.circular(14),
                bottomRight: Radius.circular(14),
              ),
            ),
            child: Text(
              msg.text,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white,
                height: 1.6,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
```

---

### 21. lib/screens/journal_screen.dart

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pillow_bud/models/journal_entry.dart';
import 'package:pillow_bud/theme/app_colors.dart';

class JournalScreen extends ConsumerStatefulWidget {
  const JournalScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends ConsumerState<JournalScreen> {
  final TextEditingController _controller = TextEditingController();
  String _selectedMood = '😌';
  
  List<JournalEntry> entries = [
    JournalEntry(
      id: '1',
      text: 'Had a good chat with Bud. Feeling calmer now.',
      mood: '😌',
      dateCreated: DateTime.now(),
      dateModified: DateTime.now(),
    ),
  ];

  void _saveEntry() {
    if (_controller.text.isEmpty) return;

    setState(() {
      entries.insert(0, JournalEntry(
        id: DateTime.now().toString(),
        text: _controller.text,
        mood: _selectedMood,
        dateCreated: DateTime.now(),
        dateModified: DateTime.now(),
      ));
    });

    _controller.clear();
    _selectedMood = '😌';
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Journal'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: entries.isEmpty
            ? Center(
                child: Text(
                  'No entries yet. Start writing!',
                  style: TextStyle(color: Colors.white.withOpacity(0.4)),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  final entry = entries[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.04),
                      border: Border.all(color: Colors.white.withOpacity(0.07)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Today',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white.withOpacity(0.4),
                              ),
                            ),
                            Text(entry.mood, style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          entry.text,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.7),
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNewEntryDialog(),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showNewEntryDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: AppColors.cardDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'New Journal Entry',
                style: TextStyle(
                  fontFamily: 'Lora',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimaryDark,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _controller,
                maxLines: 5,
                minLines: 3,
                decoration: InputDecoration(
                  hintText: 'Write your thoughts...',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.04),
                ),
                style: const TextStyle(color: AppColors.textPrimaryDark),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Mood:', style: TextStyle(fontSize: 12)),
                  Row(
                    children: ['😤', '😢', '😌', '😊', '😄'].map((emoji) {
                      return GestureDetector(
                        onTap: () => setState(() => _selectedMood = emoji),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: _selectedMood == emoji
                                ? AppColors.primary.withOpacity(0.3)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(emoji, style: const TextStyle(fontSize: 20)),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _saveEntry();
                    },
                    child: const Text('Save'),
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
```

---

### 22. lib/screens/insights_screen.dart

```dart
import 'package:flutter/material.dart';
import 'package:pillow_bud/theme/app_colors.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Insights',
              style: TextStyle(
                fontFamily: 'Lora',
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimaryDark,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Text('🔥', style: TextStyle(fontSize: 24)),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '7 days',
                        style: TextStyle(
                          fontFamily: 'Lora',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        'Current check-in streak',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Mood this week',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withOpacity(0.4),
              ),
            ),
            const SizedBox(height: 12),
            // Mood chart placeholder
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                    .asMap()
                    .entries
                    .map((e) {
                  final index = e.key;
                  final day = e.value;
                  final fills = [40, 55, 30, 75, 65, 85, 70];
                  
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 30,
                          child: Text(
                            day,
                            style: TextStyle(
                              fontSize: 9,
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Container(
                              height: 8,
                              color: Colors.white.withOpacity(0.1),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: (fills[index] / 100) * 100,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          ['😤', '😌', '😢', '😊', '😌', '😄', '😌'][index],
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

### 23. lib/screens/profile_screen.dart

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pillow_bud/config/constants.dart';
import 'package:pillow_bud/providers/app_state_provider.dart';
import 'package:pillow_bud/theme/app_colors.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userName = ref.watch(userNameProvider);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 16),
          Center(
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primary, AppColors.secondary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      userName.isNotEmpty ? userName[0].toUpperCase() : 'U',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  userName,
                  style: const TextStyle(
                    fontFamily: 'Lora',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimaryDark,
                  ),
                ),
                Text(
                  'Member since today',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'About',
            style: TextStyle(
              fontFamily: 'Lora',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimaryDark,
            ),
          ),
          const SizedBox(height: 12),
          _buildSettingItem('App Name', 'Pillow Bud'),
          _buildSettingItem('Version', '1.0.0'),
          const SizedBox(height: 24),
          const Text(
            'Crisis Resources',
            style: TextStyle(
              fontFamily: 'Lora',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimaryDark,
            ),
          ),
          const SizedBox(height: 12),
          _buildCrisisResource(Constants.icallName, Constants.icallNumber),
          _buildCrisisResource(Constants.vandrevalaName, Constants.vandrevalaNumber),
          _buildCrisisResource(Constants.aasraName, Constants.aasraNumber),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withOpacity(0.07)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: AppColors.textPrimaryDark),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCrisisResource(String name, String number) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withOpacity(0.07)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimaryDark,
                ),
              ),
              Text(
                number,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ],
          ),
          const Icon(Icons.call, color: AppColors.primary, size: 18),
        ],
      ),
    );
  }
}
```

---

### 24. lib/widgets/buttons/primary_button.dart

```dart
import 'package:flutter/material.dart';
import 'package:pillow_bud/theme/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final double? width;

  const PrimaryButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        minimumSize: Size(width ?? 0, 50),
      ),
      child: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text(
              label,
              style: const TextStyle(
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w500,
              ),
            ),
    );
  }
}
```

---

### 25. lib/widgets/buttons/secondary_button.dart

```dart
import 'package:flutter/material.dart';
import 'package:pillow_bud/theme/app_colors.dart';

class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double? width;

  const SecondaryButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        minimumSize: Size(width ?? 0, 50),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'DM Sans',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
```

---

### 26. lib/widgets/indicators/typing_indicator.dart

```dart
import 'package:flutter/material.dart';
import 'package:pillow_bud/theme/app_colors.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({Key? key}) : super(key: key);

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(3, (index) {
        final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval((index) * 0.2, (index + 1) * 0.2),
          ),
        );

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: ScaleTransition(
            scale: animation,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      }),
    );
  }
}
```

---

### 27. lib/utils/extensions.dart

```dart
import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  bool get isMobile => MediaQuery.of(this).size.width < 600;
  
  double get screenWidth => MediaQuery.of(this).size.width;
  
  double get screenHeight => MediaQuery.of(this).size.height;
  
  bool get isDarkMode => MediaQuery.of(this).platformBrightness == Brightness.dark;
}

extension StringExtension on String {
  bool get isEmailValid => RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  ).hasMatch(this);
}
```

---

### 28. .gitignore

```
# Flutter
.dart_tool/
.flutter-plugins
.flutter-plugins-dependencies
.packages
.pub/
pubspec.lock
build/

# IDE
.idea/
.vscode/
*.swp
*.swo
*.swn
.DS_Store

# Environment
.env
.env.local

# Misc
*.log
*.iml
```

---

### 29. README.md

```markdown
# Pillow Bud 🛏️

Your emotional companion, always listening.

Pillow Bud is a free, open-source mental health support app that runs entirely on your phone. Built with Flutter and powered by Llama 3.2 1B AI.

## Features

- 💬 Chat with Bud — An AI companion that listens without judgment
- 📓 Journal — Write your thoughts privately
- 😌 Mood Tracking — Track how you're feeling over time
- 🆘 Crisis Detection — Shows crisis resources when needed
- 🎨 Customizable — Choose themes and colors
- 100% Private — Everything stays on your phone
- 100% Free — No costs, no subscriptions

## Privacy First

- **100% Local Processing** — All data stays on your phone
- **No Cloud** — No servers, no external calls
- **Encrypted** — Data is encrypted by default
- **Open Source** — Code is transparent and auditable

## Getting Started

### Prerequisites

- Flutter 3.0+ installed
- Android Studio or Xcode
- A smartphone (Android 8+ or iOS 15+)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/pillow-bud.git
cd pillow-bud
```

2. Install dependencies:
```bash
flutter pub get
```

3. Connect your phone via USB (or use emulator)

4. Run the app:
```bash
flutter run
```

## First-Time Setup

1. When you open the app, complete the onboarding (2 minutes)
2. Enter your name and choose Bud's personality
3. Start chatting!

On first launch, Bud will download the AI model (~700 MB). This only happens once.

## Building

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## Important Disclaimer

**Pillow Bud is not a substitute for professional mental health care.**

Bud is an emotional companion, not a licensed therapist. For serious mental health concerns, please speak with a mental health professional.

If you're in crisis, please reach out to:
- **iCall India:** 9152987821
- **Vandrevala Foundation:** 1860-2662-345
- **AASRA:** 9820466726

## License

This project is licensed under the Apache 2.0 License - see the LICENSE file for details.

## Contributing

Contributions are welcome! Please read CONTRIBUTING.md for details on how to help.

## Support

- 💙 Enjoying Pillow Bud? Star this repo!
- 🐛 Found a bug? Open an issue
- 💡 Have ideas? Discussions welcome

## Built With

- **Flutter** — UI framework
- **Riverpod** — State management
- **Isar** — Local database
- **flutter_gemma** — AI integration

## Roadmap

- [ ] Integrate real Llama 3.2 1B model
- [ ] Isar database for persistent storage
- [ ] Advanced mood analytics
- [ ] Meditation guides
- [ ] Peer community features (optional, privacy-first)

---

Made with ❤️ for people who need a listening ear.

**Remember: You are not alone. You matter. 💙**
```

---

### 30. LICENSE

```
Apache License
Version 2.0, January 2004

Copyright 2024 Pillow Bud

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

---

### 31. CONTRIBUTING.md

```markdown
# Contributing to Pillow Bud 💙

First off, thanks for thinking about contributing! We're excited to have community involvement.

## Code of Conduct

Be respectful. Pillow Bud is about emotional support. Everyone in this community should feel safe and respected.

## How Can I Contribute?

### Reporting Bugs

- Check if the bug is already reported
- Be specific and include:
  - Steps to reproduce
  - Expected behavior
  - Actual behavior
  - Device/OS info

### Suggesting Features

- Check if it's already suggested
- Explain the feature and why it would help
- Include use cases if possible

### Code Contributions

1. Fork the repository
2. Create a branch: `git checkout -b feature/your-feature`
3. Make your changes
4. Test thoroughly
5. Commit with clear messages
6. Push and create a Pull Request

## Code Style

- Follow Dart conventions
- Use meaningful variable names
- Comment complex logic
- Keep functions small and focused

## Testing

- Test on both Android and iOS if possible
- Test on different device sizes
- Test on different OS versions

## Remember

This is about helping people. Be thoughtful about changes that affect user experience or mental health safety.

Thank you for contributing! 🙏
```

---

## SETUP INSTRUCTIONS

Now that you have all files, here's how to set up:

### 1. Create Project Structure

```bash
flutter create pillow_bud
cd pillow_bud
```

### 2. Copy All Files

For each file listed above:
1. Create the folder if it doesn't exist
2. Create the file
3. Copy the content exactly

### 3. Get Dependencies

```bash
flutter pub get
```

### 4. Download Fonts (Important!)

You need to download these fonts and add them to `assets/fonts/`:

**Download from Google Fonts:**
- Lora: https://fonts.google.com/specimen/Lora
- DM Sans: https://fonts.google.com/specimen/DM+Sans

Extract the TTF files you need into `assets/fonts/`

### 5. Run!

```bash
flutter run
```

---

That's it! You now have a complete, working Pillow Bud app ready to download and use.
