import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket_entity.g.dart';

@JsonSerializable()
class TicketEntity {
  final String id;
  final String title;
  final String location;
  final String image;
  final String datetime;
  final String backgroundColor;
  final String foregroundColor;
  final List<Fields> fields;

  TicketEntity({
    required this.id,
    required this.title,
    required this.location,
    required this.image,
    required this.datetime,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.fields,
  });

  factory TicketEntity.fromJson(Map<String, dynamic> json)
  => _$TicketEntityFromJson(json);
}

@JsonSerializable()
class Fields {
  final String content;
  final String subtitle;

  Fields({
    required this.content,
    required this.subtitle,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => _$FieldsFromJson(json);

  Map<String, dynamic> toJson() => _$FieldsToJson(this);
}
