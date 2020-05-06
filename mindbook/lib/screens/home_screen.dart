import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mindbook/models/entry.dart';
import 'package:mindbook/screens/add_entry_screen.dart';
import 'package:mindbook/services/auth_service.dart';
import 'package:mindbook/utils/time_util.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  AuthService _authService;
  TimeUtil _timeUtil;

  @override
  void initState() {
    super.initState();
    this._authService = AuthService();
    this._timeUtil = TimeUtil(DateTime.now());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(icon: Icon(Icons.sort), onPressed: () {}),
            IconButton(
              icon: Icon(Icons.today),
              onPressed: () {
                setState(() {
                  this._timeUtil.setDateTime(DateTime.now());
                });
              },
            )
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
                    this._timeUtil.setDateTime(_dateTime);
                  });
                },
                child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(this._timeUtil.getDateTimeAsString('MMMMd')),
                      if (this._timeUtil.isToday())
                        Text(
                          'Today',
                          style: TextStyle(fontSize: 14.0),
                        )
                    ],
                  ),
                  SizedBox(width: 2.0),
                  Icon(Icons.arrow_drop_down)
                ]),
              ),
            ],
          ),
          centerTitle: false,
        ),
        body: showEntries(context),
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
                          ListTile(
                            leading: Container(
                              child: Icon(Icons.person),
                              height: double.infinity,
                            ),
                            title: Text('Orion Koteki'),
                            subtitle: Text('orion.koteki@gmail.com'),
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
  return ListView(
    padding: const EdgeInsets.only(top: 20.0),
    children: snapshot.map((data) => _buildListItem(context, data)).toList(),
  );
}

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  final entry = Entry.fromSnapshot(data);

  return ListTile(
    onTap: () => print(entry),
    leading: Text(toEmotion(entry.emotion), style: TextStyle(fontSize: 42)),
    title: Text(entry.title, style: TextStyle(fontWeight: FontWeight.bold)),
    subtitle: Row(
      children: <Widget>[
        Text(getTime(entry.timestamp.toDate()),
            style: TextStyle(fontWeight: FontWeight.bold)),
        Text(' - '),
        Expanded(
            child: Text(entry.desc,
                overflow: TextOverflow.ellipsis, maxLines: 1, softWrap: true)),
      ],
    ),
  );
}

String toEmotion(int emotionNum) {
  // TODO: declare else where
  final emotions = ['😈', '🤨', '😨', '🤢', '💩'];
  return emotions[emotionNum];
}

String getTime(DateTime dateTime) {
  // TODO: add shared pref option for date time format (24/12 hour)
  var formatter = new DateFormat('jm');
  return formatter.format(dateTime);
}

Widget showEntries(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection('entry').snapshots(),
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
