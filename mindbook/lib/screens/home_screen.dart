import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mindbook/models/entry.dart';
import 'package:mindbook/services/auth_service.dart';

final AuthService _auth = AuthService();

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.today),
              onPressed: () {},
            )
          ],
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Today', style: TextStyle(color: Colors.black)),
            ],
          ),
          backgroundColor: Colors.transparent,
          brightness: Brightness.light,
          centerTitle: false,
        ),
        body: showEntries(context),
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: null,
              ),
              IconButton(
                icon: Icon(Icons.exit_to_app),
                tooltip: "Sign Out",
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
            ],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
          elevation: 4.0,
          icon: const Icon(Icons.add),
          label: const Text('Add entry'),
          onPressed: null),
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
        Text(getTime(entry.dateTime.toDate()),
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
        // return LinearProgressIndicator();
        return SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('No Entries',
                    style: TextStyle(fontSize: 24, color: Colors.grey)),
                Text('Add a new entry using the buttom below',
                    style: TextStyle(fontSize: 16, color: Colors.grey)),
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
