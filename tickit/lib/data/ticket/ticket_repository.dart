import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickit/core/repository/repository.dart';
import 'package:tickit/core/repository/repository_result.dart';
import 'package:tickit/data/ticket/body/ticket_request_body.dart';
import 'package:tickit/data/ticket/entity/ticket_entity.dart';
import 'package:tickit/data/ticket/entity/ticket_preview_entity.dart';
import 'package:tickit/data/ticket/ticket_remote_data_source.dart';

final ticketRepositoryProvider = Provider(
      (ref) => TicketRepository(
    dataSource: ref.watch(ticketRemoteDataSourceProvider),
  ),
);

class TicketRepository extends Repository {
  final TicketRemoteDataSource _dataSource;

  const TicketRepository({
    required TicketRemoteDataSource dataSource,
  }) : _dataSource = dataSource;

  Future<RepositoryResult<List<TicketPreviewEntity>>>
      getTicketPreviewList() async {
    try {
      final resp = await _dataSource.getTicketPreviewList();
      if (resp.data != null) {
        return SuccessRepositoryResult<List<TicketPreviewEntity>>(
            data: resp.data!);
      } else {
        return FailureRepositoryResult<List<TicketPreviewEntity>>(
          statusCode: resp.code,
          messages: [resp.message],
        );
      }
    } on DioException catch (e) {
      final String errorMessage =
          e.response?.data['message'] as String? ?? "unknownError".tr();

      return FailureRepositoryResult<List<TicketPreviewEntity>>(
        error: e,
        messages: [errorMessage],
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<RepositoryResult<String>> makeTicket({
    required String image,
    required String location,
    required String title,
    required String datetime,
    String? backgroundColor,
    String? foregroundColor,
    List<Field>? fields,
  }) async {
    try {
      final ticketDTO = TicketRequestBody(
        image: image,
        location: location,
        title: title,
        datetime: datetime,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        fields: fields,
      );
      final resp = await _dataSource.makeTicket(ticketDTO: ticketDTO);
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

  Future<RepositoryResult<TicketEntity>> getTicketDetail({
    required String id,
  }) async {
    try {
      final resp = await _dataSource.getTicketDetail(id: id);
      if (resp.data != null) {
        return SuccessRepositoryResult<TicketEntity>(data: resp.data!);
      } else {
        return FailureRepositoryResult<TicketEntity>(
          statusCode: resp.code,
          messages: [resp.message],
        );
      }
    } on DioException catch (e) {
      final String errorMessage =
          e.response?.data['message'] as String? ?? "unknownError".tr();

      return FailureRepositoryResult<TicketEntity>(
        error: e,
        messages: [errorMessage],
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<RepositoryResult<TicketEntity>> updateTicket({
    required String id,
    required String image,
    required String location,
    required String title,
    required String datetime,
    String? backgroundColor,
    String? foregroundColor,
    List<Field>? fields,
  }) async {
    try {
      final ticketDTO = TicketRequestBody(
        image: image,
        location: location,
        title: title,
        datetime: datetime,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        fields: fields,
      );
      final resp = await _dataSource.updateTicket(
        id: id,
        ticketDTO: ticketDTO,
      );
      if (resp.data != null) {
        return SuccessRepositoryResult<TicketEntity>(data: resp.data!);
      } else {
        return FailureRepositoryResult<TicketEntity>(
          statusCode: resp.code,
          messages: [resp.message],
        );
      }
    } on DioException catch (e) {
      final String errorMessage =
          e.response?.data['message'] as String? ?? "unknownError".tr();

      return FailureRepositoryResult<TicketEntity>(
        error: e,
        messages: [errorMessage],
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<RepositoryResult<String>> deleteTicket({
    required String id,
  }) async {
    try {
      final resp = await _dataSource.deleteTicket(id: id);
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
