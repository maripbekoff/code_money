extension DateTimeExtension on DateTime {
  bool isToday(DateTime other) =>
      day == other.day && year == other.year && month == other.month;
}
