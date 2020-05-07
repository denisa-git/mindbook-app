import 'package:flutter/material.dart';
import 'package:mindbook/utils/emotion_util.dart';
import 'package:mindbook/utils/tag_util.dart';
import 'package:mindbook/utils/time_util.dart';
import 'package:mindbook/utils/wheel_util.dart';

class AddEntryPageView extends StatefulWidget {
  AddEntryPageView({Key key}) : super(key: key);
  _AddEntryPageView createState() => _AddEntryPageView();
}

class _AddEntryPageView extends State<AddEntryPageView> {
  PageController _pageController;
  TimeUtil _timeUtil;
  double _emotionValue;
  List<TagUil> _tags;
  List<EmotionUil> _emotions;
  WheelUtil _wheelUtil;

  @override
  void initState() {
    super.initState();
    _timeUtil = TimeUtil(DateTime.now());
    _emotionValue = 3;
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
    _pageController = PageController();
    // print(_wheelUtil.getPrimaryList());
  }

  @override
  void dispose() {
    _pageController.dispose();
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
                        // runSpacing: 1,
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
                      Spacer(),
                      Text(
                        'Select the emotion below that best describes this experience',
                        style: TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      // Wrap(
                      //   spacing: 12,
                      //   // runSpacing: 1,
                      //   children: List<Widget>.generate(
                      //     _wheelUtil.getRingZero().length,
                      //     (index) {
                      //       return FilterChip(
                      //         label: Text(_wheelUtil.getRingZero()[index]),
                      //         selected: _tags[index].getSelected(),
                      //         onSelected: (bool selected) {
                      //           setState(() {
                      //             _tags[index].setSelected(selected);
                      //           });
                      //         },
                      //       );
                      //     },
                      //   ).toList(),
                      // ),
                      Spacer(),
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
        ],
      ),
    );
  }
}
