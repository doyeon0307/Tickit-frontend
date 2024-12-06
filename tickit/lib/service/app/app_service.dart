import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tickit/config/ip.dart';
import 'package:tickit/config/key.dart';
import 'package:tickit/core/loading_status.dart';
import 'package:tickit/data/auth/entity/auth_tokens_entity.dart';
import 'package:tickit/service/app/app_state.dart';
import 'package:tickit/service/storage/secure_storage.dart';

final appServiceProvider = StateNotifierProvider<AppService, AppState>(
  (ref) => AppService(
    storage: ref.watch(secureStorageProvider),
    state: const AppState(),
  ),
);

class AppService extends StateNotifier<AppState> {
  final FlutterSecureStorage _storage;

  AppService({
    required FlutterSecureStorage storage,
    required AppState state,
  })  : _storage = storage,
        super(state) {
    initialize();
  }

  Future<void> initialize() async {
    if (state.loading == LoadingStatus.loading) return;

    state = state.copyWith(
      loading: LoadingStatus.loading,
    );

    try {
      final accessToken = await _storage.read(key: ACCESS_TOKEN_KEY);
      final refreshToken = await _storage.read(key: REFRESH_TOKEN_KEY);

      debugPrint("기존 토큰 : accessToken = $accessToken, refreshToken = $refreshToken");

      if (accessToken != null && refreshToken != null) {
        try {
          debugPrint("토큰 갱신 시도");
          final dio = Dio();
          final result = await dio.post(
            "http://$ip/api/auth/refresh",
            data: {"refreshToken": refreshToken},
          );

          final newAccessToken = result.data["data"]["accessToken"];
          final newRefreshToken = result.data["data"]["refreshToken"];

          debugPrint("newAccessToken: $newAccessToken");

          await Future.wait([
            _storage.write(key: ACCESS_TOKEN_KEY, value: newAccessToken),
            _storage.write(key: REFRESH_TOKEN_KEY, value: newRefreshToken),
          ]);

          state = state.copyWith(
            isLoggedIn: true,
            loading: LoadingStatus.success,
          );
          debugPrint("새로운 토큰 저장 완료");
        } catch (e) {
          debugPrint("토큰 갱신 실패: $e");
          state = const AppState();
        }
      } else {
        debugPrint("저장된 토큰이 없습니다");
        state = state.copyWith(
          loading: LoadingStatus.error,
        );
      }
    } catch (e) {
      debugPrint("기존 토큰 읽기 실패: $e");
      state = state.copyWith(
        loading: LoadingStatus.error,
      );
      await logout();
    }
  }

  Future<void> login({
    required AuthTokensEntity tokens,
  }) async {
    debugPrint("앱 로그인 상태 업데이트를 시도합니다");
    state = state.copyWith(
      loading: LoadingStatus.loading,
    );

    try {
      await _storage.write(
        key: ACCESS_TOKEN_KEY,
        value: tokens.accessToken,
      );
      await _storage.write(
        key: REFRESH_TOKEN_KEY,
        value: tokens.refreshToken,
      );

      state = state.copyWith(
        loading: LoadingStatus.success,
        isLoggedIn: true,
      );
      debugPrint(
        "앱 로그인 완료: accessToken=${tokens.accessToken}, refreshToken=${tokens.refreshToken}",
      );
    } catch (e) {
      state = state.copyWith(
        loading: LoadingStatus.error,
      );
    }
  }

  Future<void> logout() async {
    state = state.copyWith(loading: LoadingStatus.loading);

    try {
      await _storage.delete(key: ACCESS_TOKEN_KEY);
      await _storage.delete(key: REFRESH_TOKEN_KEY);

      state = const AppState();
    } catch (e) {
      state = state.copyWith(loading: LoadingStatus.error);
    }
  }

  bool get isLoggedIn => state.isLoggedIn;
}
