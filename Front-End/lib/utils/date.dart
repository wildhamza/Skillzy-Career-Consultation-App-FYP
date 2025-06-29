import 'package:intl/intl.dart';

String formatDateWithOrdinal(String isoDate) {
  final DateTime date = DateTime.parse(isoDate);
  final String dayWithOrdinal = _getDayWithOrdinal(date.day);
  final String monthYear = DateFormat("MMMM, y").format(date);
  return "$dayWithOrdinal $monthYear";
}

String _getDayWithOrdinal(int day) {
  if (day >= 11 && day <= 13) {
    return '${day}th';
  }
  switch (day % 10) {
    case 1:
      return '${day}st';
    case 2:
      return '${day}nd';
    case 3:
      return '${day}rd';
    default:
      return '${day}th';
  }
}