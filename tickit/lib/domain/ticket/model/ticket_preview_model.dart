import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tickit/domain/ticket/model/ticket_model.dart';

part 'ticket_preview_model.freezed.dart';

@freezed
class TicketPreview extends TicketModel with _$TicketPreview {
  const factory TicketPreview({
    required int id,
    required String image,
  }) = _TicketPreview;
}