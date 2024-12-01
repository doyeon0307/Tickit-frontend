import 'package:tickit/data/ticket/entity/ticket_entity.dart';
import 'package:tickit/domain/ticket/model/ticket_field_model.dart';

class TicketModel {
  final String id;
  final String title;
  final String location;
  final String image;
  final String datetime;
  final String backgroundColor;
  final String foregroundColor;
  final List<TicketFieldModel> fields;

  TicketModel({
    required this.id,
    required this.title,
    required this.location,
    required this.image,
    required this.datetime,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.fields,
  });

  factory TicketModel.fromEntity({
    required TicketEntity entity,
  }) =>
      TicketModel(
        id: entity.id,
        title: entity.title,
        location: entity.location,
        image: entity.image,
        datetime: entity.datetime,
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
