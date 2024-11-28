class TicketFieldModel {
  final String content;
  final String subtitle;

  const TicketFieldModel({
    required this.content,
    required this.subtitle,
  });

  TicketFieldModel copyWith({
    String? content,
    String? subtitle,
  }) {
    return TicketFieldModel(
      content: content ?? this.content,
      subtitle: subtitle ?? this.subtitle,
    );
  }
}
