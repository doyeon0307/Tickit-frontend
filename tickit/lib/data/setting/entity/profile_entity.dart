import 'package:json_annotation/json_annotation.dart';

part 'profile_entity.g.dart';

@JsonSerializable()
class ProfileEntity {
  final String nickName;

  const ProfileEntity({
    required this.nickName,
  });
  
  factory ProfileEntity.fromJson(Map<String, dynamic> json)
  => _$ProfileEntityFromJson(json);
}