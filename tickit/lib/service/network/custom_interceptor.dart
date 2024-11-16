import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tickit/config/key.dart';

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  const CustomInterceptor({
    required this.storage,
  });

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    debugPrint("[REQ] ${options.uri}");
    debugPrint("\t\tbody: ${options.data}");
    debugPrint("\t\theader: ${options.headers}");

    if (options.headers.containsKey('accessToken')) {
      options.headers.remove('accessToken');

      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      options.headers['Authorization'] = 'Bearer $token';
    }

    if (options.headers.containsKey('refreshToken')) {
      options.headers.remove('refreshToken');

      final token = await storage.read(key: REFRESH_TOKEN_KEY);
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);

    debugPrint("[RES] ${response.data.toString()}");
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    super.onError(err, handler);

    if (err.response?.statusCode == 401) {
      final dio = Dio();
      final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
      // accessToken update 로직
    }
  }
}