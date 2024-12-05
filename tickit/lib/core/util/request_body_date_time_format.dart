String getTimeFormat({required String time}) {
  if (time.isEmpty) {
    time = "00";
  } else if (time.length == 1) {
    time = "0$time";
  }
  return time;
}

String makeRequestTime({
  required String hour,
  required String minute,
  required bool isAM,
}) {
  hour = getTimeFormat(time: hour);
  minute = getTimeFormat(time: minute);
  if (isAM) {
    return "AM-$hour-$minute";
  } else {
    return "PM-$hour-$minute";
  }
}

String makeRequestDate({required DateTime date}) {
  final year = date.year;
  final month = getTimeFormat(time: date.month.toString());
  final day = getTimeFormat(time: date.day.toString());
  return "$year-$month-$day";
}
