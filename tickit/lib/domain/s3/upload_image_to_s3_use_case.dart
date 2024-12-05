import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tickit/core/use_case/use_case_result.dart';

final uploadImageToS3UseCaseProvider = Provider.autoDispose(
  (ref) => UploadImageToS3UseCase(),
);

class UploadImageToS3UseCase {
  UploadImageToS3UseCase();

  final Dio myDio = Dio();

  String _getContentType(String path) {
    final ext = path.split('.').last.toLowerCase();

    switch (ext) {
      case 'png':
        return 'image/png';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      case 'heic':
        return 'image/heic';
      default:
        return 'application/octet-stream';
    }
  }

  Future<UseCaseResult<void>> call({
    required String uploadUrl,
    required XFile image,
  }) async {
    try {
      final bytes = await image.readAsBytes();
      final contentType = _getContentType(image.path);

      final resp = await myDio.put(
        uploadUrl,
        data: bytes,
        options: Options(
          headers: {
            'Content-Type': contentType,
            'Content-Length': bytes.length.toString(),
          },
        ),
      );

      if (resp.statusCode == 200) {
        return const SuccessUseCaseResult<void>(data: null);
      } else {
        return const FailureUseCaseResult<void>(
          message: "이미지 업로드에 실패했습니다",
          statusCode: 403,
        );
      }
    } catch (e) {
      return const FailureUseCaseResult<void>(
        message: "이미지 업로드에 실패했습니다",
        statusCode: 500,
      );
    }
  }
}
