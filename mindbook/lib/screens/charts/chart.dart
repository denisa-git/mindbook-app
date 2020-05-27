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

  Future<List<charts.Series<Linear, int>>> _getMonthlyAverage(
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

    QuerySnapshot resultsThisYear = await firestore
        .collection('user')
        .document(widget.currentUser.uid)
        .collection('entry')
        .where('timestamp',
            isGreaterThanOrEqualTo: _timeUtil.getStartOfYear())
        .where('timestamp',
            isLessThanOrEqualTo: _timeUtil.getTodayEndDateTime())
        .getDocuments();

    List<Entry> entriesAverage = resultsAverage.documents
        .map((data) => Entry.fromSnapshot(data))
        .toList();

    List<Entry> entriesThisYear = resultsThisYear.documents
        .map((data) => Entry.fromSnapshot(data))
        .toList();

    List<int> janAverageList = entriesAverage
        .where(
            (element) => element.timestamp.toDate().month == DateTime.january)
        .map((e) => e.emotion)
        .toList();

    List<int> febAverageList = entriesAverage
        .where(
            (element) => element.timestamp.toDate().month == DateTime.february)
        .map((e) => e.emotion)
        .toList();

    List<int> marAverageList = entriesAverage
        .where((element) => element.timestamp.toDate().month == DateTime.march)
        .map((e) => e.emotion)
        .toList();

    List<int> aprAverageList = entriesAverage
        .where((element) => element.timestamp.toDate().month == DateTime.april)
        .map((e) => e.emotion)
        .toList();

    List<int> mayAverageList = entriesAverage
        .where((element) => element.timestamp.toDate().month == DateTime.may)
        .map((e) => e.emotion)
        .toList();

    List<int> junAverageList = entriesAverage
        .where((element) => element.timestamp.toDate().month == DateTime.june)
        .map((e) => e.emotion)
        .toList();

    List<int> julAverageList = entriesAverage
        .where((element) => element.timestamp.toDate().month == DateTime.july)
        .map((e) => e.emotion)
        .toList();

    List<int> augAverageList = entriesAverage
        .where((element) => element.timestamp.toDate().month == DateTime.august)
        .map((e) => e.emotion)
        .toList();

    List<int> sepAverageList = entriesAverage
        .where((element) => element.timestamp.toDate().month == DateTime.september)
        .map((e) => e.emotion)
        .toList();

    List<int> octAverageList = entriesAverage
        .where((element) => element.timestamp.toDate().month == DateTime.october)
        .map((e) => e.emotion)
        .toList();

    List<int> novAverageList = entriesAverage
        .where((element) => element.timestamp.toDate().month == DateTime.november)
        .map((e) => e.emotion)
        .toList();

    List<int> decAverageList = entriesAverage
        .where((element) => element.timestamp.toDate().month == DateTime.december)
        .map((e) => e.emotion)
        .toList();


    List<int> janThisYearList = entriesThisYear
        .where(
            (element) => element.timestamp.toDate().month == DateTime.january)
        .map((e) => e.emotion)
        .toList();

    List<int> febThisYearList = entriesThisYear
        .where(
            (element) => element.timestamp.toDate().month == DateTime.february)
        .map((e) => e.emotion)
        .toList();

    List<int> marThisYearList = entriesThisYear
        .where((element) => element.timestamp.toDate().month == DateTime.march)
        .map((e) => e.emotion)
        .toList();

    List<int> aprThisYearList = entriesThisYear
        .where((element) => element.timestamp.toDate().month == DateTime.april)
        .map((e) => e.emotion)
        .toList();

    List<int> mayThisYearList = entriesThisYear
        .where((element) => element.timestamp.toDate().month == DateTime.may)
        .map((e) => e.emotion)
        .toList();

    List<int> junThisYearList = entriesThisYear
        .where((element) => element.timestamp.toDate().month == DateTime.june)
        .map((e) => e.emotion)
        .toList();

    List<int> julThisYearList = entriesThisYear
        .where((element) => element.timestamp.toDate().month == DateTime.july)
        .map((e) => e.emotion)
        .toList();

    List<int> augThisYearList = entriesThisYear
        .where((element) => element.timestamp.toDate().month == DateTime.august)
        .map((e) => e.emotion)
        .toList();

    List<int> sepThisYearList = entriesThisYear
        .where((element) => element.timestamp.toDate().month == DateTime.september)
        .map((e) => e.emotion)
        .toList();

    List<int> octThisYearList = entriesThisYear
        .where((element) => element.timestamp.toDate().month == DateTime.october)
        .map((e) => e.emotion)
        .toList();

    List<int> novThisYearList = entriesThisYear
        .where((element) => element.timestamp.toDate().month == DateTime.november)
        .map((e) => e.emotion)
        .toList();

    List<int> decThisYearList = entriesThisYear
        .where((element) => element.timestamp.toDate().month == DateTime.december)
        .map((e) => e.emotion)
        .toList();

    double janAverage = _getAverage(janAverageList);
    double febAverage = _getAverage(febAverageList);
    double marAverage = _getAverage(marAverageList);
    double aprAverage = _getAverage(aprAverageList);
    double mayAverage = _getAverage(mayAverageList);
    double junAverage = _getAverage(junAverageList);
    double julAverage = _getAverage(julAverageList);
    double augAverage = _getAverage(augAverageList);
    double sepAverage = _getAverage(sepAverageList);
    double octAverage = _getAverage(octAverageList);
    double novAverage = _getAverage(novAverageList);
    double decAverage = _getAverage(decAverageList);

    double janThisYear = _getAverage(janThisYearList);
    double febThisYear = _getAverage(febThisYearList);
    double marThisYear = _getAverage(marThisYearList);
    double aprThisYear = _getAverage(aprThisYearList);
    double mayThisYear = _getAverage(mayThisYearList);
    double junThisYear = _getAverage(junThisYearList);
    double julThisYear = _getAverage(julThisYearList);
    double augThisYear = _getAverage(augThisYearList);
    double sepThisYear = _getAverage(sepThisYearList);
    double octThisYear = _getAverage(octThisYearList);
    double novThisYear = _getAverage(novThisYearList);
    double decThisYear = _getAverage(decThisYearList);

    final averageData = [
      Linear(0, janAverage),
      Linear(1, febAverage),
      Linear(2, marAverage),
      Linear(3, aprAverage),
      Linear(4, mayAverage),
      Linear(5, junAverage),
      Linear(6, julAverage),
      Linear(7, augAverage),
      Linear(8, sepAverage),
      Linear(9, octAverage),
      Linear(10, novAverage),
      Linear(11, decAverage),
    ];

    final thisWeekData = [
      Linear(0, janThisYear),
      Linear(1, febThisYear),
      Linear(2, marThisYear),
      Linear(3, aprThisYear),
      Linear(4, mayThisYear),
      Linear(5, junThisYear),
      Linear(6, julThisYear),
      Linear(7, augThisYear),
      Linear(8, sepThisYear),
      Linear(9, octThisYear),
      Linear(10, novThisYear),
      Linear(11, decThisYear),
    ];

    _seriesDataWeekdays.add(
      charts.Series(
        domainFn: (Linear month, _) => month.domain,
        measureFn: (Linear month, _) => month.primary,
        id: 'averageData',
        data: averageData,
      ),
    );

    _seriesDataWeekdays.add(
      charts.Series(
        domainFn: (Linear month, _) => month.domain,
        measureFn: (Linear month, _) => month.primary,
        id: 'thisYear',
        data: thisWeekData,
      ),
    );

    return _seriesDataWeekdays;
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
      Linear(0, mondayThisWeek),
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

  double _getAverage(List<int> averagelist) {
    double average = 0;
    if (averagelist.length > 0) {
      for (int item in averagelist) {
        average = average + item;
      }
      average = average / averagelist.length;
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
    } else {
      return 1;
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
              Text(
                'Average of past:',
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                width: 8,
              ),
              DropdownButton<String>(
                  value: _averageOf,
                  iconEnabledColor: Colors.black,
                  dropdownColor: Colors.white,
                  items: _dropdownOptions.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value,
                          style: TextStyle(color: Colors.black)),
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
            child: Text('Weekly', style: TextStyle(color: Colors.black)),
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
            child: Text('Monthly', style: TextStyle(color: Colors.black)),
          ),
          FutureBuilder(
            future:
                _getMonthlyAverage(_timeUtil, _getIntFromOption(_averageOf)),
            initialData: _genNullMonthList(),
            builder: (BuildContext context,
                AsyncSnapshot<List<charts.Series<Linear, int>>> snapshot) {
              if (snapshot.data != null) {
                return Flexible(
                    flex: 1, child: _createChart(snapshot.data, 11));
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
