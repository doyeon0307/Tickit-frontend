// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_for_ticket_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleForTicketEntity _$ScheduleForTicketEntityFromJson(
        Map<String, dynamic> json) =>
    ScheduleForTicketEntity(
      id: json['id'] as String,
      title: json['title'] as String,
      date: json['date'] as String,
    );

Map<String, dynamic> _$ScheduleForTicketEntityToJson(
        ScheduleForTicketEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'date': instance.date,
    };
