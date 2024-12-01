import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickit/core/repository/repository.dart';
import 'package:tickit/core/repository/repository_result.dart';
import 'package:tickit/data/auth/entity/profile_entity.dart';
import 'package:tickit/data/setting/setting_remote_data_source.dart';

final settingRepositoryProvider = Provider(
  (ref) => SettingRepository(
    dataSource: ref.read(settingRemoteDataSourceProvider),
  ),
);

class SettingRepository extends Repository {
  final SettingRemoteDataSource _dataSource;

  const SettingRepository({
    required SettingRemoteDataSource dataSource,
  }) : _dataSource = dataSource;

  Future<RepositoryResult<ProfileEntity>> getProfileInfo() async {
    try {
      final resp = await _dataSource.getUserProfile();
      if (resp.data != null) {
        return SuccessRepositoryResult<ProfileEntity>(data: resp.data!);
      } else {
        return FailureRepositoryResult<ProfileEntity>(
          statusCode: resp.code,
          messages: [resp.message],
        );
      }
    } on DioException catch (e) {
      final String errorMessage =
          e.response?.data['message'] as String? ?? "unknownError".tr();

      return FailureRepositoryResult<ProfileEntity>(
        error: e,
        messages: [errorMessage],
        statusCode: e.response?.statusCode,
      );
    }
  }
}
