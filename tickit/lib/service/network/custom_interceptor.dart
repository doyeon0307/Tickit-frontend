import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tickit/config/ip.dart';
import 'package:tickit/config/key.dart';

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;
  final Dio dio;

  const CustomInterceptor({
    required this.storage,
    required this.dio,
  });

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // debugPrint("[REQ] ${options.uri}");
    debugPrint("[REQ]");
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
    final isStatus401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == "api/auth/refresh";

    try {
      if (isStatus401 && !isPathRefresh) {
        final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

        if (refreshToken == null) {
          throw DioException(
            requestOptions: err.requestOptions,
            error: 'Refresh Token을 찾을 수 업습니다.',
          );
        }

        final result = await dio.post(
          "http://$ip/api/auth/refresh",
          data: {"refreshToken": refreshToken},
        );

        final newAccessToken = result.data["data"]["accessToken"];
        final newRefreshToken = result.data["data"]["refreshToken"];

        await Future.wait([
          storage.write(key: ACCESS_TOKEN_KEY, value: newAccessToken),
          storage.write(key: REFRESH_TOKEN_KEY, value: newRefreshToken),
        ]);

        debugPrint("[TOKEN] 토큰 갱신 완료");

        final options = err.requestOptions;
        options.headers['Authorization'] = 'Bearer $newAccessToken';

        final response = await dio.fetch(options);
        handler.resolve(response);
      } else {
        handler.reject(err);
      }
    } catch (e) {
      debugPrint("[TOKEN] 에러 발생: $e");
      handler.reject(err);
    }
  }
}
