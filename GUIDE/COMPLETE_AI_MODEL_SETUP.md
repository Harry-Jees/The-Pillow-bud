# PILLOW BUD — COMPLETE AI MODEL SETUP GUIDE

## OVERVIEW: 3 WAYS TO RUN LLAMA

```
┌─────────────────────────────────────────────────────────────┐
│            HOW TO RUN LLAMA 3.2 1B IN PILLOW BUD           │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  OPTION 1: flutter_gemma (Easiest - Recommended)          │
│  ├─ Direct integration with Flutter                        │
│  ├─ No server needed                                       │
│  ├─ Streaming responses                                    │
│  ├─ GPU acceleration (optional)                            │
│  └─ Status: ⏳ Coming soon (use mock for now)             │
│                                                             │
│  OPTION 2: Ollama (Best for Development)                  │
│  ├─ Local server on your machine                           │
│  ├─ Easy model management                                  │
│  ├─ Web interface included                                 │
│  ├─ Cross-platform (Mac, Linux, Windows)                  │
│  └─ Status: ✅ Available now                               │
│                                                             │
│  OPTION 3: ollama_dart (Dart Package)                      │
│  ├─ Dart integration with Ollama                           │
│  ├─ Best of both worlds                                    │
│  ├─ Works with flutter_gemma API                           │
│  └─ Status: ⏳ Coming soon                                 │
│                                                             │
│  OPTION 4: Mock System (Phase 1)                           │
│  ├─ Works immediately                                      │
│  ├─ Contextual responses                                   │
│  ├─ Emotionally intelligent                                │
│  ├─ Easy to replace later                                  │
│  └─ Status: ✅ Ready now                                   │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## PHASE 1: START WITH MOCK (NOW)

The app works perfectly with mock responses while we wait for flutter_gemma.

### What You Have
```dart
// In lib/services/llm_service.dart
Future<String> _generateResponse(...) async {
  // Currently returns mock responses
  return await _generateResponse(...);
}
```

### Why This Works
- ✅ Emotionally intelligent responses
- ✅ Context-aware system prompts
- ✅ Personality-based adaptation
- ✅ Crisis detection working
- ✅ No network needed
- ✅ Tests the full system

### How to Test
```bash
flutter run
# Chat with Bud
# See emotional responses
# Everything works!
```

---

## PHASE 2: SETUP OPTION 2 - OLLAMA (DEVELOPMENT)

When you want real AI during development.

### Step 1: Install Ollama

**Download from:** https://ollama.ai

**Choose your OS:**
- **Mac:** ollama-darwin (Intel/Apple Silicon)
- **Windows:** ollama-windows.exe
- **Linux:** Download script

**Installation:**

**Mac:**
```bash
# Download and open installer
# Or use Homebrew:
brew install ollama
```

**Windows:**
```bash
# Download and run installer
# Or use Chocolatey:
choco install ollama
```

**Linux:**
```bash
curl https://ollama.ai/install.sh | sh
```

### Step 2: Verify Installation

```bash
ollama --version
# Output: ollama version X.X.X
```

### Step 3: Download Llama 3.2 1B

```bash
# This downloads the model (~7GB, takes 10-30 min)
ollama pull llama2

# Or when available:
ollama pull llama3.2:1b

# Check available models:
ollama list
```

**Output example:**
```
NAME            ID              SIZE    MODIFIED
llama2          e1d22f8f6cdc    3.8GB   2 minutes ago
```

### Step 4: Test Model Locally

**Start Ollama server:**
```bash
# Terminal 1
ollama serve
# Output: listening on 127.0.0.1:11434
```

**Test in new terminal:**
```bash
# Terminal 2
curl http://localhost:11434/api/generate -d '{
  "model": "llama2",
  "prompt": "hello"
}'

