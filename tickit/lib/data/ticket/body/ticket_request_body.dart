import 'package:json_annotation/json_annotation.dart';

part 'ticket_request_body.g.dart';

@JsonSerializable()
class TicketRequestBody {
  final String image;
  final String location;
  final String title;
  final String date;
  final String time;
  final String? backgroundColor;
  final String? foregroundColor;
  final List<Field>? fields;

  TicketRequestBody({
    required this.image,
    required this.location,
    required this.title,
    required this.date,
    required this.time,
    this.backgroundColor,
    this.foregroundColor,
    this.fields,
  });

  Map<String, dynamic> toJson() => _$TicketRequestBodyToJson(this);
}

@JsonSerializable()
class Field {
  final String content;
  final String subtitle;

  Field({
    required this.content,
    required this.subtitle,
  });

  factory Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);

  Map<String, dynamic> toJson() => _$FieldToJson(this);
}
