import 'package:json_annotation/json_annotation.dart';

part 'schedule_for_ticket_entity.g.dart';

@JsonSerializable()
class ScheduleForTicketEntity {
  final String id;
  final String title;
  final String date;

  const ScheduleForTicketEntity({
    required this.id,
    required this.title,
    required this.date,
  });
  
  factory ScheduleForTicketEntity.fromJson(Map<String, dynamic> json)
  => _$ScheduleForTicketEntityFromJson(json);
}