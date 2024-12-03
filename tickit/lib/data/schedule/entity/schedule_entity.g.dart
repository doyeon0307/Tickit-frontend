// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleEntity _$ScheduleEntityFromJson(Map<String, dynamic> json) =>
    ScheduleEntity(
      company: json['company'] as String,
      date: json['date'] as String,
      id: json['id'] as String,
      image: json['image'] as String,
      link: json['link'] as String,
      location: json['location'] as String,
      memo: json['memo'] as String,
      number: (json['number'] as num).toInt(),
      seat: json['seat'] as String,
      thumbmail: json['thumbmail'] as bool,
      time: json['time'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$ScheduleEntityToJson(ScheduleEntity instance) =>
    <String, dynamic>{
      'company': instance.company,
      'date': instance.date,
      'id': instance.id,
      'image': instance.image,
      'link': instance.link,
      'location': instance.location,
      'memo': instance.memo,
      'number': instance.number,
      'seat': instance.seat,
      'thumbmail': instance.thumbmail,
      'time': instance.time,
      'title': instance.title,
    };
