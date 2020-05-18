import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mindbook/models/entry.dart';
import 'package:mindbook/utils/time_util.dart';

class MonthWidget extends StatelessWidget {
  final BuildContext context;
  final int year;
  final int month;
  final bool showDay;
  final FirebaseUser currentUser;

  const MonthWidget(
      {@required this.context,
      @required this.year,
      @required this.month,
      @required this.showDay,
      @required this.currentUser});

  Future<Color> getDayColor(DateTime _dateTime) async {
    TimeUtil _timeUtil = TimeUtil(_dateTime);
    double dayAverageDouble = await _getDayEmotionAverage(_timeUtil);
    int roundedAverage = dayAverageDouble.round();

    switch (roundedAverage) {
      case 1:
        return Colors.blue[900];
      case 2:
        return Colors.blue[700];
      case 3:
        return Colors.blue[500];
      case 4:
        return Colors.blue[300];
      case 5:
        return Colors.blue[100];
      default:
        return Colors.transparent;
    }
  }

  Future<double> _getDayEmotionAverage(TimeUtil _timeUtil) async {
    Firestore firestore = Firestore.instance;
    QuerySnapshot results = await firestore
        .collection('user')
        .document(currentUser.uid)
        .collection('entry')
        .where('timestamp',
            isGreaterThanOrEqualTo: _timeUtil.getTodayStartDateTime())
        .where('timestamp',
            isLessThanOrEqualTo: _timeUtil.getTodayEndDateTime())
        .getDocuments();

    List<Entry> entries =
        results.documents.map((data) => Entry.fromSnapshot(data)).toList();
    double average = 0;
    print(entries.length);
    if (entries.length > 0) {
      for (Entry item in entries) {
        average = average + item.emotion;
      }
      average = average / entries.length;
    }

    return average;
  }

  Container monthWeekdayHeader(String display) {
    Color accentColor = Theme.of(context).accentColor;
    return Container(
      width: 18,
      height: 18,
      alignment: Alignment.center,
      child: Text(
        display,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: accentColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> monthsList = <String>[
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    List<List<String>> monthRows = List.generate(0, (index) => []);
    List<String> monthRowsDays = <String>[];

    int daysInMonth = month < DateTime.monthsPerYear
        ? DateTime(year, month + 1, 0).day
        : DateTime(year + 1, 1, 0).day;

    int firstDay = DateTime(year, month, 1).weekday;

    for (int day = 2 - firstDay; day <= daysInMonth; day++) {
      monthRowsDays.add(day < 1 ? '' : day.toString());
      if ((day - 1 + firstDay) % DateTime.daysPerWeek == 0 ||
          day == daysInMonth) {
        monthRows.add(List<String>.from(monthRowsDays));
        monthRowsDays.clear();
      }
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            monthsList[month - 1],
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
          Container(
            margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    monthWeekdayHeader('M'),
                    monthWeekdayHeader('T'),
                    monthWeekdayHeader('W'),
                    monthWeekdayHeader('T'),
                    monthWeekdayHeader('F'),
                    monthWeekdayHeader('S'),
                    monthWeekdayHeader('S'),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(monthRows.length, (row) {
                    return Row(
                        children: List.generate(monthRows[row].length, (day) {
                      return FutureBuilder(
                          future: monthRows[row][day] == ''? null : getDayColor(DateTime.utc(year, month, int.parse(monthRows[row][day]))),
                          initialData: Colors.transparent,
                          builder: (BuildContext context, AsyncSnapshot<Color> _color) {
                            return Container(
                              width: 18,
                              height: 18,
                              color: _color.data,
                              alignment: Alignment.center,
                              child: Visibility(
                                visible: showDay,
                                child: Text(
                                  monthRows[row][day],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            );
                          });
                    }));
                  }, growable: true),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
