import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mindbook/models/entry.dart';
import 'package:mindbook/screens/add_entry_screen.dart';
import 'package:mindbook/screens/view_entry_screen.dart';
import 'package:mindbook/services/auth_service.dart';
import 'package:mindbook/utils/time_util.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  AuthService _authService;
  FirebaseUser _currentUser;
  bool _desc;
  TimeUtil _timeUtil;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _desc = true;
    _authService = AuthService();
    _timeUtil = TimeUtil(DateTime.now());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _currentUser = Provider.of<FirebaseUser>(context);
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          actions: _pageController.hasClients
              ? getActions(_pageController.page.round())
              : <Widget>[],
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _pageController.hasClients
                ? getTitle(_pageController.page.round())
                : <Widget>[],
          ),
          centerTitle: false,
        ),
        // body: showEntries(context, _desc, _timeUtil),
        body: PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              showEntries(context, _desc, _timeUtil),
              Text('Progress'),
              Text('Help')
            ]),
      ),
      bottomNavigationBar: BottomAppBar(
          child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              showModalBottomSheet(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(8.0),
                  ),
                  context: context,
                  builder: (context) {
                    return SafeArea(
                      child: new Wrap(
                        children: <Widget>[
                          if (_currentUser.displayName != null)
                            ListTile(
                              leading: Container(
                                child: Icon(Icons.person),
                                height: double.infinity,
                              ),
                              title: Text(_currentUser.displayName),
                              subtitle: Text(_currentUser.email),
                              onTap: null,
                            ),
                          if (_currentUser.displayName == null)
                            ListTile(
                              leading: Container(
                                child: Icon(Icons.person),
                                height: double.infinity,
                              ),
                              title: Text('Anonymous'),
                              onTap: null,
                            ),
                          Divider(),
                          ListTile(
                            leading: Container(
                              child: Icon(Icons.view_list),
                              height: double.infinity,
                            ),
                            title: Text('My Entries'),
                            onTap: () {
                              setState(() {
                                _pageController.jumpToPage(0);
                              });
                              Navigator.pop(context);
                            },
                            selected: _pageController.page.round() == 0,
                          ),
                          ListTile(
                            leading: Container(
                              child: Icon(Icons.equalizer),
                              height: double.infinity,
                            ),
                            title: Text('Progress'),
                            onTap: () {
                              setState(() {
                                _pageController.jumpToPage(1);
                              });
                              Navigator.pop(context);
                            },
                            selected: _pageController.page.round() == 1,
                          ),
                          Divider(),
                          ListTile(
                            leading: Container(
                              child: Icon(Icons.info),
                              height: double.infinity,
                            ),
                            title: Text('Help and feedback'),
                            onTap: () {
                              setState(() {
                                _pageController.jumpToPage(2);
                              });
                              Navigator.pop(context);
                            },
                            selected: _pageController.page.round() == 2,
                          ),
                        ],
                      ),
                    );
                  });
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              showModalBottomSheet(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(8.0),
                  ),
                  context: context,
                  builder: (context) {
                    return SafeArea(
                      child: new Wrap(
                        children: <Widget>[
                          ListTile(
                            leading: Container(
                              child: Icon(Icons.update),
                              height: double.infinity,
                            ),
                            title: Text('Time format'),
                            subtitle: Text('12-hour clock'),
                            // TODO: show dialog to change time format
                            onTap: () {},
                          ),
                          ListTile(
                            leading: Container(
                              child: Icon(Icons.invert_colors),
                              height: double.infinity,
                            ),
                            title: Text('Theme'),
                            subtitle: Text('Light'),
                            // TODO: show dialog to change theme
                            onTap: () {},
                          ),
                          ListTile(
                            leading: Container(
                              child: Icon(Icons.exit_to_app),
                              height: double.infinity,
                            ),
                            title: Text('Sign out'),
                            onTap: () async {
                              await _authService.signOut();
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    );
                  });
            },
          )
        ],
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          label: const Text('Add entry'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddEntryScreen(),
                  fullscreenDialog: true),
            );
          }),
    );
  }

  List<Widget> getActions(int page) {
    switch (page) {
      case 0:
        return <Widget>[
          IconButton(
              icon: Icon(Icons.chevron_left),
              onPressed: () {
                setState(() {
                  _timeUtil.setDateTimePrevious();
                });
              }),
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              setState(() {
                _timeUtil.setDateTime(DateTime.now());
              });
            },
          ),
          IconButton(
              icon: Icon(Icons.chevron_right),
              onPressed: () {
                setState(() {
                  _timeUtil.setDateTimeNext();
                });
              }),
          IconButton(
              icon: Icon(Icons.sort),
              onPressed: () {
                setState(() {
                  _desc = !_desc;
                });
              }),
        ];
      case 1:
        return <Widget>[];
      case 2:
        return <Widget>[];
      default:
        return <Widget>[];
    }
  }

  List<Widget> getTitle(int page) {
    switch (page) {
      case 0:
        return <Widget>[
          GestureDetector(
            onTap: () async {
              DateTime _dateTime = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
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
            child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Column(
                children: <Widget>[
                  Text(_timeUtil.getDateTimeAsString('MMMMd')),
                  if (_timeUtil.isToday())
                    Text(
                      'Today',
                      style: TextStyle(fontSize: 14.0),
                    )
                ],
              ),
              SizedBox(width: 4.0),
              Icon(Icons.arrow_drop_down)
            ]),
          ),
        ];
      case 1:
        return <Widget>[
          Text('Progress')
        ];
      case 2:
        return <Widget>[
          Text('Help and feedback')
        ];
      default:
        return <Widget>[];
    }
  }
}

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  List data = snapshot.map((data) => _buildListItem(context, data)).toList();
  return ListView.separated(
    itemCount: snapshot.length,
    separatorBuilder: (BuildContext context, int index) => Divider(),
    itemBuilder: (BuildContext context, int index) {
      return data[index];
    },
  );
}

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  final entry = Entry.fromSnapshot(data);

  return ListTile(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ViewEntryScreen(entry: entry),
            fullscreenDialog: false),
      );
    },
    leading: Text(toEmotion(entry.emotion), style: TextStyle(fontSize: 42)),
    title: Text(entry.title,
        style: TextStyle(fontWeight: FontWeight.bold),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        softWrap: true),
    subtitle: Row(
      children: <Widget>[
        Text(DateFormat('jm').format(entry.timestamp.toDate()),
            style: TextStyle(fontWeight: FontWeight.bold)),
        Text(' - '),
        Expanded(
            child: Text(entry.content,
                overflow: TextOverflow.ellipsis, maxLines: 1, softWrap: true)),
      ],
    ),
  );
}

String toEmotion(int emotionNum) {
  final emotions = ['😞', '😓', '🙂', '😌', '🤩'];
  return emotions[emotionNum];
}

Widget showEntries(BuildContext context, bool _desc, TimeUtil _timeUtil) {
  FirebaseUser _currentUser = Provider.of<FirebaseUser>(context);
  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance
        .collection('user')
        .document(_currentUser.uid)
        .collection('entry')
        .where('timestamp',
            isGreaterThanOrEqualTo: _timeUtil.getTodayStartDateTime())
        .where('timestamp',
            isLessThanOrEqualTo: _timeUtil.getTodayEndDateTime())
        .orderBy('timestamp', descending: _desc)
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.data == null || snapshot.data.documents.length == 0) {
        return SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('No Entries', style: TextStyle(fontSize: 24)),
                Text('Add a new entry using the buttom below',
                    style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        );
      } else {
        return _buildList(context, snapshot.data.documents);
      }
    },
  );
}
