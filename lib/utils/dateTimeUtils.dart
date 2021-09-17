import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeUtils {
  static String formatDateTime(DateTime data) {
    var format = DateFormat.MMMd();
    final time = "${data.hour}: ${data.minute}";
    return "${format.format(data)} at $time";
  }

  static String formatDateOnly(DateTime data) {
    var format = DateFormat.MMMd();
    return "${format.format(data)}";
  }

  static String formatTimeOnly(TimeOfDay data) {
    return "${data.hour} : ${data.minute} ${data.period.index == 0 ? "AM" : "PM"}";
  }
}
