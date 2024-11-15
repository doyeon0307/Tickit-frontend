// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketEntity _$TicketEntityFromJson(Map<String, dynamic> json) => TicketEntity(
      id: json['id'] as String,
      title: json['title'] as String,
      location: json['location'] as String,
      image: json['image'] as String,
      datetime: json['datetime'] as String,
      backgroundColor: json['backgroundColor'] as String?,
      foregroundColor: json['foregroundColor'] as String?,
      fields: (json['fields'] as List<dynamic>?)
          ?.map((e) => Fields.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TicketEntityToJson(TicketEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'location': instance.location,
      'image': instance.image,
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
