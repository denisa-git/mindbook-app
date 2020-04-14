import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mindbook/screens/auth_screen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Entries', style: TextStyle(color: Colors.black)),
              SizedBox(height: 12),
              // TODO: add date picker
              Visibility(
                visible: true,
                child: Text(
                  'Today',
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          brightness: Brightness.light,
          centerTitle: false,
        ),
        body: showEntries(),
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
                onPressed: () {
                  // TODO: Find better way to dispose of current user session and dump ancestors
                  signOutGoogle().whenComplete(() {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return AuthScreen();
                        },
                      ),
                    );
                  });
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

Widget showEntries() {
  if (true) {
    // return ListView.separated(
    //   padding: const EdgeInsets.all(8),
    //   itemCount: 2,
    //   itemBuilder: (BuildContext context, int index) {
    //     return 
    //   },
    //   children: <Widget>[
    //     ListTile(
    //       onTap: () {},
    //       leading: Text('😊', style: TextStyle(fontSize: 42)),
    //       title: Text('consectetur adipiscing elit duis tristique',style: TextStyle(fontWeight: FontWeight.bold)),
    //       subtitle: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
    //     ),
    //     ListTile(
    //       onTap: () {},
    //       leading: Text('😈', style: TextStyle(fontSize: 42)),
    //       title: Text('consectetur lorem donec massa sapien', style: TextStyle(fontWeight: FontWeight.bold)),
    //       subtitle: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
    //     ),
    //   ],
    //   separatorBuilder: (BuildContext context, int index) => const Divider(),
    // );
  } else {
    return SafeArea(
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('No Entries', style: TextStyle(fontSize: 24, color: Colors.grey)),
              Text('Add a new entry using the buttom below', style: TextStyle(fontSize: 16, color: Colors.grey)),
            ],
          ),
      ),
    );
  }
}

Future<Null> signOutGoogle() async {
  await googleSignIn.signOut();
  await _auth.signOut();
}
