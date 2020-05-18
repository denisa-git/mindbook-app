import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mindbook/screens/calendar/year_widget.dart';

class Calendar extends StatefulWidget {
  final bool showNumbers;
  final FirebaseUser currentUser;
  Calendar({@required this.showNumbers, @required this.currentUser});
  @override
  _Calendar createState() => _Calendar();
}

class _Calendar extends State<Calendar> {
  DateTime now;
  List<int> years;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    years = List.from(
        List<int>.generate(4, (index) => now.year - 3 + index).reversed);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: years.length,
      itemBuilder: (BuildContext context, int index) {
        return YearWidget(
          context: context,
          year: years[index],
          showNumbers: widget.showNumbers,
          currentUser: widget.currentUser
        );
      },
    );
  }
}
