import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mindbook/models/entry.dart';
import 'package:mindbook/services/database_service.dart';
import 'package:mindbook/utils/emotion_util.dart';
import 'package:mindbook/utils/tag_util.dart';
import 'package:mindbook/utils/time_util.dart';
import 'package:mindbook/utils/wheel_util.dart';
import 'package:provider/provider.dart';

class AddEntryScreen extends StatefulWidget {
  AddEntryScreen({Key key}) : super(key: key);
  _AddEntryScreen createState() => _AddEntryScreen();
}

class _AddEntryScreen extends State<AddEntryScreen> {
  PageController _pageController;
  FirebaseUser _currentUser;
  TimeUtil _timeUtil;
  double _emotionValue;
  List<TagUil> _tags;
  List<EmotionUil> _emotions;
  WheelUtil _wheelUtil;
  // Wheel of emotion
  List<TagUil> _primaryWheel;
  List<String> _primaryChoices;
  List<TagUil> _secondaryWheel;
  List<String> _secondaryChoices;
  List<TagUil> _tertiaryWheel;
  List<String> _tertiaryChoices;

  TextEditingController _entryTitle;
  TextEditingController _entryContent;

  @override
  void initState() {
    _timeUtil = TimeUtil(DateTime.now());
    _emotionValue = 2;
    _emotions = [
      EmotionUil('Terrible', '😞'),
      EmotionUil('Bad', '😓'),
      EmotionUil('OK', '🙂'),
      EmotionUil('Good', '😌'),
      EmotionUil('Great', '🤩'),
    ];
    _tags = [
      TagUil('Family', false),
      TagUil('Health', false),
      TagUil('Lifestyle', false),
      TagUil('Food', false),
      TagUil('Education', false),
      TagUil('Work', false),
      TagUil('Relationship', false),
      TagUil('Friends', false),
      TagUil('Hobby', false),
      TagUil('Travel', false),
      TagUil('Volunteering', false),
    ];
    _wheelUtil = WheelUtil();
    _primaryWheel =
        _wheelUtil.getPrimaryList().map((e) => TagUil(e, false)).toList();
    _secondaryWheel = _wheelUtil
        .getSecondaryList(_primaryChoices)
        .map((e) => TagUil(e, false))
        .toList();
    _tertiaryWheel = _wheelUtil
        .getTertiaryList(_secondaryChoices)
        .map((e) => TagUil(e, false))
        .toList();
    _entryTitle = new TextEditingController();
    _entryContent = new TextEditingController();
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  String capitalize(String _string) {
    return "${_string[0].toUpperCase()}${_string.substring(1)}";
  }

  @override
  Widget build(BuildContext context) {
    _currentUser = Provider.of<FirebaseUser>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add entry'),
        centerTitle: false,
      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          // Date: 0
          SafeArea(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      Text(
                        "Please select a date and time for this event entry",
                        style: TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () async {
                              DateTime _dateTime = await showDatePicker(
                                context: context,
                                initialDate: _timeUtil.getDateTime(),
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
                                _timeUtil.setDateTime(_dateTime);
                              });
                            },
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text(this
                                          ._timeUtil
                                          .getDateTimeAsString('yMMMMd')),
                                      if (_timeUtil.isToday()) Text('Today')
                                    ],
                                  ),
                                  SizedBox(width: 8.0),
                                  Icon(Icons.arrow_drop_down)
                                ]),
                          ),
                          FlatButton(
                            onPressed: () async {
                              TimeOfDay _timeOfDay = await showTimePicker(
                                context: context,
                                initialTime: _timeUtil.getTimeOfDay(),
                                builder: (BuildContext context, Widget child) {
                                  return Theme(
                                    data: Theme.of(context),
                                    child: child,
                                  );
                                },
                              );
                              setState(() {
                                _timeUtil.setTimeOfDay(_timeOfDay);
                              });
                            },
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(_timeUtil.getTimeOfDayAsString()),
                                  SizedBox(width: 8.0),
                                  Icon(Icons.arrow_drop_down)
                                ]),
                          ),
                        ],
                      ),
                      Spacer(),
                      Divider(),
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
          // Animation: 1
          SafeArea(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      Text(
                        'Please take a few moments to gather your and emotions thoughts...',
                        style: TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      // TODO: slow breathing animation
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Try to take a deep breathes in sync with the animation above',
                        style: TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                      Spacer(),
                      Divider(),
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
                                  2,
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
          // Scale: 2
          SafeArea(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      Text(
                        'How would you describe this experience?',
                        style: TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        _emotions[_emotionValue.toInt()].getEmoji(),
                        style: TextStyle(fontSize: 64),
                      ),
                      SizedBox(
                        height: 36,
                      ),
                      Slider(
                        min: 0,
                        max: 4,
                        value: _emotionValue,
                        label: _emotions[_emotionValue.toInt()].getEmotion(),
                        divisions: 4,
                        onChanged: (double newValue) {
                          setState(() {
                            _emotionValue = newValue.roundToDouble();
                          });
                        },
                      ),
                      Spacer(),
                      Divider(),
                      Row(
                        children: <Widget>[
                          FlatButton.icon(
                            icon: Icon(Icons.keyboard_arrow_left),
                            label: Text('Back'),
                            onPressed: () {
                              if (_pageController.hasClients) {
                                _pageController.animateToPage(
                                  1,
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
                                  3,
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
          // Tags: 3
          SafeArea(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      Text(
                        'What made you feel this way?',
                        style: TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Wrap(
                        spacing: 12,
                        alignment: WrapAlignment.center,
                        children: List<Widget>.generate(
                          _tags.length,
                          (index) {
                            return FilterChip(
                              label: Text(_tags[index].getTag()),
                              selected: _tags[index].getSelected(),
                              onSelected: (bool selected) {
                                setState(() {
                                  _tags[index].setSelected(selected);
                                });
                              },
                            );
                          },
                        ).toList(),
                      ),
                      Spacer(),
                      Divider(),
                      Row(
                        children: <Widget>[
                          FlatButton.icon(
                            icon: Icon(Icons.keyboard_arrow_left),
                            label: Text('Back'),
                            onPressed: () {
                              if (_pageController.hasClients) {
                                _pageController.animateToPage(
                                  2,
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
                                  4,
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
          // Wheel: 4
          SafeArea(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                'Select the emotions below that best describes this experience',
                                style: TextStyle(fontSize: 24),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: <Widget>[
                                  Text('Primary'),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(child: Divider())
                                ],
                              ),
                              Wrap(
                                spacing: 14,
                                alignment: WrapAlignment.start,
                                children: List<Widget>.generate(
                                  _primaryWheel.length,
                                  (index) {
                                    return FilterChip(
                                      label: Text(capitalize(
                                          _primaryWheel[index].getTag())),
                                      selected:
                                          _primaryWheel[index].getSelected(),
                                      onSelected: (bool selected) {
                                        setState(() {
                                          _primaryWheel[index]
                                              .setSelected(selected);
                                          _primaryChoices = _primaryWheel
                                              .where((element) =>
                                                  element.getSelected() == true)
                                              .map((e) => e.getTag())
                                              .toList();
                                          _secondaryWheel = _wheelUtil
                                              .getSecondaryList(_primaryChoices)
                                              .map((e) => TagUil(e, false))
                                              .toList();
                                          _tertiaryWheel = _wheelUtil
                                              .getSecondaryList(
                                                  _secondaryChoices)
                                              .map((e) => TagUil(e, false))
                                              .toList();
                                        });
                                      },
                                    );
                                  },
                                ).toList(),
                              ),
                              Row(
                                children: <Widget>[
                                  Text('Secondary'),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(child: Divider())
                                ],
                              ),
                              Wrap(
                                spacing: 14,
                                alignment: WrapAlignment.start,
                                children: List<Widget>.generate(
                                  _secondaryWheel.length,
                                  (index) {
                                    return FilterChip(
                                      label: Text(capitalize(
                                          _secondaryWheel[index].getTag())),
                                      selected:
                                          _secondaryWheel[index].getSelected(),
                                      onSelected: (bool selected) {
                                        setState(() {
                                          _secondaryWheel[index]
                                              .setSelected(selected);
                                          _secondaryChoices = _secondaryWheel
                                              .where((element) =>
                                                  element.getSelected() == true)
                                              .map((e) => e.getTag())
                                              .toList();
                                          _tertiaryWheel = _wheelUtil
                                              .getTertiaryList(
                                                  _secondaryChoices)
                                              .map((e) => TagUil(e, false))
                                              .toList();
                                        });
                                      },
                                    );
                                  },
                                ).toList(),
                              ),
                              Row(
                                children: <Widget>[
                                  Text('Tertiary'),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(child: Divider())
                                ],
                              ),
                              Wrap(
                                spacing: 14,
                                alignment: WrapAlignment.start,
                                children: List<Widget>.generate(
                                  _tertiaryWheel.length,
                                  (index) {
                                    return FilterChip(
                                      label: Text(capitalize(
                                          _tertiaryWheel[index].getTag())),
                                      selected:
                                          _tertiaryWheel[index].getSelected(),
                                      onSelected: (bool selected) {
                                        setState(() {
                                          _tertiaryWheel[index]
                                              .setSelected(selected);
                                          _tertiaryChoices = _tertiaryWheel
                                              .where((element) =>
                                                  element.getSelected() == true)
                                              .map((e) => e.getTag())
                                              .toList();
                                        });
                                      },
                                    );
                                  },
                                ).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                      Row(
                        children: <Widget>[
                          FlatButton.icon(
                            icon: Icon(Icons.keyboard_arrow_left),
                            label: Text('Back'),
                            onPressed: () {
                              if (_pageController.hasClients) {
                                _pageController.animateToPage(
                                  3,
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
                                  5,
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
          // Submit: 5
          SafeArea(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                          child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 16,
                            ),
                            TextField(
                              maxLines: null,
                              controller: _entryTitle,
                              decoration: InputDecoration.collapsed(
                                hintText: 'Title',
                              ),
                            ),
                            Divider(),
                            TextField(
                              maxLines: null,
                              controller: _entryContent,
                              decoration: InputDecoration.collapsed(
                                hintText: 'Entry',
                              ),
                            )
                          ],
                        ),
                      )),
                      Divider(),
                      Row(
                        children: <Widget>[
                          FlatButton.icon(
                            icon: Icon(Icons.keyboard_arrow_left),
                            label: Text('Back'),
                            onPressed: () {
                              if (_pageController.hasClients) {
                                _pageController.animateToPage(
                                  4,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                          ),
                          Spacer(),
                          FlatButton(
                            onPressed: () {
                              // Submit
                              // DateTime today = DateTime.utc(2018, 1, 1);
                              // DateTime start = DateTime.utc(2017, 1, 1);
                              // List<DateTime> days = List<DateTime>.generate(
                              //     today.difference(start).inDays,
                              //     (index) => start.add(Duration(days: index)));
                              // for (DateTime day in days) {
                              //   final _random = new Random();
                              //   int next(int min, int max) => min + _random.nextInt(max - min);
                              //   Map<String, dynamic> submitMap = {
                              //     'title': _entryTitle.text,
                              //     'content': _entryContent.text,
                              //     'timestamp': Timestamp.fromDate(day),
                              //     'emotion': next(1, 5),
                              //     'tags': _tags
                              //         .where((element) =>
                              //             element.getSelected() == true)
                              //         .map((e) => e.getTag())
                              //         .toList(),
                              //     'wheelEmotions': _tertiaryChoices == null
                              //         ? []
                              //         : _tertiaryChoices
                              //   };
                              //   Entry submitEntry = Entry.fromMap(submitMap);
                              //   DatabaseService db =
                              //       DatabaseService(_currentUser.uid);
                              //   db.createEntry(submitEntry);
                              // }
                              Map<String, dynamic> submitMap = {
                                'title': _entryTitle.text,
                                'content': _entryContent.text,
                                'timestamp':
                                    Timestamp.fromDate(_timeUtil.getDateTime()),
                                'emotion': _emotionValue.toInt() + 1,
                                'tags': _tags
                                    .where((element) =>
                                        element.getSelected() == true)
                                    .map((e) => e.getTag())
                                    .toList(),
                                'wheelEmotions': _tertiaryChoices == null? []:_tertiaryChoices
                              };
                              Entry submitEntry = Entry.fromMap(submitMap);
                              DatabaseService db =
                                  DatabaseService(_currentUser.uid);
                              db.createEntry(submitEntry);
                              // Display result
                              Navigator.pop(context);
                            },
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text('Submit'),
                                  SizedBox(width: 8.0),
                                  Icon(Icons.save)
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
