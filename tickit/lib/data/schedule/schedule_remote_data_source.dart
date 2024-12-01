import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tickit/config/ip.dart';
import 'package:tickit/core/repository/api_response.dart';
import 'package:tickit/data/schedule/body/schedule_request_body.dart';
import 'package:tickit/data/schedule/entity/schedule_entity.dart';
import 'package:tickit/data/schedule/entity/schedule_preview_entity.dart';
import 'package:tickit/data/schedule/entity/schedule_for_ticket_entity.dart';
import 'package:tickit/service/network/dio.dart';

part 'schedule_remote_data_source.g.dart';

final scheduleRemoteDataSourceProvider = Provider(
  (ref) => ScheduleRemoteDataSource(
    ref.read(dioProvider),
    baseUrl: "http://$ip/api/schedules",
  ),
);

@RestApi()
abstract class ScheduleRemoteDataSource {
  factory ScheduleRemoteDataSource(Dio dio, {String baseUrl}) =
      _ScheduleRemoteDataSource;

  @GET("")
  @Headers({"accessToken": "true"})
  Future<ApiResponse<List<SchedulePreviewEntity>>> getScheduleList({
    @Query("startDate") required String startDate,
    @Query("endDate") required String endDate,
  });

  @POST("")
  @Headers({"accessToken": "true"})
  Future<ApiResponse<ScheduleEntity>> createSchedule({
    @Body() required ScheduleRequestBody scheduleDTO,
  });

  @GET("/for-ticket")
  @Headers({"accessToken": "true"})
  Future<ApiResponse<List<ScheduleForTicketEntity>>> getScheduleForTicket({
    @Query("date") String? date,
  });

  @GET("/{id}")
  @Headers({"accessToken": "true"})
  Future<ApiResponse<ScheduleEntity>> getScheduleDetail({
    @Path() required String id,
  });

  @PUT("/{id}")
  @Headers({"accessToken": "true"})
  Future<ApiResponse<ScheduleEntity>> updateSchedule({
    @Path() required String id,
    @Body() required ScheduleRequestBody scheduleDTO,
  });

  @DELETE("/{id}")
  @Headers({"accessToken": "true"})
  Future<ApiResponse<String>> deleteSchedule({
    @Path() required String id,
  });
}
