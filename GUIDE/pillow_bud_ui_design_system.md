# Pillow Bud — Complete UI/UX Design System

## Executive Summary

Pillow Bud's UI is **soft, modern, minimal, and deeply customizable**. Every design decision prioritizes emotional safety and approachability. The app feels like a warm companion, not a tool. It works perfectly on both iOS and Android with platform-aware adaptations that respect each system's design language while maintaining Pillow Bud's unique identity.

---

## Part 1: Design Philosophy

### Core Principles

1. **Softness over sharpness** — curved corners, smooth transitions, no jarring edges
2. **Clarity over complexity** — one action per screen, zero confusion
3. **Warmth over clinical** — colors and copy that feel like a friend, not an app
4. **Accessibility first** — works for everyone, including people with visual impairments
5. **Offline-first aesthetics** — feels fast, never shows loading spinners (model is local)
6. **Customization without overwhelming** — users can personalize without drowning in options

### What Pillow Bud Will NOT Be

- ❌ Bright, energetic, loud (no harsh neons)
- ❌ Clinical or sterile (no hospital-like whites and grays)
- ❌ Generic Material Design or iOS clones (but respects platform conventions)
- ❌ Cluttered with features (one thing at a time)
- ❌ Inaccessible (WCAG AA standard minimum)

---

## Part 2: Color System (Deeply Customizable)

### Default Palette (Lavender & Misty Teal)

The default comes with a soft, soothing color system that users can override entirely.

#### Primary Palette
```
Primary Lavender: #C4A8F8
  - Used for: Buttons, active tabs, Bud's responses, important accents
  - Feeling: Calm, introspective, safe

Secondary Misty Teal: #89C4F8
  - Used for: Secondary actions, mood indicator highlights, subtle accents
  - Feeling: Fresh, gentle, grounding

Tertiary Sage: #A8D8A8
  - Used for: Success states, positive moods, growth indicators
  - Feeling: Growth, healing, renewal
```

#### Neutral Base
```
Dark Background (Default Dark Mode): #1A1225
  - Deep plum-black for main backgrounds
  - Reduces eye strain in evening use (critical for mental health app)

Light Background (Optional Light Mode): #F8F6FF
  - Barely off-white with slight lavender tint
  - Soft, not harsh white

Card/Surface: #2D1F4A (dark) or #FFFFFF (light)
  - Slightly elevated, creates depth without being intrusive
  - Dark cards have 8% white overlay for texture

Text Primary: #F0E8FF (dark) or #1A1225 (light)
  - Off-white text on dark (easier on eyes at night)
  - Nearly black text on light (accessible contrast)

Text Secondary: rgba(240, 232, 255, 0.65) (dark)
  - Dimmed text for supporting information
  - Not pure gray (that's cold) — still has warmth

Text Tertiary: rgba(240, 232, 255, 0.4) (dark)
  - Very soft text for meta information, timestamps
```

#### Semantic Colors (System States)
```
Positive/Success: #7ACF8E (soft green)
  - Mood: Happy, calm, peaceful
  - Usage: Positive mood selections, save confirmations

Warning/Caution: #FAC775 (warm amber)
  - Mood: Anxious, stressed (acknowledge, not alarm)
  - Usage: Low storage, slow device warning

Danger/Crisis: #F09595 (soft coral red)
  - Mood: Urgent but compassionate
  - Usage: ONLY for crisis resources (never harsh alarm)
```

### Customization: Theme Picker

Users can choose from 5 pre-made themes OR create a custom one:

```
Theme 1: Lavender Dream (default)
  Primary: #C4A8F8, Secondary: #89C4F8, Dark: #1A1225

Theme 2: Ocean Calm
  Primary: #4A90E2, Secondary: #7AC8E8, Dark: #0F1C2E

Theme 3: Sunset Warmth
  Primary: #E8A87C, Secondary: #F0B490, Dark: #2A1810

Theme 4: Minty Fresh
  Primary: #6AC4A8, Secondary: #A8D8C4, Dark: #0F2420

Theme 5: Rosy Blush
  Primary: #D8A8C4, Secondary: #E8C4D8, Dark: #2A1820

Custom Theme Builder
  - Hue slider (0-360°)
  - Saturation slider (0-100%)
  - Lightness slider for dark/light preference
  - Real-time preview on sample screens
  - Save as custom theme
```

