import 'package:json_annotation/json_annotation.dart';

part 'schedule_preview_entity.g.dart';

@JsonSerializable()
class SchedulePreviewEntity {
  final String id;
  final String title;
  final String image;
  final String date;

  const SchedulePreviewEntity({
    required this.id,
    required this.title,
    required this.image,
    required this.date,
  });

  factory SchedulePreviewEntity.fromJson(Map<String, dynamic> json)
  => _$SchedulePreviewEntityFromJson(json);
}