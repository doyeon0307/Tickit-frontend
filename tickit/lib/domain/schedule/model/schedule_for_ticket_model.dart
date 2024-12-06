import 'package:tickit/data/schedule/entity/schedule_for_ticket_entity.dart';

class ScheduleForTicketModel {
  final String id;
  final String title;
  final String date;

  const ScheduleForTicketModel({
    required this.id,
    required this.title,
    required this.date,
  });

  factory ScheduleForTicketModel.fromEntity({
    required ScheduleForTicketEntity entity,
  }) =>
      ScheduleForTicketModel(
        id: entity.id,
        title: entity.title,
        date: entity.date,
      );
}
