import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'profile_entity.freezed.dart';
part 'profile_entity.g.dart';

@freezed
class ProfileEntity with _$ProfileEntity {
  const factory ProfileEntity({
    String? nickName,
  }) = _ProfileEntity;

  factory ProfileEntity.fromJson(Map<String, Object?> json) =>
      _$ProfileEntityFromJson(json);
}
