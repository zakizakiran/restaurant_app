class DateTimeHelper {
  static DateTime format() {
    final now = DateTime.now();
    final todayDate = DateTime(now.year, now.month, now.day, 11, 0, 0);

    // If the current time is after 11 AM today, schedule for tomorrow
    return now.isAfter(todayDate)
        ? todayDate.add(const Duration(days: 1))
        : todayDate;
  }
}