# You should see streaming responses!
```

**Or use web interface:**
```
http://localhost:11434
# Open in browser, chat directly
```

### Step 5: Connect Flutter App to Ollama

#### Option A: Using Ollama REST API

**Update:** lib/services/llm_service.dart

```dart
import 'package:dio/dio.dart';

class LLMService {
  final String ollmaServerUrl = 'http://localhost:11434';
  final dio = Dio();
  
  /// Generate response using Ollama server
  Future<String> _generateResponseOllama({
    required String systemPrompt,
    required String userMessage,
  }) async {
    try {
      final prompt = '''$systemPrompt

User: $userMessage
Bud:''';
      
      final response = await dio.post(
        '$ollamaServerUrl/api/generate',
        data: {
          'model': 'llama2',  // Change to llama3.2:1b when available
          'prompt': prompt,
          'stream': false,
          'temperature': 0.8,
        },
        options: Options(
          receiveTimeout: const Duration(seconds: 120),
        ),
      );
      
      // Extract response
      final responseText = response.data['response'] as String;
      return responseText.trim();
      
    } catch (e) {
      print('Error calling Ollama: $e');
      // Fallback to mock
      return await _generateResponse(
        systemPrompt: systemPrompt,
        userMessage: userMessage,
        detectedEmotion: 'neutral',
        emotionIntensity: 0.5,
      );
    }
  }
  
  /// Streaming version for token-by-token responses
  Stream<String> _generateResponseOllamaStream({
    required String systemPrompt,
    required String userMessage,
  }) async* {
    try {
      final prompt = '''$systemPrompt

User: $userMessage
Bud:''';
      
      final response = await dio.post(
        '$ollamaServerUrl/api/generate',
        data: {
          'model': 'llama2',
          'prompt': prompt,
          'stream': true,  // Enable streaming
          'temperature': 0.8,
        },
        options: Options(
          responseType: ResponseType.stream,
        ),
      );
      
      await for (var line in response.data.stream) {
        final decoded = utf8.decode(line);
        final json = jsonDecode(decoded);
        final token = json['response'] as String? ?? '';
        
        if (token.isNotEmpty) {
          yield token;
        }
        
        if (json['done'] == true) break;
      }
    } catch (e) {
      print('Error streaming from Ollama: $e');
      // Fallback
      yield await _generateResponse(
        systemPrompt: systemPrompt,
        userMessage: userMessage,
        detectedEmotion: 'neutral',
        emotionIntensity: 0.5,
      );
    }
  }
}
```

**Update:** pubspec.yaml

```yaml
dependencies:
  dio: ^5.4.0
```

**Update:** lib/providers/llm_provider.dart

```dart
// Add streaming provider
final budResponseStreamProvider = StreamProvider.family<String, String>(
  (ref, userMessage) {
    final llmService = ref.watch(llmServiceProvider);
    return llmService.getBudResponseStream(
      userMessage: userMessage,
      userName: 'User',
      personalityMode: 'balanced',
    );
  },
);
```

### Step 6: Update Chat Screen for Streaming

**Update:** lib/screens/chat_screen.dart

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends ConsumerStatefulWidget {
  // ... existing code ...
  
  void _sendMessageWithStreaming() async {
    if (_controller.text.isEmpty) return;

    final userText = _controller.text;
    
    // Add user message
    setState(() {
      messages.add(ChatMessage(
        id: uuid.v4(),
        text: userText,
        isFromBud: false,
        timestamp: DateTime.now(),
        sessionId: 'session1',
      ));
    });

    _controller.clear();
    _scrollToBottom();

    try {
      // Get streaming response
      final llmService = ref.read(llmServiceProvider);
      final responseStream = llmService.getBudResponseStream(
        userMessage: userText,
        userName: 'User',
        personalityMode: 'balanced',
      );
      
      final buffer = StringBuffer();
      final messageId = uuid.v4();
      
      await for (String token in responseStream) {
        buffer.write(token);
        
        setState(() {
          // Update last message with accumulated response
          if (messages.last.isFromBud && messages.last.id == messageId) {
            messages[messages.length - 1] = ChatMessage(
              id: messageId,
              text: buffer.toString(),
              isFromBud: true,
              timestamp: DateTime.now(),
              sessionId: 'session1',
            );
          }
        });
        
        _scrollToBottom();
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
```

