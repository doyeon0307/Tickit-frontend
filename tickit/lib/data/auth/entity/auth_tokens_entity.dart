import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'auth_tokens_entity.freezed.dart';
part 'auth_tokens_entity.g.dart';

@freezed
class AuthTokensEntity with _$AuthTokensEntity {
  const factory AuthTokensEntity({
    required String accessToken,
    required String refreshToken,
  }) = _AuthTokensEntity;

  factory AuthTokensEntity.fromJson(Map<String, Object?> json) =>
      _$AuthTokensEntityFromJson(json);
}
