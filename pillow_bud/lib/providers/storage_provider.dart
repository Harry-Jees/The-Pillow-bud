import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/storage_service.dart';
import '../services/isar_storage_service.dart';
import '../services/web_storage_service.dart';

final storageServiceProvider = FutureProvider<StorageService>((ref) async {
  final service = kIsWeb
      ? WebStorageService()
      : IsarStorageService();
  await service.initialize();
  return service;
});
