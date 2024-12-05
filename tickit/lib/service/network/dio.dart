import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickit/service/network/custom_interceptor.dart';
import 'package:tickit/service/storage/secure_storage.dart';

final dioProvider = Provider((ref) {
  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000),
      sendTimeout: const Duration(milliseconds: 30 * 1000),
    ),
  );

  final storage = ref.watch(secureStorageProvider);
  dio.interceptors.add(CustomInterceptor(
    storage: storage,
    dio: dio,
  ));

  return dio;
});
