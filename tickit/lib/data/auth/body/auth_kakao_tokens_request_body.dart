import 'package:json_annotation/json_annotation.dart';
part 'auth_kakao_tokens_request_body.g.dart';

@JsonSerializable()
class AuthKakaoTokensRequestBody {
  final String accessToken;
  final String idToken;
  final String refreshToken;

  AuthKakaoTokensRequestBody({
    required this.accessToken,
    required this.idToken,
    required this.refreshToken,
  });

  factory AuthKakaoTokensRequestBody.fromJson(Map<String, dynamic> json) =>
      _$AuthKakaoTokensRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AuthKakaoTokensRequestBodyToJson(this);
}