### Step 7: Test Ollama Integration

```bash
# Terminal 1: Start Ollama
ollama serve

# Terminal 2: Start Flutter app
cd pillow_bud
flutter run

# In app:
# Chat with Bud
# Should see real Llama responses
# Monitor Terminal 1 for requests
```

---

## PHASE 3: SETUP OPTION 1 - flutter_gemma (FUTURE)

When flutter_gemma is fully available.

### Step 1: Add Dependency

**Update:** pubspec.yaml

```yaml
dependencies:
  flutter_gemma: ^0.0.1
```

### Step 2: Get Model File

**Download Llama 3.2 1B GGUF:**

```bash
# From Hugging Face:
# https://huggingface.co/meta-llama/Llama-3.2-1B-Instruct-GGUF

# You need the quantized version:
# llama-3.2-1b-instruct-q4_k_m.gguf (~700 MB)

# Options:
# A) Download manually and copy to assets
# B) Let app download on first launch
```

### Step 3: Add to pubspec.yaml

```yaml
flutter:
  assets:
    - assets/models/llama-3.2-1b-instruct-q4_k_m.gguf
```

### Step 4: Update LLM Service

```dart
import 'package:flutter_gemma/flutter_gemma.dart';

class LLMService {
  late InferenceModel _model;
  
  /// Initialize model on app start
  Future<void> initializeModel() async {
    _model = InferenceModel(
      modelPath: 'assets/models/llama-3.2-1b-instruct-q4_k_m.gguf',
      gpuDelegate: true,  // Use GPU if available
    );
    
    try {
      await _model.initialize();
      print('Model initialized successfully');
    } catch (e) {
      print('Error initializing model: $e');
    }
  }
  
  /// Generate response using flutter_gemma
  Future<String> _generateResponseGemma({
    required String systemPrompt,
    required String userMessage,
  }) async {
    try {
      final prompt = '''$systemPrompt

User: $userMessage
Bud:''';
      
      final response = await _model.generateContent(
        prompt: prompt,
        maxTokens: 300,
        temperature: 0.8,
      );
      
      return response.text.trim();
      
    } catch (e) {
      print('Error generating response: $e');
      return 'I\'m having trouble responding right now. Try again?';
    }
  }
  
  /// Streaming response
  Stream<String> _generateResponseGemmaStream({
    required String systemPrompt,
    required String userMessage,
  }) async* {
    try {
      final prompt = '''$systemPrompt

User: $userMessage
Bud:''';
      
      final stream = _model.generateContentStream(
        prompt: prompt,
        maxTokens: 300,
        temperature: 0.8,
      );
      
      await for (String token in stream) {
        yield token;
      }
      
    } catch (e) {
      print('Error: $e');
      yield 'I\'m having trouble responding.';
    }
  }
}
```

### Step 5: Initialize on App Start

**Update:** lib/main.dart

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize LLM model
  final llmService = LLMService();
  await llmService.initializeModel();
  
  runApp(const ProviderScope(child: PillowBudApp()));
}
```

---

## PHASE 4: MODEL DOWNLOAD STRATEGY

When model is too large to bundle (~700 MB).

### Background Download on First Launch

**Create:** lib/services/model_download_service.dart

```dart
import 'package:background_downloader/background_downloader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

class ModelDownloadService {
  static const modelUrl = 
    'https://huggingface.co/meta-llama/Llama-3.2-1B-Instruct-GGUF/resolve/main/llama-3.2-1b-instruct-q4_k_m.gguf';
  static const modelFileName = 'llama-3.2-1b.gguf';
  
