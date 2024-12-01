import 'package:tickit/data/schedule/entity/schedule_preview_entity.dart';

class SchedulePreviewModel {
  final Map<String, SchedulePreviewData> markedDates;

  const SchedulePreviewModel({
    required this.markedDates,
  });

  factory SchedulePreviewModel.fromEntity({
    required SchedulePreviewEntity entity,
  }) =>
      SchedulePreviewModel(
        markedDates: {
          entity.date: SchedulePreviewData(
            id: entity.id,
            title: entity.title,
            image: entity.image,
            hasImage: entity.image.isNotEmpty,
          )
        },
      );
}

class SchedulePreviewData {
  final String id;
  final String title;
  final String image;
  final bool hasImage;

  const SchedulePreviewData({
    required this.id,
    required this.title,
    required this.image,
    required this.hasImage,
  });
}
