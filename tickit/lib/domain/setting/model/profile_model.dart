import 'package:tickit/data/auth/entity/profile_entity.dart';

class ProfileModel {
  final String name;

  const ProfileModel({
    required this.name,
  });

  factory ProfileModel.fromEntity({
    required ProfileEntity entity,
  }) =>
      ProfileModel(
        name: entity.nickName ?? "",
      );
}
