import 'package:intl/intl.dart';
import 'package:toa_flutter/models/Event.dart';
import 'dart:typed_data';

class Utils {

  static bool isSameDate(DateTime date1, DateTime date2) {
    return date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year;
  }

  static String dateToString(Event event) {
    if (isSameDate(event.getStartDate(), event.getStartDate())) {
      return DateFormat("MMM d, yyyy").format(event.getStartDate());
    } else {
      return DateFormat("MMM d, yyyy").format(event.getStartDate()) + " to " + DateFormat("MMM d, yyyy").format(event.getEndDate());
    }
  }

  static String eventSubtitle(Event event) {
    String location = event.getShortLocation();
    if (isSameDate(event.getStartDate(), event.getStartDate())) {
      return location + ' on ' + DateFormat("MMM d, yyyy").format(event.getStartDate());
    } else {
      return location + ' from ' + DateFormat("MMM d, yyyy").format(event.getStartDate()) + " to " + DateFormat("MMM d, yyyy").format(event.getEndDate());
    }
  }

  final Uint8List kTransparentImage = new Uint8List.fromList(<int>[
    0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00,
    0x00, 0x0D, 0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00,
    0x01, 0x00, 0x00, 0x00, 0x01, 0x08, 0x06, 0x00, 0x00,
    0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00, 0x0A,
    0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01,
    0x00, 0x00, 0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4,
    0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE,
  ]);
}