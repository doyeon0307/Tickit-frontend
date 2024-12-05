import 'package:tickit/data/ticket/entity/ticket_entity.dart';
import 'package:tickit/domain/ticket/model/ticket_field_model.dart';

class TicketModel {
  final String id;
  final String title;
  final String location;
  final String image;
  final DateTime date;
  final int hour;
  final int minute;
  final bool isAm;
  final String backgroundColor;
  final String foregroundColor;
  final List<TicketFieldModel> fields;
  final String dateTime;

  TicketModel({
    required this.id,
    required this.title,
    required this.location,
    required this.image,
    required this.date,
    required this.hour,
    required this.minute,
    required this.isAm,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.fields,
    required this.dateTime,
  });

  factory TicketModel.fromEntity({
    required TicketEntity entity,
  }) {
    final parts = entity.time.split("-");
    return TicketModel(
        id: entity.id,
        title: entity.title,
        location: entity.location,
        image: entity.image,
        date: DateTime.parse(entity.date),
        isAm: parts[0]=="AM",
        hour: int.parse(parts[1]),
        minute: int.parse(parts[2]),
        dateTime: "${entity.date} ${parts[0]} ${parts[1]}:${parts[2]}",
        backgroundColor: entity.backgroundColor,
        foregroundColor: entity.foregroundColor,
        fields: List.generate(
          entity.fields.length,
          (index) => TicketFieldModel(
            content: entity.fields[index].content,
            subtitle: entity.fields[index].subtitle,
          ),
        ),
      );
  }
}
