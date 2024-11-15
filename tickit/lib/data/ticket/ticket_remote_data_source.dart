import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tickit/config/ip.dart';
import 'package:tickit/core/repository/api_response.dart';
import 'package:tickit/data/ticket/body/ticket_request_body.dart';
import 'package:tickit/data/ticket/entity/ticket_entity.dart';
import 'package:tickit/data/ticket/entity/ticket_preview_entity.dart';
import 'package:tickit/service/network/dio.dart';

part 'ticket_remote_data_source.g.dart';

final ticketRemoteDataSourceProvider = Provider((ref) => TicketRemoteDataSource(
      ref.read(dioProvider),
      baseUrl: "http://$ip/api/tickets",
    ));

@RestApi()
abstract class TicketRemoteDataSource {
  factory TicketRemoteDataSource(Dio dio, {String baseUrl}) =
      _TicketRemoteDataSource;

  @GET("")
  @Headers({"accessToken": "true"})
  Future<ApiResponse<List<TicketPreviewEntity>>> getTicketPreviewList();

  @POST("")
  @Headers({"accessToken": "true"})
  Future<ApiResponse<String>> makeTicket({
    @Body() required TicketRequestBody ticketDTO,
  });

  @GET("/{id}")
  @Headers({"accessToken": "true"})
  Future<ApiResponse<TicketEntity>> getTicketDetail({
    @Path() required String id,
  });

  @PUT("/{id}")
  @Headers({"accessToken": "true"})
  Future<ApiResponse<TicketEntity>> updateTicket({
    @Path() required String id,
    @Body() required TicketRequestBody ticketDTO,
  });

  @GET("/{id}")
  @Headers({"accessToken": "true"})
  Future<ApiResponse<String>> deleteTicket({
    @Path() required String id,
  });
}
