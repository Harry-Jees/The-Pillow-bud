# Pillow Bud Tech Stack — Visual Summary

## 6-Layer Architecture

```
┌──────────────────────────────────────────────────────┐
│        PRESENTATION LAYER (Flutter UI)               │
│  • Material Design 3 + Cupertino (iOS)               │
│  • google_fonts (Lora + DM Sans)                     │
│  • flutter_animate (smooth transitions)              │
│  • Custom theme system (5 presets + custom colors)   │
└────────────────────┬─────────────────────────────────┘
                     │
┌────────────────────▼─────────────────────────────────┐
│      STATE MANAGEMENT LAYER (Riverpod)               │
│  • riverpod 2.5.1 (type-safe, reactive)              │
│  • flutter_riverpod 2.5.1                            │
│  • StateProvider, FutureProvider, StateNotifier      │
│  • Global state: user, mood, chat, theme, model      │
└────────────────────┬─────────────────────────────────┘
                     │
        ┌────────────┴──────────┬───────────┐
        │                       │           │
┌───────▼─────┐    ┌──────┬────▼────┐   ┌──▼──────┐
│  DATABASE   │    │  AI  │ DOWNLOAD│   │UTILITIES│
│   LAYER     │    │LAYER │ MANAGER │   │ LAYER   │
├─────────────┤    ├──────┴─────────┤   ├─────────┤
│ • Isar 4.2  │    │flutter_gemma   │   │ intl    │
│ • 5 Colls.  │    │Llama 3.2 1B    │   │datetime │
│ • Encrypted │    │(700MB)         │   │ utils   │
│ • Type-safe │    │ • Streaming    │   │ Crisis  │
│             │    │ • Local only   │   │Detector │
│ • Shared    │    │ • 4 voices     │   │         │
│   Prefs     │    │ • 0.8 temp     │   │ bg_dl   │
│             │    │ • 256 tokens   │   │7.15.0   │
└─────────────┘    │                │   │         │
                   │ background     │   │ path    │
                   │ _downloader    │   │ prov.   │
                   │ 7.15.0         │   └─────────┘
                   │ • Resumable    │
                   │ • Progress bar │
                   │ • WiFi check   │
                   └────────────────┘
```

---

## Dependency Map

```
pillow_bud
├── flutter (framework)
│   ├── cupertino_icons (iOS icons)
│   └── material (Android design)
│
├── UI & Theming
│   ├── google_fonts → Lora + DM Sans
│   └── flutter_animate → transitions
│
├── State Management
│   ├── riverpod → providers
│   └── flutter_riverpod → integration
│
├── Data Layer
│   ├── isar → local database (500KB)
│   │   └── isar_flutter_libs
│   └── shared_preferences → settings
│
├── AI Engine
│   ├── flutter_gemma → LLM integration
│   │   └── Llama 3.2 1B (700MB downloaded)
│   └── background_downloader → model download
│
└── Utilities
    └── intl → date/time formatting
```

---

## Data Flow Diagram

```
User Input (Chat Message)
         │
         ▼
┌─────────────────────┐
│ Crisis Detector     │  ← Checks for harm phrases
└────────┬────────────┘
         │
    ┌────┴─────┐
    │           │
   YES (safe)  NO (crisis)
    │           │
    │           └─→ Show Crisis Dialog
    │               (Helpline numbers)
    ▼
┌─────────────────────┐
│ Riverpod Provider   │  ← Triggers LLM
└────────┬────────────┘
         │
         ▼
┌─────────────────────┐
│ Llama 3.2 1B        │  ← Generates response
│ (Local, on-device)  │    (2-5 seconds)
└────────┬────────────┘
         │
         ▼
┌─────────────────────┐
│ Token Stream        │  ← Yields tokens
│ (1 token at a time) │    (animated typing)
└────────┬────────────┘
         │
    ┌────┴──────────────┐
    │                   │
    ▼                   ▼
┌─────────────────┐  ┌─────────────────┐
│ Update UI       │  │ Save to Isar DB │
│ (Show Bud reply)│  │ (Chat history)  │
└─────────────────┘  └─────────────────┘
```

---

## Storage Architecture

```
App Installation
├── Flutter App (~25 MB)
│   ├── Main.dart
│   ├── Screens (7 screens)
│   ├── Widgets (components)
│   ├── Services (logic)
│   └── Assets (fonts, icons)
│
├── Dependencies (~3 MB)
│   ├── riverpod
│   ├── isar
│   ├── google_fonts
│   └── others
│
└── On First Launch
    │
    ├─ Download Llama 3.2 1B (700 MB)
    │  └─ Saved to: /app/models/llama-3.2-1b.gguf
    │
    ├─ Create Isar DB (encrypted)
    │  └─ Collections: messages, journal, moods, preferences
    │
    └─ Create SharedPreferences
       └─ Keys: isDarkMode, primaryColor, modelPath, userName

Total at Rest (no model): ~100 MB
Total at Runtime: ~150-200 MB (including loaded model)
```

---

## Performance Targets

