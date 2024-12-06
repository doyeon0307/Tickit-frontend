// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketRequestBody _$TicketRequestBodyFromJson(Map<String, dynamic> json) =>
    TicketRequestBody(
      image: json['image'] as String,
      location: json['location'] as String,
      title: json['title'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      backgroundColor: json['backgroundColor'] as String?,
      foregroundColor: json['foregroundColor'] as String?,
      fields: (json['fields'] as List<dynamic>?)
          ?.map((e) => Field.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TicketRequestBodyToJson(TicketRequestBody instance) =>
    <String, dynamic>{
      'image': instance.image,
      'location': instance.location,
      'title': instance.title,
      'date': instance.date,
      'time': instance.time,
      'backgroundColor': instance.backgroundColor,
      'foregroundColor': instance.foregroundColor,
      'fields': instance.fields,
    };

Field _$FieldFromJson(Map<String, dynamic> json) => Field(
      content: json['content'] as String,
      subtitle: json['subtitle'] as String,
    );

Map<String, dynamic> _$FieldToJson(Field instance) => <String, dynamic>{
      'content': instance.content,
      'subtitle': instance.subtitle,
    };
