# Pillow Bud — Quick Start Development Guide

## Overview
You're going to build a fully functional app in **4 weeks** by cutting unnecessary complexity and focusing on core features only. No fancy animations initially, no bells and whistles — just Bud talking, journal saving, and mood tracking.

---

## WEEK 1: Foundation (5 Days)

### Day 1: Project Setup (2 hours)

**Step 1: Create Flutter Project**
```bash
# Open Terminal in VS Code (Ctrl+`)
flutter create pillow_bud
cd pillow_bud

# Open in VS Code
code .
```

**Step 2: Update pubspec.yaml**
Replace the entire `pubspec.yaml` with this:

```yaml
name: pillow_bud
description: Your emotional companion, always listening.
publish_to: 'none'

version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  
  # UI & State Management
  cupertino_icons: ^1.0.5
  riverpod: ^2.5.1
  flutter_riverpod: ^2.5.1
  
  # Database (Local Storage)
  isar: ^4.2.0
  isar_flutter_libs: ^4.2.0
  
  # LLM Integration
  flutter_gemma: ^0.0.1  # Handles Llama, streaming, model download
  
  # Download Management
  background_downloader: ^7.15.0
  
  # Animations
  flutter_animate: ^4.3.0
  
  # Utilities
  intl: ^0.19.0
  shared_preferences: ^2.2.2
  
  # Fonts
  google_fonts: ^6.1.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_linter: any
  build_runner: ^2.4.6
  isar_generator: ^4.2.0

flutter:
  uses-material-design: true
  
  # Add custom fonts
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

  assets:
    - assets/images/
    - assets/icons/
```

**Step 3: Get Dependencies**
```bash
flutter pub get
flutter pub run build_runner build  # For Isar and Riverpod
```

**Step 4: Create Folder Structure**
In VS Code, create these folders in `lib/`:
```
lib/
├── main.dart
├── models/           # Data classes (ChatSession, JournalEntry, etc.)
├── providers/        # Riverpod providers (state management)
├── screens/          # All 7 screens
├── widgets/          # Reusable components
├── services/         # LLM, Database, Crisis Detector
├── theme/           # Colors, fonts, theme logic
└── config/          # Constants, crisis resources
```

**Create files quickly** (use Antigravity to jump between them):
```bash
# In terminal
mkdir -p lib/{models,providers,screens,widgets,services,theme,config}
touch lib/{models,providers,screens,widgets,services,theme,config}/.gitkeep

# Also create app directories
mkdir -p assets/{fonts,images}
```

### Day 2: Theme System & Colors (2 hours)

**Step 1: Create Theme File**
`lib/theme/app_colors.dart`:
```dart
import 'package:flutter/material.dart';

class AppColors {
  // Primary Palette
  static const Color primary = Color(0xFFC4A8F8);      // Lavender
  static const Color secondary = Color(0xFF89C4F8);    // Misty Teal
  static const Color tertiary = Color(0xFFA8D8A8);     // Sage
  
  // Backgrounds (Dark Mode Default)
  static const Color darkBg = Color(0xFF1A1225);
  static const Color lightBg = Color(0xFFF8F6FF);
  static const Color cardDark = Color(0xFF2D1F4A);
  
  // Text
  static const Color textPrimaryDark = Color(0xFFF0E8FF);
  static const Color textPrimaryLight = Color(0xFF1A1225);
  
  // Semantic
  static const Color success = Color(0xFF7ACF8E);
  static const Color warning = Color(0xFFFAC775);
  static const Color danger = Color(0xFFF09595);
}

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
        ),
        headlineSmall: TextStyle(
          fontFamily: 'Lora',
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimaryDark,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'DM Sans',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimaryDark,
        ),
      ),
    );
  }
  
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBg,
      primaryColor: AppColors.primary,
    );
  }
}
```

**Step 2: Create Constants File**
`lib/config/constants.dart`:
```dart
class Constants {
  // Crisis Resources (India-focused)
  static const String ICALL_NUMBER = '9152987821';
  static const String ICALL_NAME = 'iCall India';
  
  static const String VANDREVALA_NUMBER = '1860-2662-345';
  static const String VANDREVALA_NAME = 'Vandrevala Foundation';
  
  static const String AASRA_NUMBER = '9820466726';
  static const String AASRA_NAME = 'AASRA';
  