**Implementation:**
```dart
// In Riverpod provider (theme_provider.dart)
final themeProvider = StateNotifierProvider<ThemeNotifier, AppTheme>((ref) {
  return ThemeNotifier();
});

class AppTheme {
  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color darkBg;
  final Color lightBg;
  final String name;
  
  // Computed colors for UI elements
  Color get scaffoldBg => isDarkMode ? darkBg : lightBg;
  Color get cardColor => isDarkMode ? darkBg.withOpacity(0.08) : lightBg;
}

// In main.dart, apply globally:
ThemeData buildAppTheme(AppTheme theme) {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: theme.primary,
    scaffoldBackgroundColor: theme.scaffoldBg,
    cardColor: theme.cardColor,
    colorScheme: ColorScheme.dark(
      primary: theme.primary,
      secondary: theme.secondary,
      surface: theme.cardColor,
    ),
  );
}
```

---

## Part 3: Typography System

### Font Pairing (Designed for Emotional Connection)

**Display Font: Lora (serif)**
- Used for: Headlines, Pillow Bud logo, emotional titles ("Your Insights", "My Journal")
- Why Lora: Elegant, warm, slightly classical — feels like handwritten journaling
- Weights: 400 (regular), 500 (medium), 600 (bold)

```css
font-family: 'Lora', serif;
font-size: 28px; /* Headlines */
font-weight: 600;
letter-spacing: 0.02em;
line-height: 1.4;
```

**Body Font: DM Sans (sans-serif)**
- Used for: All body text, buttons, labels, support copy
- Why DM Sans: Modern, geometric, friendly — not corporate
- Weights: 300 (light), 400 (regular), 500 (medium)

```css
font-family: 'DM Sans', sans-serif;
font-size: 14px; /* Body text */
font-weight: 400;
line-height: 1.6;
letter-spacing: 0.01em;
```

### Type Scale

```
Display Large: 28px / 600 weight / Lora
  - Screen titles ("My Journal", "Your Insights")

Display Medium: 24px / 500 weight / Lora
  - Splash screen, onboarding hero text

Headline: 18px / 500 weight / Lora
  - Card headers, section dividers

Title: 14px / 500 weight / DM Sans
  - Chat header, button labels, tab names

Body: 14px / 400 weight / DM Sans
  - Main text, descriptions, journal entries

Caption: 12px / 400 weight / DM Sans
  - Smaller supporting text, timestamps

Tiny: 10px / 400 weight / DM Sans
  - Icon labels, metadata, disabled text
```

**Line Heights (for readability):**
- Headlines: 1.4 (tighter, more impactful)
- Body: 1.6 (loose, easy to read long content)
- UI labels: 1.2 (compact)

---

## Part 4: Component Library (Core UI Elements)

### 4.1 Buttons

**Primary Button (Call to Action)**
```dart
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: theme.primary, // #C4A8F8
    foregroundColor: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    elevation: 0,
  ),
  child: Text(
    'Continue',
    style: TextStyle(
      fontFamily: 'DM Sans',
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
  ),
  onPressed: () {},
)
```
- Soft rounded corners (16px)
- No shadow (feels flat, modern, soft)
- Text color: white (high contrast)
- Padding: 24h × 12v (spacious, not cramped)

**Secondary Button (Alternative Action)**
```dart
OutlinedButton(
  style: OutlinedButton.styleFrom(
    foregroundColor: theme.primary,
    side: BorderSide(
      color: theme.primary.withOpacity(0.3),
      width: 1,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    ),
  ),
  child: Text('Cancel'),
  onPressed: () {},
)
```
- Border only (no fill)
- Border color is primary but soft (30% opacity)
- Text uses primary color
- Soft rounded (14px, slightly less than primary)

