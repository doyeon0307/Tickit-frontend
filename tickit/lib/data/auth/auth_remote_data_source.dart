import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tickit/config/ip.dart';
import 'package:tickit/core/repository/api_response.dart';
import 'package:tickit/data/auth/entity/auth_tokens_entity.dart';
import 'package:tickit/data/auth/body/auth_kakao_tokens_request_body.dart';
import 'package:tickit/data/auth/entity/profile_entity.dart';
import 'package:tickit/service/network/dio.dart';

part 'auth_remote_data_source.g.dart';

final authRemoteDataSourceProvider = Provider((ref) => AuthRemoteDataSource(
  ref.read(dioProvider),
  baseUrl: "http://$ip/api/auth",
));

@RestApi()
abstract class AuthRemoteDataSource {
  factory AuthRemoteDataSource(Dio dio, {String baseUrl}) =
  _AuthRemoteDataSource;

  @GET("")
  @Headers({"accessToken": "true"})
  Future<ApiResponse<ProfileEntity>> getProfile();

  @DELETE("")
  @Headers({'accessToken': 'true'})
  Future<ApiResponse<String>> withdraw();

  @POST("/kakao/login")
  Future<ApiResponse<AuthTokensEntity>> kakaoLogin({
    @Body() required AuthKakaoTokensRequestBody tokens,
  });

  @DELETE("/logout")
  @Headers({'accessToken': 'true'})
  Future<ApiResponse<String>> logout();

  @POST("/kakao/register")
  Future<ApiResponse<AuthTokensEntity>> kakaoRegister({
    @Body() required AuthKakaoTokensRequestBody tokens,
  });
}
