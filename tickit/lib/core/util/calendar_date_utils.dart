String getMonthStart({required DateTime date}) {
  return '${date.year}-${date.month.toString().padLeft(2, '0')}-01';
}

String getMonthEnd({required DateTime date}) {
  final lastDay = DateTime(date.year, date.month + 1, 0);
  return '${date.year}-${date.month.toString().padLeft(2, '0')}-${lastDay.day.toString().padLeft(2, '0')}';
}
