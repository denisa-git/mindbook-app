import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mindbook/models/entry.dart';
import 'package:mindbook/screens/add_entry_screen.dart';
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

  @override
  void initState() {
    super.initState();
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
          actions: <Widget>[
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
          ],
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
            ],
          ),
          centerTitle: false,
        ),
        body: showEntries(context, _desc, _timeUtil),
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
                              onTap: () {},
                            ),
                          if (_currentUser.displayName == null)
                            ListTile(
                              leading: Container(
                                child: Icon(Icons.person),
                                height: double.infinity,
                              ),
                              title: Text('Anonymous'),
                              onTap: () {},
                            ),
                          Divider(),
                          ListTile(
                            leading: Container(
                              child: Icon(Icons.view_list),
                              height: double.infinity,
                            ),
                            title: Text('My Entries'),
                            onTap: () {},
                            selected: true,
                          ),
                          ListTile(
                            leading: Container(
                              child: Icon(Icons.equalizer),
                              height: double.infinity,
                            ),
                            title: Text('Progress'),
                            onTap: () {},
                          ),
                          Divider(),
                          ListTile(
                            leading: Container(
                              child: Icon(Icons.info),
                              height: double.infinity,
                            ),
                            title: Text('Help and feedback'),
                            onTap: () {},
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
                  builder: (context) => AddEntryPageView(),
                  fullscreenDialog: true),
            );
          }),
    );
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
    onTap: () async => await Firestore.instance
        .runTransaction((transaction) => transaction.delete(entry.reference)),
    leading: Text(toEmotion(entry.emotion), style: TextStyle(fontSize: 42)),
    title: Text(entry.title, style: TextStyle(fontWeight: FontWeight.bold)),
    subtitle: Row(
      children: <Widget>[
        Text(getTime(entry.timestamp.toDate()),
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

String getTime(DateTime dateTime) {
  // TODO: add shared pref option for date time format (24/12 hour)
  var formatter = new DateFormat('jm');
  return formatter.format(dateTime);
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
