import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'auth_kakao_tokens_request_body.freezed.dart';
part 'auth_kakao_tokens_request_body.g.dart';

@freezed
class AuthKakaoTokensRequestBody with _$AuthKakaoTokensRequestBody {
  const factory AuthKakaoTokensRequestBody({
    String? accessToken,
    String? idToken,
    String? refreshToken,
  }) = _AuthTokensRequestBody;

  factory AuthKakaoTokensRequestBody.fromJson(Map<String, Object?> json) =>
      _$AuthKakaoTokensRequestBodyFromJson(json);
}
