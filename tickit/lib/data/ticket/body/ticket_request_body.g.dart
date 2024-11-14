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
      datetime: json['datetime'] as String,
      backgroundColor: json['backgroundColor'] as String?,
      foregroundColor: json['foregroundColor'] as String?,
      fields: (json['fields'] as List<dynamic>?)
          ?.map((e) => Fields.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TicketRequestBodyToJson(TicketRequestBody instance) =>
    <String, dynamic>{
      'image': instance.image,
      'location': instance.location,
      'title': instance.title,
      'datetime': instance.datetime,
      'backgroundColor': instance.backgroundColor,
      'foregroundColor': instance.foregroundColor,
      'fields': instance.fields,
    };

Fields _$FieldsFromJson(Map<String, dynamic> json) => Fields(
      content: json['content'] as String,
      subtitle: json['subtitle'] as String,
    );

Map<String, dynamic> _$FieldsToJson(Fields instance) => <String, dynamic>{
      'content': instance.content,
      'subtitle': instance.subtitle,
    };
