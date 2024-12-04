import 'package:tickit/data/schedule/entity/schedule_entity.dart';

class ScheduleModel {
  final String company;
  final String date;
  final String id;
  final String networkImage;
  final String link;
  final String location;
  final String memo;
  final int number;
  final String seat;
  final String title;
  final bool isAM;
  final String hour;
  final String minute;
  final String casting;

  const ScheduleModel({
    required this.company,
    required this.date,
    required this.id,
    required this.link,
    required this.location,
    required this.memo,
    required this.number,
    required this.seat,
    required this.title,
    required this.hour,
    required this.minute,
    required this.isAM,
    required this.networkImage,
    required this.casting,
  });

  factory ScheduleModel.fromEntity({required ScheduleEntity entity}) {
    final parts = entity.time.split("-");
    final isAM = parts[0] == "AM";
    final hour = parts[1];
    final minute = parts[2];
    return ScheduleModel(
      company: entity.company,
      date: entity.date,
      id: entity.id,
      networkImage: entity.image,
      link: entity.link,
      location: entity.location,
      memo: entity.memo,
      number: entity.number,
      seat: entity.seat,
      title: entity.title,
      isAM: isAM,
      hour: hour,
      minute: minute,
      casting: entity.casting,
    );
  }
}
