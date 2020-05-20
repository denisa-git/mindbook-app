import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mindbook/models/charts/linear.dart';
import 'package:mindbook/models/entry.dart';
import 'package:mindbook/utils/time_util.dart';

class Chart extends StatefulWidget {
  final FirebaseUser currentUser;
  Chart({@required this.currentUser});
  @override
  _Chart createState() => _Chart();
}

class _Chart extends State<Chart> {
  String _averageOf;
  TimeUtil _timeUtil;

  @override
  void initState() {
    super.initState();
    _timeUtil = TimeUtil(DateTime.now());
    _averageOf = '1 year';
  }

  charts.LineChart _createChart(
      List<charts.Series<Linear, int>> _seriesData, int rangeDomainAxisMax) {
    return charts.LineChart(
      _seriesData,
      domainAxis: new charts.NumericAxisSpec(
        viewport: new charts.NumericExtents(0, rangeDomainAxisMax),
        renderSpec: new charts.GridlineRendererSpec(),
        tickProviderSpec: new charts.BasicNumericTickProviderSpec(
            desiredTickCount: rangeDomainAxisMax + 1),
        tickFormatterSpec: new charts.BasicNumericTickFormatterSpec(
            (measure) => toPri(measure.toInt().round(), rangeDomainAxisMax)),
      ),
      primaryMeasureAxis: new charts.NumericAxisSpec(
          viewport: new charts.NumericExtents(0, 4),
          tickProviderSpec:
              new charts.BasicNumericTickProviderSpec(desiredTickCount: 5),
          tickFormatterSpec: new charts.BasicNumericTickFormatterSpec(
              (measure) => toEmotion(measure.toInt().round())),
          renderSpec: new charts.GridlineRendererSpec(
            labelAnchor: charts.TickLabelAnchor.after,
            labelStyle: new charts.TextStyleSpec(fontSize: 22),
          )),
    );
  }

  String toEmotion(int emotionNum) {
    final emotions = ['😞', '😓', '🙂', '😌', '🤩'];
    return emotions[emotionNum];
  }

  String toPri(int priNum, int rangeDomainAxisMax) {
    if (rangeDomainAxisMax == 6) {
      final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return days[priNum];
    } else {
      final month = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      return month[priNum];
    }
  }

