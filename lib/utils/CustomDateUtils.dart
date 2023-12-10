import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateUtils {
  static String singleDateTimeFormatter(DateTime dateTime, {usePerfix = true}) {
    final DateFormat dateFormat = DateFormat('M. d. (EEE) ', "ko");
    final DateFormat timeFormat = DateFormat('H:mm', "ko");

    if (isSameDay(dateTime, DateTime.now())) {
      return "${usePerfix ? "오늘 " : ""}${timeFormat.format(dateTime)}";
    } else if (isSameDay(
        dateTime, DateTime.now().add(const Duration(days: 1)))) {
      return "${usePerfix ? "내일 " : ""}${timeFormat.format(dateTime)}";
    } else {
      return "${usePerfix ? dateFormat.format(dateTime) : ""}${timeFormat.format(dateTime)}";
    }
  }

  static String doubleDateTimeFormatter(DateTimeRange dateTimeRange) {
    final DateTime start = dateTimeRange.start;
    final DateTime end = dateTimeRange.end;

    if (isSameDay(start, end)) {
      return "${singleDateTimeFormatter(start)} - ${singleDateTimeFormatter(end, usePerfix: false)}";
    }
    return "${singleDateTimeFormatter(start)} - ${singleDateTimeFormatter(end)}";
  }

  static bool isSameDay(DateTime start, DateTime end) {
    return (start.year == end.year) &&
        (start.month == end.month) &&
        (start.day == end.day);
  }

  static String durationFormatter(Duration duration) {
    int days = duration.inDays;
    int hours = duration.inHours % 24;
    int minutes = duration.inMinutes % 60;

    String result = '';

    if (minutes % 10 == 9) {
      minutes++;

      if (minutes == 60) {
        minutes = 0;
        hours++;

        if (hours >= 24) {
          hours = 0;
          days++;
        }
      }
    }

    if (minutes % 10 == 1) {
      minutes--;
    }

    if (days > 0) {
      result += '$days일 ';
    }
    if (hours > 0) {
      result += '$hours시간 ';
    }
    if (minutes > 0) {
      result += '$minutes분';
    }

    return result.isEmpty ? '0분' : result;
  }

  static String dateTimeRangeFormatter(DateTimeRange dateTimeRange) {
    final Duration duration = dateTimeRange.end.difference(dateTimeRange.start);
    final String formattedDuration = durationFormatter(duration);

    return '총 $formattedDuration 이용';
  }
}
