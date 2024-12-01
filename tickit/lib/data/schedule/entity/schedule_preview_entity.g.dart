// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_preview_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SchedulePreviewEntity _$SchedulePreviewEntityFromJson(
        Map<String, dynamic> json) =>
    SchedulePreviewEntity(
      id: json['id'] as String,
      title: json['title'] as String,
      image: json['image'] as String,
      date: json['date'] as String,
    );

Map<String, dynamic> _$SchedulePreviewEntityToJson(
        SchedulePreviewEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'date': instance.date,
    };