  Future<List<charts.Series<Linear, int>>> _getWeeklyAverage(
      TimeUtil _timeUtil, int offset) async {
    List<charts.Series<Linear, int>> _seriesDataWeekdays =
        List<charts.Series<Linear, int>>();
    Firestore firestore = Firestore.instance;

    QuerySnapshot resultsAverage = await firestore
        .collection('user')
        .document(widget.currentUser.uid)
        .collection('entry')
        .where('timestamp',
            isGreaterThanOrEqualTo: _timeUtil.getDateTimeFrom(offset))
        .where('timestamp',
            isLessThanOrEqualTo: _timeUtil.getTodayEndDateTime())
        .getDocuments();

    QuerySnapshot resultsThisWeek = await firestore
        .collection('user')
        .document(widget.currentUser.uid)
        .collection('entry')
        .where('timestamp',
            isGreaterThanOrEqualTo: _timeUtil.getTodayStartDateTime().subtract(
                new Duration(
                    days: _timeUtil.getTodayEndDateTime().weekday - 1)))
        .where('timestamp',
            isLessThanOrEqualTo: _timeUtil.getTodayEndDateTime())
        .getDocuments();

    List<Entry> entriesAverage = resultsAverage.documents
        .map((data) => Entry.fromSnapshot(data))
        .toList();

    List<Entry> entriesThisWeek = resultsThisWeek.documents
        .map((data) => Entry.fromSnapshot(data))
        .toList();

    List<int> mondayAverageList = entriesAverage
        .where(
            (element) => element.timestamp.toDate().weekday == DateTime.monday)
        .map((e) => e.emotion)
        .toList();
    List<int> tuesdayAverageList = entriesAverage
        .where(
            (element) => element.timestamp.toDate().weekday == DateTime.tuesday)
        .map((e) => e.emotion)
        .toList();
    List<int> wednesdayAverageList = entriesAverage
        .where((element) =>
            element.timestamp.toDate().weekday == DateTime.wednesday)
        .map((e) => e.emotion)
        .toList();
    List<int> thursdayAverageList = entriesAverage
        .where((element) =>
            element.timestamp.toDate().weekday == DateTime.thursday)
        .map((e) => e.emotion)
        .toList();
    List<int> fridayAverageList = entriesAverage
        .where(
            (element) => element.timestamp.toDate().weekday == DateTime.friday)
        .map((e) => e.emotion)
        .toList();
    List<int> saturdayAverageList = entriesAverage
        .where((element) =>
            element.timestamp.toDate().weekday == DateTime.saturday)
        .map((e) => e.emotion)
        .toList();
    List<int> sundayAverageList = entriesAverage
        .where(
            (element) => element.timestamp.toDate().weekday == DateTime.sunday)
        .map((e) => e.emotion)
        .toList();

    List<int> mondayThisWeekList = entriesThisWeek
        .where(
            (element) => element.timestamp.toDate().weekday == DateTime.monday)
        .map((e) => e.emotion)
        .toList();
    List<int> tuesdayThisWeekList = entriesThisWeek
        .where(
            (element) => element.timestamp.toDate().weekday == DateTime.tuesday)
        .map((e) => e.emotion)
        .toList();
    List<int> wednesdayThisWeekList = entriesThisWeek
        .where((element) =>
            element.timestamp.toDate().weekday == DateTime.wednesday)
        .map((e) => e.emotion)
        .toList();
    List<int> thursdayThisWeekList = entriesThisWeek
        .where((element) =>
            element.timestamp.toDate().weekday == DateTime.thursday)
        .map((e) => e.emotion)
        .toList();
    List<int> fridayThisWeekList = entriesThisWeek
        .where(
            (element) => element.timestamp.toDate().weekday == DateTime.friday)
        .map((e) => e.emotion)
        .toList();
    List<int> saturdayThisWeekList = entriesThisWeek
        .where((element) =>
            element.timestamp.toDate().weekday == DateTime.saturday)
        .map((e) => e.emotion)
        .toList();
    List<int> sundayThisWeekList = entriesThisWeek
        .where(
            (element) => element.timestamp.toDate().weekday == DateTime.sunday)
        .map((e) => e.emotion)
        .toList();

    double mondayAverage = _getAverage(mondayAverageList);
    double tuesdayAverage = _getAverage(tuesdayAverageList);
    double wednesdayAverage = _getAverage(wednesdayAverageList);
    double thursdayAverage = _getAverage(thursdayAverageList);
    double fridayAverage = _getAverage(fridayAverageList);
    double saturdayAverage = _getAverage(saturdayAverageList);
    double sundayAverage = _getAverage(sundayAverageList);

    double mondayThisWeek = _getAverage(mondayThisWeekList);
    double tuesdayThisWeek = _getAverage(tuesdayThisWeekList);
    double wednesdayThisWeek = _getAverage(wednesdayThisWeekList);
    double thursdayThisWeek = _getAverage(thursdayThisWeekList);
    double fridayThisWeek = _getAverage(fridayThisWeekList);
    double saturdayThisWeek = _getAverage(saturdayThisWeekList);
    double sundayThisWeek = _getAverage(sundayThisWeekList);

    final averageData = [
      Linear(0, mondayAverage),
      Linear(1, tuesdayAverage),
      Linear(2, wednesdayAverage),
      Linear(3, thursdayAverage),
      Linear(4, fridayAverage),
      Linear(5, saturdayAverage),
      Linear(6, sundayAverage),
    ];

    final thisWeekData = [
      Linear(0, mondayThisWeek - 1),
      Linear(1, tuesdayThisWeek),
      Linear(2, wednesdayThisWeek),
      Linear(3, thursdayThisWeek),
      Linear(4, fridayThisWeek),
      Linear(5, saturdayThisWeek),
      Linear(6, sundayThisWeek),
    ];

    _seriesDataWeekdays.add(
      charts.Series(
        domainFn: (Linear weekday, _) => weekday.domain,
        measureFn: (Linear weekday, _) => weekday.primary,
        id: 'averageData',
        data: averageData,
      ),
    );

    _seriesDataWeekdays.add(
      charts.Series(
        domainFn: (Linear weekday, _) => weekday.domain,
        measureFn: (Linear weekday, _) => weekday.primary,
        id: 'thisWeek',
        data: thisWeekData,
      ),
    );

    return _seriesDataWeekdays;
  }