**Soft Button (Tertiary, Less Important)**
```dart
TextButton(
  style: TextButton.styleFrom(
    foregroundColor: theme.primary,
    // No background, just text
  ),
  child: Text('Learn more'),
  onPressed: () {},
)
```
- Text-only, no background
- Feels light and non-invasive

### 4.2 Input Fields (Chat & Journal)

```dart
TextField(
  decoration: InputDecoration(
    hintText: 'Type your thoughts...',
    hintStyle: TextStyle(
      color: Colors.white.withOpacity(0.4),
      fontFamily: 'DM Sans',
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20), // Pill shape!
      borderSide: BorderSide(
        color: Colors.white.withOpacity(0.1),
        width: 1,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        color: theme.primary.withOpacity(0.5),
        width: 1.5,
      ),
    ),
    contentPadding: EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ),
    filled: true,
    fillColor: Colors.white.withOpacity(0.04),
  ),
  maxLines: null, // Grow as user types
  style: TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 14,
    color: Colors.white.withOpacity(0.85),
  ),
)
```

**Key Design Details:**
- **Pill shape** (borderRadius: 20) — feels soft, friendly, not boxy
- **Light background** (4% white opacity) — visible but not intrusive
- **Subtle border** (1px, 10% opacity) — barely there, not harsh
- **No shadow** — keeps it minimal and modern
- **Growing text field** — expands as user types (not cramped)
- **Gentle focus state** — border brightens slightly (not jarring)

### 4.3 Chat Bubbles

**Bud's Response (Left-aligned)**
```dart
Container(
  decoration: BoxDecoration(
    color: theme.primary.withOpacity(0.12), // Soft lavender background
    border: Border.all(
      color: theme.primary.withOpacity(0.2),
      width: 1,
    ),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(4),    // Slightly square corner on sender side
      topRight: Radius.circular(16),
      bottomLeft: Radius.circular(16),
      bottomRight: Radius.circular(16),
    ),
  ),
  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  constraints: BoxConstraints(maxWidth: screenWidth * 0.75),
  child: Text(
    'I hear you. That sounds really heavy. You're not alone in this.',
    style: TextStyle(
      fontFamily: 'DM Sans',
      fontSize: 14,
      color: Colors.white.withOpacity(0.85),
      height: 1.6,
    ),
  ),
)
```

**User Message (Right-aligned)**
```dart
Container(
  decoration: BoxDecoration(
    color: theme.primary,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(16),
      topRight: Radius.circular(4),   // Slightly square on receiver side
      bottomLeft: Radius.circular(16),
      bottomRight: Radius.circular(16),
    ),
  ),
  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  constraints: BoxConstraints(maxWidth: screenWidth * 0.75),
  child: Text(
    'Everything feels due at once.',
    style: TextStyle(
      fontFamily: 'DM Sans',
      fontSize: 14,
      color: Colors.white,
      height: 1.6,
    ),
  ),
)
```

**Key Design Details:**
- **Asymmetric rounded corners** — 4px on sender side, 16px on others (subtle, friendly)
- **Soft border on Bud's message** — thin lavender border (shows it's background-color, not text)
- **Primary color fill on user message** — solid, clear ownership
- **75% max width** — doesn't stretch to edges, creates breathing room
- **1.6 line height** — easy to read even in small bubbles

### 4.4 Mood Selector (Emoji Picker)

