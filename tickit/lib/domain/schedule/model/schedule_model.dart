import 'package:tickit/data/schedule/entity/schedule_entity.dart';

class ScheduleModel {
  final String company;
  final String date;
  final String id;
  final String image;
  final String link;
  final String location;
  final String memo;
  final int number;
  final String seat;
  final bool thumbnail;
  final String time;
  final String title;

  const ScheduleModel({
    required this.company,
    required this.date,
    required this.id,
    required this.image,
    required this.link,
    required this.location,
    required this.memo,
    required this.number,
    required this.seat,
    required this.thumbnail,
    required this.time,
    required this.title,
  });

  factory ScheduleModel.fromEntity({required ScheduleEntity entity}) =>
      ScheduleModel(
        company: entity.company,
        date: entity.date,
        id: entity.id,
        image: entity.image,
        link: entity.link,
        location: entity.location,
        memo: entity.memo,
        number: entity.number,
        seat: entity.seat,
        thumbnail: entity.thumbmail,
        time: entity.time,
        title: entity.title,
      );
}
