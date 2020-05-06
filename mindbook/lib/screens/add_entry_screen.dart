import 'package:flutter/material.dart';
import 'package:mindbook/utils/time_util.dart';

class AddEntryPageView extends StatefulWidget {
  AddEntryPageView({Key key}) : super(key: key);
  _AddEntryPageView createState() => _AddEntryPageView();
}

class _AddEntryPageView extends State<AddEntryPageView> {
  PageController _pageController;
  TimeUtil _timeUtil;

  @override
  void initState() {
    super.initState();
    this._timeUtil = TimeUtil(DateTime.now());
    this._pageController = PageController();
  }

  @override
  void dispose() {
    this._pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add entry'),
        centerTitle: false,
      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          SafeArea(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () async {
                              DateTime _dateTime = await showDatePicker(
                                context: context,
                                initialDate: this._timeUtil.getDateTime(),
                                firstDate: DateTime(1990),
                                lastDate: DateTime(2100),
                                builder: (BuildContext context, Widget child) {
                                  return Theme(
                                    data: Theme.of(context),
                                    child: child,
                                  );
                                },
                              );
                              setState(() {
                                this._timeUtil.setDateTime(_dateTime);
                              });
                            },
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(this
                                      ._timeUtil
                                      .getDateTimeAsString('yMMMMd')),
                                  SizedBox(width: 8.0),
                                  Icon(Icons.arrow_drop_down)
                                ]),
                          ),
                          FlatButton(
                            onPressed: () async {
                              TimeOfDay _timeOfDay = await showTimePicker(
                                context: context,
                                initialTime: this._timeUtil.getTimeOfDay(),
                                builder: (BuildContext context, Widget child) {
                                  return Theme(
                                    data: Theme.of(context),
                                    child: child,
                                  );
                                },
                              );
                              setState(() {
                                this._timeUtil.setTimeOfDay(_timeOfDay);
                              });
                            },
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(this._timeUtil.getTimeOfDayAsString()),
                                  SizedBox(width: 8.0),
                                  Icon(Icons.arrow_drop_down)
                                ]),
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        children: <Widget>[
                          Spacer(),
                          FlatButton(
                            onPressed: () {
                              if (_pageController.hasClients) {
                                _pageController.animateToPage(
                                  1,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text('Next'),
                                  SizedBox(width: 8.0),
                                  Icon(Icons.keyboard_arrow_right)
                                ]),
                          ),
                        ],
                      )
                    ],
                  ))),
          SafeArea(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      Row(
                        children: <Widget>[
                          FlatButton.icon(
                            icon: Icon(Icons.keyboard_arrow_left),
                            label: Text('Back'),
                            onPressed: () {
                              if (_pageController.hasClients) {
                                _pageController.animateToPage(
                                  0,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                          ),
                          Spacer(),
                          FlatButton(
                            onPressed: () {
                              if (_pageController.hasClients) {
                                _pageController.animateToPage(
                                  1,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text('Next'),
                                  SizedBox(width: 8.0),
                                  Icon(Icons.keyboard_arrow_right)
                                ]),
                          ),
                        ],
                      )
                    ],
                  ))),
        ],
      ),
    );
  }
}