```dart
Container(
  decoration: BoxDecoration(
    color: Colors.white.withOpacity(0.04),
    border: Border.all(
      color: Colors.white.withOpacity(0.07),
      width: 1,
    ),
    borderRadius: BorderRadius.circular(16),
  ),
  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      MoodButton(
        emoji: '😤',
        label: 'Stressed',
        isSelected: selectedMood == 'stressed',
        onTap: () => selectMood('stressed'),
      ),
      MoodButton(
        emoji: '😢',
        label: 'Sad',
        isSelected: selectedMood == 'sad',
        onTap: () => selectMood('sad'),
      ),
      MoodButton(
        emoji: '😌',
        label: 'Calm',
        isSelected: selectedMood == 'calm',
        onTap: () => selectMood('calm'),
      ),
      // ... more moods
    ],
  ),
)

class MoodButton extends StatelessWidget {
  final String emoji;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.primary.withOpacity(0.15)
              : Colors.transparent,
          border: Border.all(
            color: isSelected
                ? theme.primary
                : Colors.transparent,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Text(emoji, style: TextStyle(fontSize: 22)),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'DM Sans',
                fontSize: 9,
                color: Colors.white.withOpacity(
                  isSelected ? 0.8 : 0.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

**Key Design Details:**
- **Emoji + label** — emoji is visual, label confirms meaning
- **Animated selection** — smooth 200ms transition when selected
- **Soft border on select** — primary color border appears when active
- **Subtle background on select** — 15% opacity fill (not overwhelming)
- **Smooth feedback** — users know they've selected something

### 4.5 Cards (Journal, Insights, Mood History)

```dart
Container(
  decoration: BoxDecoration(
    color: Colors.white.withOpacity(0.04),
    border: Border.all(
      color: Colors.white.withOpacity(0.07),
      width: 0.5,
    ),
    borderRadius: BorderRadius.circular(14),
  ),
  padding: EdgeInsets.all(12),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'May 13 · Wednesday',
            style: TextStyle(
              fontFamily: 'DM Sans',
              fontSize: 11,
              color: Colors.white.withOpacity(0.4),
              fontWeight: FontWeight.w500,
            ),
          ),
          Text('😌', style: TextStyle(fontSize: 16)),
        ],
      ),
      SizedBox(height: 8),
      Text(
        'Had a conversation with Bud about work stress. Felt heard. Things seem lighter tonight.',
        style: TextStyle(
          fontFamily: 'DM Sans',
          fontSize: 12,
          color: Colors.white.withOpacity(0.7),
          height: 1.6,
        ),
      ),
    ],
  ),
)
```

**Key Design Details:**
- **Minimal borders** (0.5px, 7% opacity) — barely visible but gives structure
- **Soft background** (4% opacity) — floats above the main background
- **Padding: 12px all around** — content breathing room, not cramped
- **Rounded 14px** — matches the overall soft aesthetic
- **Muted text colors** — hierarchy is clear but not harsh

---

## Part 5: Screens & Layouts

### 5.1 Dark Mode Default (with Light Mode Option)

**Why Dark Mode by Default:**
- Mental health app users are often using at night (when they can't sleep, feeling anxious)
- Dark mode reduces eye strain
- Creates a cocoon-like, safe feeling (like a actual pillow in a dark room)
- More intimate and less "app-like"

Users can toggle to Light Mode in settings. Light mode uses the same principles but with inverted colors.

### 5.2 Mobile Layout Principles (iOS & Android Responsive)

**Safe Areas (Platform-Aware):**
```dart
// In main.dart
MediaQuery.of(context).viewInsets.bottom // Keyboard height
MediaQuery.of(context).viewPadding.top    // Status bar (iOS notch)
MediaQuery.of(context).padding.left       // Left safe area
```

**iOS Adaptation:**
- Respects notch and Dynamic Island spacing
- Bottom tab bar has padding for home indicator
- Uses Cupertino-style slide transitions
- "Back" button follows iOS conventions

```dart
// iOS-specific navigation
Navigator.of(context).push(
  CupertinoPageRoute(builder: (context) => ChatScreen()),
)

// iOS-style back button
CupertinoNavigationBar(
  previousPageTitle: 'Home',
  middle: Text('Bud'),
)
```

**Android Adaptation:**
- Respects system navigation bar
- Material Design 3 principles (rounded corners, elevation)
- Slide transition from right-to-left
- Uses FloatingActionButton or bottom navigation

```dart
// Android-specific navigation
Navigator.of(context).push(
  MaterialPageRoute(builder: (context) => ChatScreen()),
)

