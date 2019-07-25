import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './internationalization/Localizations.dart';
import './models/Event.dart';

class Utils {

  static bool isSameDate(DateTime date1, DateTime date2) {
    return date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year;
  }

  static String dateToString(Event event, BuildContext context) {
    TOALocalizations local = TOALocalizations.of(context);
    String format = local.get('date.date_format', defaultValue: 'MMM d, yyyy');
    if (isSameDate(event.getStartDate(), event.getEndDate())) {
      return DateFormat(format, local.locale.toString()).format(event.getStartDate());
    } else {
      return DateFormat(format, local.locale.toString()).format(event.getStartDate()) + local.get('date.date_to_date') + DateFormat(format, local.locale.toString()).format(event.getEndDate());
    }
  }

  static String eventSubtitle(Event event, BuildContext context) {
    TOALocalizations local = TOALocalizations.of(context);
    String location = event.getShortLocation();
    String date = dateToString(event, context);
    if (isSameDate(event.getStartDate(), event.getStartDate())) {
      return location + local.get('date.location_on_date')  + date;
    } else {
      return location + local.get('date.location_from_date') + date;
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