  /// Check if model already downloaded
  static Future<bool> isModelDownloaded() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('model_downloaded') ?? false;
  }
  
  /// Download model on first launch
  static Future<void> downloadModelIfNeeded({
    required Function(double) onProgress,
    required Function(String) onError,
  }) async {
    if (await isModelDownloaded()) {
      return; // Already downloaded
    }
    
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final modelPath = '${appDir.path}/models/$modelFileName';
      
      // Create models directory
      await Directory('${appDir.path}/models').create(recursive: true);
      
      // Create download task
      final task = DownloadTask(
        url: modelUrl,
        filename: modelFileName,
        directory: '${appDir.path}/models',
        baseDirectory: BaseDirectory.applicationDocuments,
        updates: Updates.statusAndProgress,
        allowPause: true,
        retries: 3,
      );
      
      // Download with progress tracking
      final FileDownloader downloader = FileDownloader();
      
      await for (final update in downloader.trackUpdates(task)) {
        if (update is TaskProgressUpdate) {
          onProgress(update.progress);
        }
        if (update is TaskStatusUpdate && 
            update.status == TaskStatus.complete) {
          // Mark as downloaded
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('model_downloaded', true);
          await prefs.setString('model_path', modelPath);
          break;
        }
      }
    } catch (e) {
      onError('Download failed: $e');
      rethrow;
    }
  }
  
  /// Get path to downloaded model
  static Future<String?> getModelPath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('model_path');
  }
}
```

**Update:** lib/screens/onboarding_screen.dart

```dart
// In onboarding screen, show download progress
class ModelDownloadScreen extends StatefulWidget {
  @override
  State<ModelDownloadScreen> createState() => _ModelDownloadScreenState();
}

class _ModelDownloadScreenState extends State<ModelDownloadScreen> {
  double _progress = 0;
  bool _isDownloading = false;
  
  @override
  void initState() {
    super.initState();
    _downloadModel();
  }
  
