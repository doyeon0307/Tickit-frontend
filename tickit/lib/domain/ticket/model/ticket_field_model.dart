import 'package:flutter/material.dart';

class TicketFieldModel {
  final String id;
  final String subtitle;
  final String content;

  TicketFieldModel({
    String? id,
    this.subtitle = "",
    this.content = "",
  }) : id = id ?? UniqueKey().toString();

  TicketFieldModel copyWith({
    String? subtitle,
    String? content,
  }) {
    return TicketFieldModel(
      id: id, // ID는 유지
      subtitle: subtitle ?? this.subtitle,
      content: content ?? this.content,
    );
  }
}