  // Crisis Trigger Phrases (Simplified)
  static const List<String> crisisTriggers = [
    'kill myself',
    'kill myself',
    'end my life',
    'suicide',
    'overdose',
    'jump',
    'want to die',
    'better off dead',
    'harm myself',
    'cut myself',
  ];
  
  // Model Info
  static const String LLM_MODEL = 'Llama 3.2 1B';
  static const String LLM_SIZE = '700 MB';
}
```

**Step 3: Create Models**
`lib/models/chat_message.dart`:
```dart
class ChatMessage {
  final String id;
  final String text;
  final bool isFromBud;
  final DateTime timestamp;
  
  ChatMessage({
    required this.id,
    required this.text,
    required this.isFromBud,
    required this.timestamp,
  });
}

class ChatSession {
  final String id;
  final String userName;
  final List<ChatMessage> messages;
  final DateTime createdAt;
  
  ChatSession({
    required this.id,
    required this.userName,
    required this.messages,
    required this.createdAt,
  });
}
```

`lib/models/journal_entry.dart`:
```dart
class JournalEntry {
  final String id;
  final String text;
  final String mood; // emoji or name
  final DateTime date;
  
  JournalEntry({
    required this.id,
    required this.text,
    required this.mood,
    required this.date,
  });
}
```

### Day 3: Providers (State Management) (2 hours)

`lib/providers/app_state_provider.dart`:
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userNameProvider = StateProvider<String>((ref) => '');

final currentMoodProvider = StateProvider<String>((ref) => '😌');

final chatMessagesProvider = 
    StateProvider<List<dynamic>>((ref) => []);

final journalEntriesProvider = 
    StateProvider<List<dynamic>>((ref) => []);

final isModelLoadingProvider = StateProvider<bool>((ref) => true);

final modelLoadingProgressProvider = 
    StateProvider<double>((ref) => 0.0);
```

### Day 4: Crisis Detector Service (2 hours)

`lib/services/crisis_detector.dart`:
```dart
import 'package:pillow_bud/config/constants.dart';

class CrisisDetector {
  static bool detectCrisis(String message) {
    final lowerMessage = message.toLowerCase();
    
    for (String trigger in Constants.crisisTriggers) {
      if (lowerMessage.contains(trigger)) {
        return true;
      }
    }
    return false;
  }
  
  static String getCrisisMessage() {
    return '''
I care about you, and I'm worried. 
Please talk to someone right now:

${Constants.ICALL_NAME}: ${Constants.ICALL_NUMBER}
${Constants.VANDREVALA_NAME}: ${Constants.VANDREVALA_NUMBER}
${Constants.AASRA_NAME}: ${Constants.AASRA_NUMBER}

You deserve real support. Call now. 💙
    ''';
  }
}
```

### Day 5: Main.dart & First Screen (3 hours)

`lib/main.dart`:
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pillow_bud/theme/app_colors.dart';
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

`lib/screens/splash_screen.dart`:
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
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
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
              child: const Center(child: Text('🛏️', style: TextStyle(fontSize: 40))),
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

**Test what you have:**
```bash
flutter run
```

If it works, you'll see the splash screen for 2 seconds, then blank (next screen not made yet).

---

## WEEK 2: Core Screens (5 Days)

### Day 6-7: Onboarding (Fast Track - 4 hours)