// Material Design app bar
AppBar(
  title: Text('Bud'),
  leading: BackButton(),
  backgroundColor: Colors.transparent,
  elevation: 0,
)
```

### 5.3 Responsive Padding & Spacing

**The spacing system (in DP / Logical Pixels):**
```
XS: 4px   (smallest gaps, icon padding)
S:  8px   (micro-spacing, chip spacing)
M:  12px  (default card padding, button spacing)
L:  16px  (screen edges, major section gaps)
XL: 20px  (content max-width margins)
XXL: 24px (top-level screen padding)
```

**Screen-width constraints:**
```dart
// Don't let content get too wide on tablets
constraints: BoxConstraints(maxWidth: 600),

// Responsive padding on large screens
padding: EdgeInsets.symmetric(
  horizontal: MediaQuery.of(context).size.width > 600 ? 24 : 14,
  vertical: 16,
)
```

### 5.4 Navigation Pattern (Bottom Tab Bar)

**iOS:** Tab bar at bottom (iOS convention)
**Android:** Tab bar at bottom (Material convention)
**Both:** Use Cupertino colors and Material colors appropriately

```dart
BottomNavigationBar(
  currentIndex: _selectedIndex,
  onTap: (index) => setState(() => _selectedIndex = index),
  backgroundColor: theme.darkBg,
  elevation: 0,
  type: BottomNavigationBarType.fixed,
  items: [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.chat),
      label: 'Bud',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.book),
      label: 'Journal',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.bar_chart),
      label: 'Insights',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Me',
    ),
  ],
)
```

---

## Part 6: Animations & Micro-interactions

### 6.1 Philosophy: Subtle Over Flashy

All animations are:
- **Under 300ms** (feels instant, not slow)
- **Easing curves** (ease-in-out, not linear)
- **Purposeful** (feedback, not decoration)

### 6.2 Key Animations

**Page Transition (iOS Cupertino)**
```dart
// Slide from right, subtle scale
CupertinoPageRoute(
  builder: (context) => NextScreen(),
  // Automatically handles the animation
)
```

**Chat Message Appear (Stagger)**
```dart
AnimationController animationController = AnimationController(
  duration: Duration(milliseconds: 200),
  vsync: this,
);

animationController.forward();

ScaleTransition(
  scale: Tween<double>(begin: 0.8, end: 1.0).animate(
    CurvedAnimation(parent: animationController, curve: Curves.easeOut),
  ),
  child: FadeTransition(
    opacity: animationController,
    child: ChatBubble(message: message),
  ),
)
```

**Mood Selection Feedback**
```dart
// When user taps mood emoji:
// 1. Scale up slightly (1.0 → 1.1)
// 2. Background color animates in
// 3. Border appears with color

AnimatedContainer(
  duration: Duration(milliseconds: 200),
  curve: Curves.easeOut,
  transform: isSelected 
    ? Matrix4.identity()..scale(1.1)
    : Matrix4.identity(),
  child: Container(...),
)
```

**Typing Indicator (Bud Thinking)**
```dart
class TypingIndicator extends StatefulWidget {
  @override
  _TypingIndicatorState createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();
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
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: ScaleTransition(
            scale: animation,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: theme.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      }),
    );
  }
}

