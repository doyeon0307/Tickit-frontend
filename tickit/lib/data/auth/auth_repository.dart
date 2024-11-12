import 'package:dio/dio.dart';
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
      return SuccessRepositoryResult(
        data: await _authRemoteDataSource.kakaoLogin(body: body),
      );
    } on DioException catch (e) {
      final String errorMessage =
          e.response?.data['message'] as String? ?? '알 수 없는 오류가 발생했습니다';

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
      return SuccessRepositoryResult(
        data: await _authRemoteDataSource.kakaoRegister(body: body),
      );
    } on DioException catch (e) {
      final String errorMessage =
          e.response?.data['message'] as String? ?? '알 수 없는 오류가 발생했습니다';

      return FailureRepositoryResult<AuthTokensEntity>(
        error: e,
        messages: [errorMessage],
        statusCode: e.response?.statusCode,
      );
    }
  }
}
