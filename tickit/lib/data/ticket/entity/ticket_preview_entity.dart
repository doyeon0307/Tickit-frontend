import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket_preview_entity.g.dart';

@JsonSerializable()
class TicketPreviewEntity {
  final String id;
  final String image;

  const TicketPreviewEntity({
    required this.id,
    required this.image,
  });

  factory TicketPreviewEntity.fromJson(Map<String, dynamic> json)
  => _$TicketPreviewEntityFromJson(json);
}