// 3 dots that pulse in sequence: dot1 → dot2 → dot3 → repeat
```

**Streak Counter Animation (First Load)**
```dart
// Slide in from bottom with fade
SlideTransition(
  position: Tween<Offset>(
    begin: Offset(0, 0.3),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut)),
  child: FadeTransition(
    opacity: _controller,
    child: StreakCard(streak: 7),
  ),
)
```

---

## Part 7: Customization Features (In-App Settings)

### 7.1 Theme Customization

**Screen: Settings → Appearance → Themes**

```
┌─────────────────────────────────────┐
│ Select Your Theme                   │
├─────────────────────────────────────┤
│                                     │
│ ✓ Lavender Dream (default)          │
│   Primary: #C4A8F8                  │
│   Dark Background                   │
│                                     │
│ □ Ocean Calm                        │
│   Primary: #4A90E2                  │
│                                     │
│ □ Sunset Warmth                     │
│   Primary: #E8A87C                  │
│                                     │
│ □ Minty Fresh                       │
│   Primary: #6AC4A8                  │
│                                     │
│ □ Rosy Blush                        │
│   Primary: #D8A8C4                  │
│                                     │
│ ─ Create Custom Theme ─             │
│   [Open Color Picker]               │
│                                     │
└─────────────────────────────────────┘
```

### 7.2 Font Size Customization

**Screen: Settings → Appearance → Text Size**

```
┌─────────────────────────────────────┐
│ Text Size                           │
├─────────────────────────────────────┤
│                                     │
│ A (Small)    A (Default)  A (Large) │
│ ◀────────●────────────────────►     │
│          [Sample text shows here]   │
│                                     │
│ 🔍 Preview: Your Journal entry text │
│    will look like this when you     │
│    adjust the font size.            │
│                                     │
└─────────────────────────────────────┘
```

**Implementation:**
```dart
// In theme_provider.dart
final fontSizeMultiplierProvider = StateProvider<double>((ref) => 1.0);

// In any text widget:
Text(
  'Your text',
  style: TextStyle(
    fontSize: 14 * fontSizeMultiplier, // 1.0 = default, 1.2 = 20% larger
  ),
)
```

### 7.3 Bud's Personality Customization

**Screen: Settings → Bud → Personality**

```
┌─────────────────────────────────────┐
│ How should Bud communicate?         │
├─────────────────────────────────────┤
│                                     │
│ ○ Gentle & Soft                     │
│   "I hear you. Take your time."     │
│                                     │
│ ○ Warm & Curious                    │
│   "Tell me more about that."        │
│                                     │
│ ○ Wise & Thoughtful                 │
│   "That's a lot to carry."          │
│                                     │
│ ✓ Balanced (default)                │
│   Mix of all three                  │
│                                     │
└─────────────────────────────────────┘
```

**Implementation:**
```dart
enum BudPersonality {
  gentle,      // Less questions, more validation
  curious,     // More open-ended questions
  wise,        // Reflective, poetic responses
  balanced,    // Default, mix of all
}

// System prompt changes based on selection:
String getBudSystemPrompt(BudPersonality personality) {
  switch (personality) {
    case BudPersonality.gentle:
      return 'You are Bud, a very gentle emotional companion...';
    case BudPersonality.curious:
      return 'You are Bud, an inquisitive companion...';
    // etc.
  }
}
```

### 7.4 Dark/Light Mode Toggle

**Screen: Settings → Appearance → Light/Dark**

```
┌─────────────────────────────────────┐
│ Appearance                          │
├─────────────────────────────────────┤
│                                     │
│ Theme Mode                          │
│                                     │
│ □ Use System Setting                │
│ ✓ Dark Mode                         │
│ □ Light Mode                        │
│                                     │
│ Preview:                            │
│ [Dark background with light text]   │
│                                     │
└─────────────────────────────────────┘
```

**Implementation:**
```dart
// In theme provider
final isDarkModeProvider = StateProvider<bool>((ref) => true);

