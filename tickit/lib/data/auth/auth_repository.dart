import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickit/core/repository/repository.dart';
import 'package:tickit/core/repository/repository_result.dart';
import 'package:tickit/data/auth/auth_remote_data_source.dart';
import 'package:tickit/data/auth/body/auth_kakao_tokens_request_body.dart';
import 'package:tickit/data/auth/entity/auth_tokens_entity.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    authRemoteDataSource: ref.watch(authRemoteDataSourceProvider),
  ),
);

class AuthRepository extends Repository {
  final AuthRemoteDataSource _authRemoteDataSource;

  const AuthRepository({
    required AuthRemoteDataSource authRemoteDataSource,
  }) : _authRemoteDataSource = authRemoteDataSource;

  Future<RepositoryResult<AuthTokensEntity>> kakaoLogin({
    required String accessToken,
    required String idToken,
    required String refreshToken,
  }) async {
    try {
      AuthKakaoTokensRequestBody body = AuthKakaoTokensRequestBody(
        accessToken: accessToken,
        idToken: idToken,
        refreshToken: refreshToken,
      );
      final resp = await _authRemoteDataSource.kakaoLogin(tokens: body);
      if (resp.data != null) {
        return SuccessRepositoryResult(data: resp.data!);
      } else {
        return FailureRepositoryResult(
          statusCode: resp.code,
          messages: [resp.message],
        );
      }
    } on DioException catch (e) {
      final String errorMessage =
          e.response?.data['message'] as String? ?? "unknownError".tr();

      return FailureRepositoryResult<AuthTokensEntity>(
        error: e,
        messages: [errorMessage],
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<RepositoryResult<AuthTokensEntity>> kakaoRegister({
    required String accessToken,
    required String idToken,
    required String refreshToken,
  }) async {
    try {
      AuthKakaoTokensRequestBody body = AuthKakaoTokensRequestBody(
        accessToken: accessToken,
        idToken: idToken,
        refreshToken: refreshToken,
      );
      final resp = await _authRemoteDataSource.kakaoRegister(tokens: body);
      if (resp.data != null) {
        return SuccessRepositoryResult(data: resp.data!);
      } else {
        return FailureRepositoryResult(
          statusCode: resp.code,
          messages: [resp.message],
        );
      }
    } on DioException catch (e) {
      final String errorMessage =
          e.response?.data['message'] as String? ?? "unknownError".tr();

      return FailureRepositoryResult<AuthTokensEntity>(
        error: e,
        messages: [errorMessage],
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<RepositoryResult<String>> withdraw() async {
    try {
      final resp = await _authRemoteDataSource.withdraw();
      if (resp.data != null) {
        return SuccessRepositoryResult(data: resp.data!);
      } else {
        return FailureRepositoryResult(
          statusCode: resp.code,
          messages: [resp.message],
        );
      }
    } on DioException catch (e) {
      final String errorMessage =
          e.response?.data['message'] as String? ?? "unknownError".tr();

      return FailureRepositoryResult<String>(
        error: e,
        messages: [errorMessage],
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<RepositoryResult<String>> logout() async {
    try {
      final resp = await _authRemoteDataSource.logout();
      if (resp.data != null) {
        return SuccessRepositoryResult(data: resp.data!);
      } else {
        return FailureRepositoryResult(
          statusCode: resp.code,
          messages: [resp.message],
        );
      }
    } on DioException catch (e) {
      final String errorMessage =
          e.response?.data['message'] as String? ?? "unknownError".tr();

      return FailureRepositoryResult<String>(
        error: e,
        messages: [errorMessage],
        statusCode: e.response?.statusCode,
      );
    }
  }
}
