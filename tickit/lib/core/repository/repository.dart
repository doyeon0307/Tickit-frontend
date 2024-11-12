import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class Repository {
  const Repository();

  @protected
  List<String>? getErrorMessage(DioException e) {
    if (e.response?.data['message'] is String) {
      return [e.response?.data['message'] as String];
    }
    return (e.response?.data['message'] as List<dynamic>?)
        ?.map((dynamic e) => e.toString())
        .toList();
  }
}