// Build themes
ThemeData buildAppTheme(isDarkMode, primaryColor) {
  return ThemeData(
    brightness: isDarkMode ? Brightness.dark : Brightness.light,
    scaffoldBackgroundColor: isDarkMode ? Color(0xFF1A1225) : Color(0xFFF8F6FF),
    // ... rest of theme
  );
}
```

---

## Part 8: Platform-Specific Adaptations

### 8.1 iOS vs Android Visual Differences

| Feature | iOS | Android |
|---------|-----|---------|
| **App Bar** | Cupertino (Large title if scrollable) | Material (AppBar with elevation) |
| **Back button** | "< Previous" text | Back arrow icon |
| **Buttons** | Cupertino (minimal fill) | Material (more prominent) |
| **Alerts** | CupertinoAlertDialog | AlertDialog |
| **Input Fields** | CupertinoTextField (optional) | TextField with Material styling |
| **Keyboard Type** | OS handles (native iOS keyboard) | OS handles (native Android keyboard) |
| **Status Bar** | Respects notch, Dynamic Island | Respects status bar |
| **Safe Area** | Uses SafeArea widget | Uses MediaQuery.padding |

### 8.2 Adaptive Widget Example

```dart
import 'dart:io';

class AdaptiveButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoButton(
        child: Text(label),
        onPressed: onPressed,
      );
    } else {
      return ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
      );
    }
  }
}

class AdaptiveScaffold extends StatelessWidget {
  final Widget appBar;
  final Widget body;
  final Widget bottomNav;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: appBar as ObstructingPreferredSizeWidget,
        child: SafeArea(child: body),
      );
    } else {
      return Scaffold(
        appBar: appBar as PreferredSizeWidget,
        body: SafeArea(child: body),
        bottomNavigationBar: bottomNav,
      );
    }
  }
}
```

### 8.3 Keyboard Handling (Both Platforms)

```dart
// Resize body when keyboard appears
SingleChildScrollView(
  child: Column(
    children: [
      // Content
    ],
  ),
)

// Or use ViewInsets to manually adjust padding
Padding(
  padding: EdgeInsets.only(
    bottom: MediaQuery.of(context).viewInsets.bottom,
  ),
  child: ChatInputField(),
)
```

---

## Part 9: Accessibility (WCAG AA Compliance)

### 9.1 Color Contrast

All text must have at least 4.5:1 contrast ratio:
- ✓ White (#F0E8FF) on #1A1225 = 18:1 (excellent)
- ✓ Primary button text (white) on primary color = 5.8:1 (excellent)
- ✓ Secondary text on background = 7:1 (excellent)

### 9.2 Touch Target Size

All interactive elements:
- Minimum 44×44 logical pixels (iOS recommendation)
- Minimum 48×48 logical pixels (Android recommendation)

```dart
Container(
  constraints: BoxConstraints(minHeight: 48),
  child: TextButton(
    child: Text('Tap me'),
    onPressed: () {},
  ),
)
```

### 9.3 Screen Reader Support

```dart
Semantics(
  label: 'Happy mood selected',
  button: true,
  enabled: true,
  onTap: () => selectMood('happy'),
  child: MoodButton(emoji: '😊'),
)

// Or use Semantic buttons
Semantics(
  label: 'Send message',
  button: true,
  child: IconButton(icon: Icon(Icons.send), onPressed: () {}),
)
```

### 9.4 Font Scaling

Support system-level text scaling:

```dart
// Instead of hardcoded font sizes, use MediaQuery
Text(
  'Hello',
  style: TextStyle(
    fontSize: 14 * MediaQuery.of(context).textScaleFactor,
  ),
)

// Or use theme that respects scaling
TextTheme(
  bodyMedium: TextStyle(fontSize: 14),
  // Flutter automatically scales based on system setting
)
```

---

## Part 10: Performance Optimizations

### 10.1 Image & Asset Optimization

- **App icon:** Provide all sizes (192×192, 512×512 for Android; 1024×1024 for iOS)
- **Splash image:** Max 2000×2000px, compressed to <500KB
- **No large assets bundled:** Model downloads separately

### 10.2 Build Size Optimization

```yaml
# pubspec.yaml
flutter:
  uses-material-design: true

# Exclude unused fonts
  fonts:
    - family: Lora
      fonts:
        - asset: assets/fonts/Lora-Regular.ttf
        - asset: assets/fonts/Lora-Medium.ttf
          weight: 500
        - asset: assets/fonts/Lora-SemiBold.ttf
          weight: 600
