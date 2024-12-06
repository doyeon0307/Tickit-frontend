String getMonthStart({required DateTime date}) {
  return '${date.year}-${date.month.toString().padLeft(2, '0')}-01';
}

String getMonthEnd({required DateTime date}) {
  final lastDay = DateTime(date.year, date.month + 1, 0);
  return '${date.year}-${date.month.toString().padLeft(2, '0')}-${lastDay.day.toString().padLeft(2, '0')}';
}

int getWeeksInMonth({required DateTime date}) {
  final firstDay = DateTime(date.year, date.month, 1);
  final lastDay = DateTime(date.year, date.month + 1, 0);

  final firstDayOffset = firstDay.weekday - 1;
  final totalDays = firstDayOffset + lastDay.day;

  return (totalDays / 7).ceil();
}

int getDaysInMonth({required DateTime date}) {
  final weeksInMonth = getWeeksInMonth(date: date);
  return weeksInMonth * 7;
}

DateTime getDateFromIndex({
  required int index,
  required DateTime date,
}) {
  final firstDay = DateTime(date.year, date.month, 1);
  final diff = index - (firstDay.weekday - 1);
  return DateTime(date.year, date.month, diff);
}
