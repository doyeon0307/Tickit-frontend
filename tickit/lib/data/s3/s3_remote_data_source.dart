import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tickit/config/ip.dart';
import 'package:tickit/core/repository/api_response.dart';
import 'package:tickit/data/s3/entity/s3_presigned_url_entity.dart';
import 'package:tickit/service/network/dio.dart';

part 's3_remote_data_source.g.dart';

final s3RemoteDateSourceProvider = Provider((ref) => S3RemoteDataSource(
      ref.read(dioProvider),
      baseUrl: "http://$ip/api/s3",
    ));

@RestApi()
abstract class S3RemoteDataSource {
  factory S3RemoteDataSource(Dio dio, {String baseUrl}) = _S3RemoteDataSource;

  @GET("/presigned-url")
  @Headers({'accessToken': 'true'})
  Future<ApiResponse<S3PresignedUrlEntity>> getS3PresignedUrl();
}