| Operation | Target | Tech |
|-----------|--------|------|
| **App Startup** | < 3 seconds | Flutter + Riverpod caching |
| **Model Load** | 1-2 seconds | flutter_gemma lazy load |
| **Bud Response** | 2-5 seconds | Llama 3.2 1B (depends on RAM) |
| **Chat Message Send** | < 500ms | Riverpod + Isar |
| **Journal Save** | < 100ms | Isar transactions |
| **Database Query** | < 100ms | Isar indexing |
| **Memory Usage** | < 200MB | Isar + model in RAM |
| **Build Size** | 35-50MB | Minimal dependencies |

---

## Platform Support

### Android
```
Min SDK: 26 (Android 8.0)
Target SDK: 34
Architectures: arm64-v8a, armeabi-v7a, x86_64
Min RAM: 3 GB
```

### iOS
```
Min iOS: 15.0
Architectures: arm64
Min RAM: 3 GB
Phone: iPhone 11+
```

---

## Why This Tech Stack?

### ✅ Flutter
- Single codebase for iOS + Android
- Hot reload (99% faster development)
- Excellent performance on mobile
- Mature ecosystem

### ✅ Riverpod
- Type-safe (no runtime errors from wrong types)
- Works perfectly with async operations
- Clean architecture (easy to test)
- No BuildContext needed

### ✅ Isar
- Ultra-fast local database (no server)
- Encrypted automatically
- Works offline (no internet needed)
- Type-safe queries

### ✅ flutter_gemma + Llama
- Run AI locally (no cloud costs)
- Privacy first (data never leaves device)
- Free and open source (Apache 2.0)
- Works on budget phones (3GB RAM)

### ✅ background_downloader
- Resume broken downloads automatically
- Show real progress to user
- WiFi-only option for large files
- Lightweight (~200KB)

### ✅ Zero External APIs
- No Firebase, no backend, no costs
- No telemetry, no tracking
- No dependency on cloud services
- Users own their data

---

## Build Artifacts

### Android APK
```
apk
├── classes.dex (50%)          → Flutter VM + plugins
├── resources.pb (20%)          → Assets
├── lib/ (20%)                  → Native libraries
└── metadata (10%)              → Manifest, config

Total: 35-45 MB
```

### iOS IPA
```
ipa
├── Flutter.framework (40%)     → Flutter runtime
├── App.framework (30%)         → App code
├── Plugins (20%)               → Plugin frameworks
└── Resources (10%)             → Assets, strings

Total: 40-50 MB
```

### Models (Downloaded Separately)
```
Model File: llama-3.2-1b.gguf
├── Weights (98%)               → Neural network parameters
├── Tokenizer (1%)              → Text encoding
└── Config (1%)                 → Model settings

Total: 700 MB
```

---

## Dependency Versions (Locked)

```yaml
# Core
flutter: '>=3.0.0'

# State Management
riverpod: 2.5.1
flutter_riverpod: 2.5.1

# Database
isar: 4.2.0
isar_flutter_libs: 4.2.0

# AI
flutter_gemma: 0.0.1

# Downloads
background_downloader: 7.15.0

# UI
google_fonts: 6.1.0
flutter_animate: 4.3.0
cupertino_icons: 1.0.5

# Storage
shared_preferences: 2.2.2

# Utilities
intl: 0.19.0
path_provider: 2.1.1
```

---

## Security & Privacy

```
Data Flow:
User Input → Crisis Detector → LLM (local) → Encrypted DB
                                              (on-device only)

Network:
├── First Launch: Download model (700 MB) → saved locally
└── Every other use: 0 bytes → fully offline

Encryption:
├── Isar: Automatic (no extra code needed)
├── SharedPreferences: Encrypted on iOS + Android Q+
└── Model: Downloaded to private app directory

No External Calls:
❌ No Firebase
❌ No Google Analytics
❌ No Sentry
❌ No API calls
❌ No telemetry
❌ No tracking cookies
```

---

## Future Tech Stack Additions (Not in v1)

These can be added later without breaking current architecture:

```yaml
# Analytics (optional, privacy-friendly)
posthog_flutter: ^2.0.0        # Or none in v1

# Advanced ML (optional)
tensorflow: ^2.11.0            # For sentiment analysis
image: ^4.0.0                  # For image processing

# Notifications (optional)
flutter_local_notifications: ^14.0.0  # No Firebase needed

# Internationalization (easy to add)
flutter_localizations:         # i18n support
intl: ^0.19.0                  # Already included

# Sync (optional, self-hosted)
supabase_flutter: ^2.0.0       # For web sync (if added later)
```

---

## Summary

**This tech stack is:**

✅ **Minimal** — Only essentials, nothing extra
✅ **Fast** — Hot reload, quick build times
✅ **Secure** — Everything local, encrypted by default
✅ **Free** — Open source, zero costs
✅ **Maintainable** — Clean architecture, type-safe
✅ **Scalable** — Easy to add features later
✅ **Professional** — Production-ready from day 1

**Total setup time: < 1 hour**
**Build time: 2-4 weeks (with AI assistance)**
**Launch time: Day 20 (ready for GitHub)**

You're ready to start! 🚀