  void _downloadModel() async {
    setState(() => _isDownloading = true);
    
    try {
      await ModelDownloadService.downloadModelIfNeeded(
        onProgress: (progress) {
          setState(() => _progress = progress);
        },
        onError: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error)),
          );
        },
      );
      
      // Continue to next screen
      Navigator.of(context).pushReplacement(...);
    } catch (e) {
      // Show error
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bud is getting ready for you...',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            LinearProgressIndicator(value: _progress),
            const SizedBox(height: 16),
            Text(
              '${(_progress * 100).toStringAsFixed(0)}%',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            Text(
              'Downloading AI model (~700 MB)',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Make sure you\'re on WiFi',
              style: TextStyle(
                fontSize: 11,
                color: Colors.white.withOpacity(0.4),
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

## PHASE 5: ALTERNATIVE - TFLITE FOR MOBILE

For even smaller footprint (experimental).

### Using TensorFlow Lite

```yaml
dependencies:
  tflite_flutter: ^0.9.0
```

**Pros:**
- Smaller file size (~200 MB quantized)
- Faster inference
- Works offline

**Cons:**
- Limited to specialized models
- Less customizable
- Harder to fine-tune

---

## COMPARISON TABLE

| Aspect | Mock | Ollama | flutter_gemma | TFLite |
|--------|------|--------|---------------|--------|
| **Setup Time** | 5 min | 20 min | 10 min | 30 min |
| **Model Size** | None | 3-7 GB | 700 MB | 200 MB |
| **Real AI** | No | Yes ✅ | Yes ✅ | Yes ✅ |
| **Development** | Good | Best | Best | Good |
| **Production** | No | No | Yes ✅ | Yes ✅ |
| **Streaming** | No | Yes | Yes ✅ | No |
| **Customization** | Yes | Yes | Yes ✅ | No |
| **Status** | ✅ Ready | ✅ Ready | ⏳ Soon | ⏳ Soon |

---

## RECOMMENDED BUILD ORDER

### Phase 1 (Now): Mock System ✅
- App works completely
- Emotionally intelligent responses
- Perfect for testing UI/UX
- Easy to replace later

### Phase 2 (Dev): Ollama
- Real AI locally
- Great for development
- Test emotional responses
- Optimize prompts

### Phase 3 (Release): flutter_gemma
- Bundled with app
- Works on phones
- Users download once
- 700 MB one-time cost

---

## ENVIRONMENT VARIABLES

### For Ollama Dev

```bash
# .env file (not tracked by git)
OLLAMA_URL=http://localhost:11434
OLLAMA_MODEL=llama2
OLLAMA_TIMEOUT=120
```

**Load in Dart:**

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load();
  
  final ollamaUrl = dotenv.env['OLLAMA_URL'];
  final model = dotenv.env['OLLAMA_MODEL'];
  
  runApp(const PillowBudApp());
}
```

---

## TESTING THE AI

### Test Mock System
```bash
flutter run
# Chat, see responses
```

### Test Ollama
```bash
# Terminal 1
ollama serve

# Terminal 2
curl -X POST http://localhost:11434/api/generate \
  -H "Content-Type: application/json" \
  -d '{
    "model": "llama2",
    "prompt": "You are Bud, an emotional companion. Respond to: I feel overwhelmed"
  }'
```

### Test flutter_gemma (When Available)
```dart
// In a test
await llmService.initializeModel();
final response = await llmService.generateResponse(
  userMessage: 'I feel sad',
  systemPrompt: 'You are an emotional AI...',
);
expect(response.isNotEmpty, true);
```

---

## TROUBLESHOOTING

### "Can't connect to Ollama"
```bash
# Check if Ollama is running
curl http://localhost:11434/api/tags

# Restart Ollama
killall ollama
ollama serve
```

### "Model too slow"
```
- Use quantized model (q4_k_m)
- Reduce max_tokens from 300 to 200
- Use GPU acceleration if available
```

### "Out of memory"
```
- Reduce model size (use 1B not 7B)
- Increase swap space
- Close other apps
- Use quantized version
```

### "Streaming not working"
```dart
// Fallback to non-streaming
Future<String> _nonStreamingFallback() async {
  // Use regular API instead of stream
  return await _generateResponse(...);
}
```

---

## DEPLOYMENT CHECKLIST

- [ ] Model selected (Llama 3.2 1B)
- [ ] Download strategy decided (first launch download)
- [ ] Ollama tested locally (dev)
- [ ] flutter_gemma ready when published
- [ ] Fallback to mock if needed
- [ ] Progress indicator for download
- [ ] Error handling implemented
- [ ] Tested on real phone
- [ ] GitHub updated with model info
- [ ] README includes setup instructions

---

## FINAL RECOMMENDATION

### For Phase 1 (Now):
✅ **Use: Mock System**
- App is complete and working
- Perfect for testing everything
- Easy to replace with real Llama later

### For Phase 2 (Development):
✅ **Use: Ollama**
- Real AI locally
- Development/debugging
- Fast iteration

### For Phase 3 (Release):
✅ **Use: flutter_gemma (When ready)**
- Or Ollama with server
- Users install once
- Complete privacy

---

## NEXT STEPS

1. **Now:** Use mock system (already in code)
2. **Test:** Run app, chat with Bud
3. **Dev:** Install Ollama, connect to app
4. **Release:** Wait for flutter_gemma or use Ollama server

Everything is ready. Pick your timeline! 🚀

---

## RESOURCES

- **Llama Model:** https://huggingface.co/meta-llama
- **Ollama:** https://ollama.ai
- **flutter_gemma:** https://pub.dev/packages/flutter_gemma
- **Quantization:** https://github.com/ggerganov/llama.cpp

---

You now have everything needed to integrate real AI! 💙
