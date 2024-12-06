import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_tokens_entity.g.dart';

@JsonSerializable()
class AuthTokensEntity {
  final String accessToken;
  final String refreshToken;

  const AuthTokensEntity({
    required this.accessToken,
    required this.refreshToken,
  });
  
  factory AuthTokensEntity.fromJson(Map<String, dynamic> json)
  => _$AuthTokensEntityFromJson(json);
}