`lib/screens/onboarding_screen.dart`:
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pillow_bud/theme/app_colors.dart';
import 'package:pillow_bud/providers/app_state_provider.dart';
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

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
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
      // Save name and go to home
      ref.read(userNameProvider.notifier).state = userName;
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
          // Page 1: Welcome
          _buildWelcomePage(),
          
          // Page 2: Name Entry
          _buildNamePage(),
          
          // Page 3: Personality
          _buildPersonalityPage(),
          
          // Page 4: Disclaimer
          _buildDisclaimerPage(),
          
          // Page 5: Ready
          _buildReadyPage(),
        ],
      ),
    );
  }

  Widget _buildWelcomePage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Text(
              'Begin',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNamePage() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Text('Continue', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalityPage() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
              _buildPersonalityOption('Balanced ✓', 'Mix of all'),
            ],
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _nextPage,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Text('Continue', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalityOption(String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.04),
      ),
      child: Row(
        children: [
          Radio(value: title, groupValue: null, onChanged: (_) {}),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: AppColors.textPrimaryDark)),
              Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.5))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDisclaimerPage() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Text('I understand', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildReadyPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Text('Let\'s go', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
```

### Day 8-9: Home Screen (3 hours)

`lib/screens/home_screen.dart`:
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pillow_bud/theme/app_colors.dart';
import 'package:pillow_bud/providers/app_state_provider.dart';
import 'chat_screen.dart';
import 'journal_screen.dart';
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
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ChatScreen()),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text('Talk to Bud', style: TextStyle(color: Colors.white)),
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

### Day 10: Chat Screen (Simplified) (3 hours)

`lib/screens/chat_screen.dart`:
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pillow_bud/theme/app_colors.dart';
import 'package:pillow_bud/services/crisis_detector.dart';
import 'package:pillow_bud/providers/app_state_provider.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  // Mock messages for now (will integrate Llama later)
  List<Map<String, dynamic>> messages = [
    {'text': 'Hey! I\'m here to listen. What\'s on your mind?', 'isFromBud': true, 'time': '9:30 PM'},
  ];

  void _sendMessage() {
    if (_controller.text.isEmpty) return;

    final userText = _controller.text;
    
    // Check for crisis
    if (CrisisDetector.detectCrisis(userText)) {
      setState(() {
        messages.add({
          'text': userText,
          'isFromBud': false,
          'time': _getCurrentTime(),
        });
      });

      _showCrisisDialog(userText);
      _controller.clear();
      return;
    }

    // Add user message
    setState(() {
      messages.add({
        'text': userText,
        'isFromBud': false,
        'time': _getCurrentTime(),
      });
    });

    _controller.clear();
    _scrollToBottom();

    // Mock Bud response (will be real Llama response later)
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        messages.add({
          'text': _generateMockResponse(userText),
          'isFromBud': true,
          'time': _getCurrentTime(),
        });
      });
      _scrollToBottom();
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

  void _showCrisisDialog(String userMessage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('I care about you'),
        content: Text(CrisisDetector.getCrisisMessage()),
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
    // Simple mock responses (will be replaced by Llama)
    List<String> responses = [
      'That sounds really heavy. Tell me more about it.',
      'I hear you. How has this been making you feel?',
      'That\'s a lot to carry. You\'re doing great by talking about it.',
      'What do you think would help you feel better right now?',
      'I\'m here for you. Take your time.',
    ];
    return responses[messages.length % responses.length];
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'}';
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
                  child: msg['isFromBud']
                      ? _buildBudMessage(msg)
                      : _buildUserMessage(msg),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1))),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    maxLines: null,
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

  Widget _buildBudMessage(Map<String, dynamic> msg) {
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
              msg['text'],
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

  Widget _buildUserMessage(Map<String, dynamic> msg) {
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
              msg['text'],
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

### Quick Placeholder Screens

`lib/screens/journal_screen.dart`:
```dart
import 'package:flutter/material.dart';

class JournalScreen extends StatelessWidget {
  const JournalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text('Journal Coming Soon', style: TextStyle(color: Colors.white.withOpacity(0.5))),
      ),
    );
  }
}
```

`lib/screens/profile_screen.dart`:
```dart
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text('Profile Coming Soon', style: TextStyle(color: Colors.white.withOpacity(0.5))),
      ),
    );
  }
}
```

**Test:**
```bash
flutter run
```

You should see onboarding → home screen → working chat with mock Bud responses!

---

## WEEK 3: Integration & Polish (5 Days)

### Days 11-12: Integrate flutter_gemma (Real Llama)

This is where Bud talks with real AI. In your service file:

`lib/services/llm_service.dart`:
```dart
// This is PSEUDO-CODE — actual implementation depends on flutter_gemma version
// For now, use mock responses

