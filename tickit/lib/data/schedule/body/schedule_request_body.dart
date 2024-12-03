import 'package:json_annotation/json_annotation.dart';

part 'schedule_request_body.g.dart';

@JsonSerializable()
class ScheduleRequestBody {
  final String company;
  final String date;
  final String image;
  final String link;
  final String location;
  final String memo;
  final int number;
  final String seat;
  final bool thumbmail;
  final String time;
  final String title;

  const ScheduleRequestBody({
    required this.company,
    required this.date,
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

  Map<String, dynamic> toJson() => _$ScheduleRequestBodyToJson(this);
}