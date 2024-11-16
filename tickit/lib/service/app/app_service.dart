import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tickit/config/key.dart';
import 'package:tickit/core/loading_status.dart';
import 'package:tickit/data/auth/entity/auth_tokens_entity.dart';
import 'package:tickit/service/app/app_state.dart';
import 'package:tickit/service/storage/secure_storage.dart';

final appServiceProvider = StateNotifierProvider(
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
    try {
      final accessToken = await _storage.read(key: ACCESS_TOKEN_KEY);
      final refreshToken = await _storage.read(key: REFRESH_TOKEN_KEY);

      if (accessToken != null && refreshToken != null) {
        state = state.copyWith(isLoggedIn: true);
      }
      debugPrint("accessToken: $accessToken");
    } catch (e) {
      await logout();
    }
  }

  Future<void> login({
    required AuthTokensEntity tokens,
  }) async {
    state = state.copyWith(loading: LoadingStatus.loading);

    try {
      await _storage.write(key: ACCESS_TOKEN_KEY, value: tokens.accessToken);
      await _storage.write(key: REFRESH_TOKEN_KEY, value: tokens.refreshToken);

      state = state.copyWith(
        loading: LoadingStatus.success,
        isLoggedIn: true,
      );
    } catch (e) {
      state = state.copyWith(loading: LoadingStatus.error);
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
