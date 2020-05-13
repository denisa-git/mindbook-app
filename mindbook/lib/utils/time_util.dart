import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeUtil {
  DateTime _dateTime;

  TimeUtil(DateTime dateTime) {
    _dateTime = dateTime;
  }

  bool isToday() {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime _dateTimeFormatted =
        DateTime(_dateTime.year, _dateTime.month, _dateTime.day);
    return _dateTimeFormatted == today;
  }

  DateTime getTodayStartDateTime() {
    DateTime _dateTimeFormatted =
        DateTime(_dateTime.year, _dateTime.month, _dateTime.day);
    return _dateTimeFormatted;
  }

  DateTime getTodayEndDateTime() {
    DateTime _dateTimeFormatted =
        DateTime(_dateTime.year, _dateTime.month, _dateTime.day + 1);
    return _dateTimeFormatted;
  }

  void setDateTime(DateTime dateTime) {
    if (dateTime != null) {
      _dateTime = dateTime;
    }
  }

  void setDateTimePrevious() {
    _dateTime = DateTime(_dateTime.year, _dateTime.month, _dateTime.day - 1);
  }

  void setDateTimeNext() {
    _dateTime = DateTime(_dateTime.year, _dateTime.month, _dateTime.day + 1);
  }

  DateTime getDateTime() {
    return _dateTime;
  }

  String getDateTimeAsString(String format) {
    return DateFormat(format).format(_dateTime);
  }

  void setTimeOfDay(TimeOfDay timeOfDay) {
    if (timeOfDay != null) {
      _dateTime = DateTime(_dateTime.year, _dateTime.month, _dateTime.day,
          timeOfDay.hour, timeOfDay.minute);
    }
  }

  TimeOfDay getTimeOfDay() {
    return TimeOfDay.fromDateTime(_dateTime);
  }

  String getTimeOfDayAsString() {
    return DateFormat.jm().format(_dateTime);
  }
}
