import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mindbook/screens/calendar/month_widget.dart';

class YearWidget extends StatefulWidget {
  final BuildContext context;
  final int year;
  final bool showNumbers;
  final FirebaseUser currentUser;

  YearWidget(
      {@required this.context,
      @required this.year,
      @required this.showNumbers,
      @required this.currentUser});
  @override
  _YearWidget createState() {
    return new _YearWidget();
  }
}

class _YearWidget extends State<YearWidget> {
  Widget buildMonths(BuildContext context) {
    List<Row> monthRows = <Row>[];
    List<MonthWidget> monthRowChildren = <MonthWidget>[];

    for (int month = 1; month <= DateTime.monthsPerYear; month++) {
      monthRowChildren.add(
        MonthWidget(
            context: context,
            year: widget.year,
            month: month,
            showDay: widget.showNumbers, 
            currentUser: widget.currentUser,),
      );

      if (month % 3 == 0) {
        monthRows.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List<MonthWidget>.from(monthRowChildren),
          ),
        );
        monthRowChildren.clear();
      }
    }

    return Column(
      children: List<Row>.from(monthRows),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(widget.year.toString(),
              style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
              )),
          Divider(),
          buildMonths(context)
        ],
      ),
    );
  }
}
