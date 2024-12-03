import 'package:json_annotation/json_annotation.dart';

part 'schedule_entity.g.dart';

@JsonSerializable()
class ScheduleEntity {
  final String company;
  final String date;
  final String id;
  final String image;
  final String link;
  final String location;
  final String memo;
  final int number;
  final String seat;
  final bool thumbmail;
  final String time;
  final String title;

  const ScheduleEntity({
    required this.company,
    required this.date,
    required this.id,
    required this.image,
    required this.link,
    required this.location,
    required this.memo,
    required this.number,
    required this.seat,
    required this.thumbmail,
    required this.time,
    required this.title,
  });

  factory ScheduleEntity.fromJson(Map<String, dynamic> json)
  => _$ScheduleEntityFromJson(json);
}