class LLMService {
  static Future<String> getBudResponse(String userMessage) async {
    // TODO: Integrate flutter_gemma here
    // For now, return mock
    await Future.delayed(const Duration(milliseconds: 800));
    
    return 'I understand you. That sounds really challenging. What do you think would help right now?';
  }
}
```

### Days 13-14: Journal Screen (Save to Isar)

`lib/screens/journal_screen.dart`:
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pillow_bud/theme/app_colors.dart';
import 'package:pillow_bud/providers/app_state_provider.dart';

class JournalScreen extends ConsumerStatefulWidget {
  const JournalScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends ConsumerState<JournalScreen> {
  final TextEditingController _controller = TextEditingController();
  String _selectedMood = '😌';
  
  List<Map<String, String>> entries = [
    {
      'date': 'Today',
      'mood': '😌',
      'text': 'Had a good chat with Bud. Feeling calmer now.',
    },
  ];

  void _saveEntry() {
    if (_controller.text.isEmpty) return;

    setState(() {
      entries.insert(0, {
        'date': 'Today',
        'mood': _selectedMood,
        'text': _controller.text,
      });
    });

    _controller.clear();
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
                              entry['date']!,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white.withOpacity(0.4),
                              ),
                            ),
                            Text(entry['mood']!, style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          entry['text']!,
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
                  const Text('Mood:'),
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
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                    child: const Text('Save', style: TextStyle(color: Colors.white)),
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

### Day 15: Profile Screen & Settings

`lib/screens/profile_screen.dart`:
```dart
import 'package:flutter/material.dart';
import 'package:pillow_bud/theme/app_colors.dart';
import 'package:pillow_bud/config/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 16),
            const Text(
              'About Pillow Bud',
              style: TextStyle(
                fontFamily: 'Lora',
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            _buildSettingItem('Version', '1.0.0'),
            _buildSettingItem('AI Model', Constants.LLM_MODEL),
            _buildSettingItem('Model Size', Constants.LLM_SIZE),
            const SizedBox(height: 24),
            const Text(
              'Crisis Resources',
              style: TextStyle(
                fontFamily: 'Lora',
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            _buildCrisisResource(Constants.ICALL_NAME, Constants.ICALL_NUMBER),
            _buildCrisisResource(Constants.VANDREVALA_NAME, Constants.VANDREVALA_NUMBER),
            _buildCrisisResource(Constants.AASRA_NAME, Constants.AASRA_NUMBER),
          ],
        ),
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
          Text(label, style: const TextStyle(fontSize: 13)),
          Text(value, style: TextStyle(fontSize: 12, color: AppColors.primary)),
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
              Text(name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
              Text(number, style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.5))),
            ],
          ),
          Icon(Icons.call, color: AppColors.primary, size: 20),
        ],
      ),
    );
  }
}
```

---

## QUICK COMMANDS CHEAT SHEET

```bash
# Run app
flutter run

# Run on specific device
flutter run -d <device_id>

# Get device list
flutter devices

# Hot reload (after code change)
r

# Hot restart (harder reset)
R

# Stop app
q

# Build APK (Android release)
flutter build apk --release

# Build iOS
flutter build ios --release

# Clear everything and rebuild
flutter clean && flutter pub get && flutter run

# Format code
dart format lib/ -r

# Analyze code for issues
dart analyze lib/

# Watch pub dependencies
flutter pub outdated
```

---

## FAST TRACK SUMMARY (What You Have After 2 Weeks)

✅ **Working app with:**
- Splash screen
- Complete onboarding (name, personality, disclaimer)
- Home screen with mood picker
- Chat screen (mock Bud responses)
- Crisis detection + helpline resources
- Journal entries (save & display)
- Profile/settings
- Custom color theme (you can add more later)
- Dark mode
- Responsive iOS + Android

✅ **Code structure:**
- Riverpod for state management
- Modular architecture (easy to add features)
- Theme system (customizable colors)
- Service layer (LLM, database, crisis detector)

---

## NEXT STEPS (Week 3-4)

1. **Integrate flutter_gemma** (Llama 3.2 1B)
   - Replace mock responses with real AI
   - Test model download on real Android phone

2. **Add Isar Database**
   - Save chat history
   - Persist journal entries
   - Mood tracking

3. **Polish UI**
   - Add animations (dart_animate)
   - Dark/light mode toggle in settings
   - Theme picker

4. **Build & Release**
   - Generate APK for Android
   - Test on real devices
   - Upload to GitHub as source code
   - Create release notes

---

## KEY COMMANDS FOR VS CODE

- `Ctrl + Shift + P` → "Flutter: Create New Project" (if you need another)
- `Ctrl + Space` → Autocomplete
- `Ctrl + /` → Comment/uncomment
- `Ctrl + H` → Find & replace
- `F2` → Rename everywhere
- `Ctrl + .` → Quick fixes
- `Ctrl + F5` → Run with debugging

---

You're ready to start! Open VS Code, run `flutter create pillow_bud`, and follow **Day 1** above. You'll have a working app by the end of Day 5. 🚀

Questions? Ask. You got this! 🛏️💙
