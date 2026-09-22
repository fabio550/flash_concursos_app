/// The app's "day cutoff" business rule: a new study day starts at 4am,
/// matching Anki's default. A card due at 03:59 still counts as due
/// "yesterday"; a card due at 04:00 counts as due "today".
class StudyDay {
  StudyDay._();

  static const int cutoffHour = 4;

  /// Start of the study day that [reference] falls into.
  static DateTime start(DateTime reference) {
    final shifted = reference.subtract(const Duration(hours: cutoffHour));
    return DateTime(shifted.year, shifted.month, shifted.day)
        .add(const Duration(hours: cutoffHour));
  }

  /// Whether [due] is due within the study day that [now] falls into (or
  /// earlier — i.e. overdue).
  static bool isDueToday(DateTime due, DateTime now) {
    final todayStart = start(now);
    final tomorrowStart = todayStart.add(const Duration(days: 1));
    return due.isBefore(tomorrowStart);
  }
}