  double _getAverage(List<int> weekday) {
    double average = 0;
    if (weekday.length > 0) {
      for (int item in weekday) {
        average = average + item;
      }
      average = average / weekday.length;
    } else {
      average = null;
    }
    return average;
  }

  List<charts.Series<Linear, int>> _genNullWeeklyList() {
    List<charts.Series<Linear, int>> _seriesData =
        List<charts.Series<Linear, int>>();
    List<Linear> nullWeek = [
      Linear(0, null),
      Linear(1, null),
      Linear(2, null),
      Linear(3, null),
      Linear(4, null),
      Linear(5, null),
      Linear(6, null),
    ];

    _seriesData.add(
      charts.Series(
        domainFn: (Linear _null, _) => _null.domain,
        measureFn: (Linear _null, _) => _null.primary,
        id: 'Week',
        data: nullWeek,
      ),
    );

    return _seriesData;
  }

  int _getIntFromOption(String option) {
    if (option == '1 year') {
      return 1;
    } else if (option == '2 years') {
      return 2;
    } else if (option == '3 years') {
      return 3;
    }
  }

  List<charts.Series<Linear, int>> _genNullMonthList() {
    List<charts.Series<Linear, int>> _seriesData =
        List<charts.Series<Linear, int>>();
    List<Linear> nullMonth = [
      Linear(0, null),
      Linear(1, null),
      Linear(2, null),
      Linear(3, null),
      Linear(4, null),
      Linear(5, null),
      Linear(6, null),
      Linear(7, null),
      Linear(8, null),
      Linear(9, null),
      Linear(10, null),
      Linear(11, null),
    ];

    _seriesData.add(
      charts.Series(
        domainFn: (Linear _null, _) => _null.domain,
        measureFn: (Linear _null, _) => _null.primary,
        id: 'Week',
        data: nullMonth,
      ),
    );

    return _seriesData;
  }

  @override
  Widget build(BuildContext context) {
    List<String> _dropdownOptions = ['1 year', '2 years', '3 years'];
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      height: 400,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Average of past:'),
              SizedBox(
                width: 8,
              ),
              DropdownButton<String>(
                  value: _averageOf,
                  items: _dropdownOptions.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (String value) {
                    setState(() {
                      _averageOf = value;
                    });
                  }),
            ],
          ),
          Divider(),
          Center(
            child: Text('Weekly'),
          ),
          FutureBuilder(
            future: _getWeeklyAverage(_timeUtil, _getIntFromOption(_averageOf)),
            initialData: _genNullWeeklyList(),
            builder: (BuildContext context,
                AsyncSnapshot<List<charts.Series<Linear, int>>> snapshot) {
              if (snapshot.data != null) {
                return Flexible(flex: 1, child: _createChart(snapshot.data, 6));
              } else {
                return Center(child: new CircularProgressIndicator());
              }
            },
          ),
          Divider(),
          Center(
            child: Text('Monthly'),
          ),
          FutureBuilder(
            future: _getWeeklyAverage(_timeUtil, _getIntFromOption(_averageOf)),
            initialData: _genNullWeeklyList(),
            builder: (BuildContext context,
                AsyncSnapshot<List<charts.Series<Linear, int>>> snapshot) {
              if (snapshot.data != null) {
                return Flexible(flex: 1, child: _createChart(snapshot.data, 6));
              } else {
                return Center(child: new CircularProgressIndicator());
              }
            },
          )
          // Flexible(flex: 1, child: _createChart(_seriesDataWeekdays, 6)),
          // Flexible(flex: 1, child: _createChart(_seriesDataMonths, 11)),
        ],
      ),
    );
  }
}
