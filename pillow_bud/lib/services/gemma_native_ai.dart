import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:path_provider/path_provider.dart';
import 'local_ai_service.dart';

class GemmaNativeAI extends LocalAIService {
  static bool _flutterGemmaInitialized = false;
  static InferenceModel? _globalModel;

  static Future<String?> installFromAsset() async {
    try {
      if (!_flutterGemmaInitialized) {
        await FlutterGemma.initialize(maxDownloadRetries: 5).timeout(const Duration(seconds: 30));
        _flutterGemmaInitialized = true;
      }

      final installed = await FlutterGemma.listInstalledModels();
      if (installed.isNotEmpty) {
        debugPrint('GemmaNativeAI: Model already installed, skipping asset install.');
        _globalModel = await FlutterGemma.getActiveModel(
          maxTokens: 1024,
          supportImage: false,
          supportAudio: false,
        );
        return null;
      }

      final dir = await getTemporaryDirectory();
      final tmpFile = File('${dir.path}/smolLM.task');
      final data = await rootBundle.load('assets/models/smolLM.task');
      await tmpFile.writeAsBytes(data.buffer.asUint8List());

      await FlutterGemma.installModel(
        modelType: ModelType.general,
        fileType: ModelFileType.task,
      )
        .fromFile(tmpFile.path)
        .install()
        .timeout(const Duration(seconds: 30));

      _globalModel = await FlutterGemma.getActiveModel(
        maxTokens: 1024,
        supportImage: false,
        supportAudio: false,
      );
      return null;
    } on TimeoutException {
      return 'Installation timed out. Try again.';
    } catch (e) {
      return e.toString();
    }
  }

  InferenceModel? _model;
  bool _initialized = false;
  String? _error;
  String _status = 'pending';

  @override
  String? get error => _error;

  @override
  String get status => _status;

  @override
  String get name => 'Gemma';

  @override
  Future<void> initialize() async {
    if (_initialized) return;
    _status = 'initializing';
    try {
      if (!_flutterGemmaInitialized) {
        await FlutterGemma.initialize();
        _flutterGemmaInitialized = true;
      }
      _status = 'checking_model';

      if (_globalModel != null) {
        _model = _globalModel;
      } else {
        if (!FlutterGemma.hasActiveModel()) {
          final installed = await FlutterGemma.listInstalledModels();
          if (installed.isEmpty) {
            _status = 'no_model';
            debugPrint('GemmaNativeAI: No model installed. Install from asset first.');
            return;
          }
        }

        _model = await FlutterGemma.getActiveModel(
          maxTokens: 1024,
          supportImage: false,
          supportAudio: false,
        );
        _globalModel ??= _model;
      }
      _initialized = true;
      _status = 'ready';
      debugPrint('GemmaNativeAI: Initialized successfully');
    } catch (e) {
      _error = e.toString();
      _status = 'error';
      debugPrint('GemmaNativeAI: Initialization failed: $e');
    }
  }

  @override
  bool get isReady => _initialized && FlutterGemma.hasActiveModel();

  @override
  Future<String> generateResponse({
    required String systemPrompt,
    required String userMessage,
    String? recentContext,
  }) async {
    if (!isReady) throw StateError('Gemma not initialized');

    final chat = await _model!.createChat(
      temperature: 0.8,
      randomSeed: 42,
      topK: 1,
      topP: 0.9,
      tokenBuffer: 256,
      supportImage: false,
      supportAudio: false,
      supportsFunctionCalls: false,
      isThinking: false,
    );

    await chat.addQueryChunk(Message.text(text: systemPrompt, isUser: true));
    await chat.generateChatResponse();

    if (recentContext != null && recentContext.isNotEmpty) {
      await chat.addQueryChunk(Message.text(text: recentContext, isUser: true));
      await chat.generateChatResponse();
    }

    await chat.addQueryChunk(Message.text(text: userMessage, isUser: true));
    final response = await chat.generateChatResponse();

    if (response is TextResponse && response.token.trim().isNotEmpty) {
      return response.token.trim();
    }
    throw StateError('Empty response from Gemma');
  }
}
