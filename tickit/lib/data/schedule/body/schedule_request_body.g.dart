// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleRequestBody _$ScheduleRequestBodyFromJson(Map<String, dynamic> json) =>
    ScheduleRequestBody(
      company: json['company'] as String,
      date: json['date'] as String,
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

Map<String, dynamic> _$ScheduleRequestBodyToJson(
        ScheduleRequestBody instance) =>
    <String, dynamic>{
      'company': instance.company,
      'date': instance.date,
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
