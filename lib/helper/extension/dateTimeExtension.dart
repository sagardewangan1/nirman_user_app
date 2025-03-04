import 'package:intl/intl.dart';

extension DateTimeFormatter on String? {
  String toFormattedDate({String format = 'dd-MM-yyyy'}) {
    if (this == null || this!.isEmpty) return 'Invalid date';
    try {
      DateTime parsedDate = DateTime.parse(this!);
      return DateFormat(format).format(parsedDate);
    } catch (e) {
      return 'Invalid date';
    }
  }

  String toFormattedTime({String format = 'hh:mm a'}) {
    if (this == null || this!.isEmpty) return 'Invalid time';
    try {
      DateTime parsedDate = DateTime.parse(this!);
      return DateFormat(format).format(parsedDate);
    } catch (e) {
      return 'Invalid time';
    }
  }
}
