import 'package:tickit/data/schedule/entity/schedule_preview_entity.dart';

class SchedulePreviewModel {
  final String id;
  final String title;
  final String image;
  final String date;
  final bool hasImage;

  const SchedulePreviewModel({
    required this.id,
    required this.title,
    required this.image,
    required this.date,
    required this.hasImage,
  });

  factory SchedulePreviewModel.fromEntity({
    required SchedulePreviewEntity entity,
  }) =>
      SchedulePreviewModel(
        id: entity.id,
        title: entity.title,
        image: entity.image,
        date: entity.date,
        hasImage: entity.image.isNotEmpty,
      );
}