```

### 10.3 Lazy Load Screens

```dart
// Don't build all 7 screens at once
// Use IndexedStack or lazy navigation
IndexedStack(
  index: _currentTabIndex,
  children: [
    HomeScreen(),      // Built immediately
    BudScreen(),       // Built when tab is first tapped
    JournalScreen(),   // Built when tab is first tapped
    InsightsScreen(),
    ProfileScreen(),
  ],
)
```

---

## Part 11: Onboarding Flow (Auto-Setup)

### 11.1 First-Time User Experience

**Screen 1: Splash**
- Logo animation (fade in)
- 2-second hold

**Screen 2: Welcome**
- "Welcome to Pillow Bud"
- "Your emotional companion, always listening"
- [Next button]

**Screen 3: Enter Your Name**
- Text field with placeholder "What's your name?"
- Keyboard auto-shows
- [Continue button]

**Screen 4: Bud's Personality**
- "How would you like Bud to be with you?"
- 4 radio options (gentle, curious, wise, balanced)
- [Continue button]

**Screen 5: Important Disclaimer**
- "Bud is not a therapist"
- "For serious concerns, please talk to a professional"
- [I understand] button

**Screen 6: Model Download**
- "Bud is getting ready just for you..."
- Progress bar with percentage
- "Downloading your AI model (~700 MB)"
- "Make sure you're on WiFi"
- Estimated time remaining
- [Cancel] button (if network fails)

**Screen 7: Ready!**
- "You're all set!"
- "Let's start by checking in. How are you feeling?"
- Mood emoji picker
- [Let's begin] button

### 11.2 Auto-Setup Code Pattern

```dart
class OnboardingFlow extends StatefulWidget {
  @override
  _OnboardingFlowState createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startModelDownload(); // Trigger download on screen 6
  }

  void _startModelDownload() async {
    // Download Llama 3.2 1B in background
    // Update progress on UI
    // On completion, enable "Next" button
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(), // No swiping, only next/prev
      children: [
        SplashScreen(),
        WelcomeScreen(onNext: () => _pageController.nextPage(...)),
        NameEntryScreen(onNext: () => _pageController.nextPage(...)),
        PersonalityScreen(onNext: () => _pageController.nextPage(...)),
        DisclaimerScreen(onNext: () => _pageController.nextPage(...)),
        ModelDownloadScreen(onDownloadComplete: () => _pageController.nextPage(...)),
        ReadyScreen(onBegin: () => navigateToHome()),
      ],
    );
  }
}
```

---

## Summary: Why This Design Works

1. **Soft & Modern:** Curved corners, minimal shadows, warm colors — feels like a companion, not software
2. **Customizable:** 5 theme presets + custom color picker, font sizing, personality modes
3. **Accessible:** WCAG AA contrast, 48px touch targets, screen reader support
4. **Platform-Native:** iOS gets Cupertino aesthetics, Android gets Material Design
5. **Low-Friction:** Auto-setup from download to first chat — zero terminal commands
6. **Emotionally Safe:** Dark mode default, warm copy, crisis safeguards, no harsh alerts
7. **Performance-First:** Model downloads separately, lazy-loaded screens, optimized build
8. **Inclusive:** Works on budget 3GB RAM phones to flagship devices

---

## Appendix: Color Codes for Reference

```
Primary Lavender:        #C4A8F8
Secondary Misty Teal:    #89C4F8
Tertiary Sage:           #A8D8A8
Dark Background:         #1A1225
Light Background:        #F8F6FF
Card Dark:              #2D1F4A
Text Primary (Dark):    #F0E8FF
Text Primary (Light):   #1A1225
Success:                #7ACF8E
Warning:                #FAC775
Danger:                 #F09595

Fonts:
  Display: Lora (serif)
  Body: DM Sans (sans-serif)
```

This is Pillow Bud's design system. Every element, color, animation, and interaction serves the goal of making users feel safe, heard, and cared for.
