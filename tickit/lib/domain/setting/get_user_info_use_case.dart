import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickit/core/repository/repository_result.dart';
import 'package:tickit/core/use_case/use_case_result.dart';
import 'package:tickit/data/auth/entity/profile_entity.dart';
import 'package:tickit/data/setting/setting_repository.dart';
import 'package:tickit/domain/setting/model/profile_model.dart';

final getUserInfoUseCaseProvider = Provider.autoDispose(
  (ref) => GetUserInfoUseCase(
    settingRepository: ref.read(settingRepositoryProvider),
  ),
);

class GetUserInfoUseCase {
  final SettingRepository _settingRepository;

  const GetUserInfoUseCase({
    required SettingRepository settingRepository,
  }) : _settingRepository = settingRepository;

  Future<UseCaseResult<ProfileModel>> call() async {
    final RepositoryResult<ProfileEntity> repositoryResult =
        await _settingRepository.getProfileInfo();

    return switch (repositoryResult) {
      SuccessRepositoryResult<ProfileEntity>() => SuccessUseCaseResult(
          data: ProfileModel.fromEntity(
            entity: repositoryResult.data,
          ),
        ),
      FailureRepositoryResult<ProfileEntity>() => FailureUseCaseResult(
          message: repositoryResult.messages?.first ?? "",
          statusCode: repositoryResult.statusCode,
        )
    };
  }
}
