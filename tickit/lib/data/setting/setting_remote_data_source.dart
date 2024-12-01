import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tickit/config/ip.dart';
import 'package:tickit/core/repository/api_response.dart';
import 'package:tickit/data/auth/entity/profile_entity.dart';
import 'package:tickit/service/network/dio.dart';

part 'setting_remote_data_source.g.dart';

final settingRemoteDataSourceProvider = Provider((ref) => SettingRemoteDataSource(
  ref.read(dioProvider),
  baseUrl: "http://$ip/api/auth",
));

@RestApi()
abstract class SettingRemoteDataSource {
  factory SettingRemoteDataSource(Dio dio, {String baseUrl}) =
  _SettingRemoteDataSource;
  
  @GET("")
  @Headers({"accessToken": "true"})
  Future<ApiResponse<ProfileEntity>> getUserProfile();
}