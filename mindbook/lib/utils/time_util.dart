import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeUtil {
  DateTime _dateTime;

  TimeUtil(DateTime dateTime) {
    this._dateTime = dateTime;
  }

  bool isToday() {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime _dateTimeFormatted = DateTime(this._dateTime.year,
        this._dateTime.month, this._dateTime.day);
    return _dateTimeFormatted == today;
  }

  void setDateTime(DateTime dateTime) {
    if (dateTime != null) {
      this._dateTime = dateTime;
    }
  }

  DateTime getDateTime() {
    return this._dateTime;
  }

  String getDateTimeAsString(String format) {
    return DateFormat(format).format(this._dateTime);
  }

  void setTimeOfDay(TimeOfDay timeOfDay) {
    if (timeOfDay != null) {
      this._dateTime = DateTime(this._dateTime.year, this._dateTime.month, this._dateTime.day, timeOfDay.hour, timeOfDay.minute);
    }
  }

  TimeOfDay getTimeOfDay() {
    return TimeOfDay.fromDateTime(this._dateTime);
  }

  String getTimeOfDayAsString() {
    return DateFormat.jm().format(this._dateTime);
  }

}
