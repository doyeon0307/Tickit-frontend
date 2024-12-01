import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickit/core/repository/repository.dart';
import 'package:tickit/core/repository/repository_result.dart';
import 'package:tickit/data/schedule/body/schedule_request_body.dart';
import 'package:tickit/data/schedule/entity/schedule_entity.dart';
import 'package:tickit/data/schedule/entity/schedule_for_ticket_entity.dart';
import 'package:tickit/data/schedule/entity/schedule_preview_entity.dart';
import 'package:tickit/data/schedule/schedule_remote_data_source.dart';

final scheduleRepositoryProvider = Provider(
      (ref) => ScheduleRepository(
    dataSource: ref.read(scheduleRemoteDataSourceProvider),
  ),
);

class ScheduleRepository extends Repository {
  final ScheduleRemoteDataSource _dataSource;

  const ScheduleRepository({
    required ScheduleRemoteDataSource dataSource,
  }) : _dataSource = dataSource;

  Future<RepositoryResult<List<SchedulePreviewEntity>>> getScheduleList({
    required String startDate,
    required String endDate,
  }) async {
    try {
      final resp = await _dataSource.getScheduleList(
        startDate: startDate,
        endDate: endDate,
      );
      if (resp.data != null) {
        return SuccessRepositoryResult<List<SchedulePreviewEntity>>(data: resp.data!);
      } else {
        return FailureRepositoryResult<List<SchedulePreviewEntity>>(
          statusCode: resp.code,
          messages: [resp.message],
        );
      }
    } on DioException catch (e) {
      final String errorMessage =
          e.response?.data['message'] as String? ?? "unknownError".tr();
      return FailureRepositoryResult<List<SchedulePreviewEntity>>(
        error: e,
        messages: [errorMessage],
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<RepositoryResult<ScheduleEntity>> createSchedule({
    required ScheduleRequestBody scheduleDTO,
  }) async {
    try {
      final resp = await _dataSource.createSchedule(scheduleDTO: scheduleDTO);
      if (resp.data != null) {
        return SuccessRepositoryResult<ScheduleEntity>(data: resp.data!);
      } else {
        return FailureRepositoryResult<ScheduleEntity>(
          statusCode: resp.code,
          messages: [resp.message],
        );
      }
    } on DioException catch (e) {
      final String errorMessage =
          e.response?.data['message'] as String? ?? "unknownError".tr();
      return FailureRepositoryResult<ScheduleEntity>(
        error: e,
        messages: [errorMessage],
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<RepositoryResult<List<ScheduleForTicketEntity>>> getScheduleForTicket({
    String? date,
  }) async {
    try {
      final resp = await _dataSource.getScheduleForTicket(date: date);
      if (resp.data != null) {
        return SuccessRepositoryResult<List<ScheduleForTicketEntity>>(data: resp.data!);
      } else {
        return FailureRepositoryResult<List<ScheduleForTicketEntity>>(
          statusCode: resp.code,
          messages: [resp.message],
        );
      }
    } on DioException catch (e) {
      final String errorMessage =
          e.response?.data['message'] as String? ?? "unknownError".tr();
      return FailureRepositoryResult<List<ScheduleForTicketEntity>>(
        error: e,
        messages: [errorMessage],
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<RepositoryResult<ScheduleEntity>> getScheduleDetail({
    required String id,
  }) async {
    try {
      final resp = await _dataSource.getScheduleDetail(id: id);
      if (resp.data != null) {
        return SuccessRepositoryResult<ScheduleEntity>(data: resp.data!);
      } else {
        return FailureRepositoryResult<ScheduleEntity>(
          statusCode: resp.code,
          messages: [resp.message],
        );
      }
    } on DioException catch (e) {
      final String errorMessage =
          e.response?.data['message'] as String? ?? "unknownError".tr();
      return FailureRepositoryResult<ScheduleEntity>(
        error: e,
        messages: [errorMessage],
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<RepositoryResult<ScheduleEntity>> updateSchedule({
    required String id,
    required ScheduleRequestBody scheduleDTO,
  }) async {
    try {
      final resp = await _dataSource.updateSchedule(
        id: id,
        scheduleDTO: scheduleDTO,
      );
      if (resp.data != null) {
        return SuccessRepositoryResult<ScheduleEntity>(data: resp.data!);
      } else {
        return FailureRepositoryResult<ScheduleEntity>(
          statusCode: resp.code,
          messages: [resp.message],
        );
      }
    } on DioException catch (e) {
      final String errorMessage =
          e.response?.data['message'] as String? ?? "unknownError".tr();
      return FailureRepositoryResult<ScheduleEntity>(
        error: e,
        messages: [errorMessage],
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<RepositoryResult<String>> deleteSchedule({
    required String id,
  }) async {
    try {
      final resp = await _dataSource.deleteSchedule(id: id);
      if (resp.data != null) {
        return SuccessRepositoryResult<String>(data: resp.data!);
      } else {
        return FailureRepositoryResult<String>(
          statusCode: resp.code,
          messages: [resp.message],
        );
      }
    } on DioException catch (e) {
      final String errorMessage =
          e.response?.data['message'] as String? ?? "unknownError".tr();
      return FailureRepositoryResult<String>(
        error: e,
        messages: [errorMessage],
        statusCode: e.response?.statusCode,
      );
    }
  }
}
