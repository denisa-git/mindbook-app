import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mindbook/screens/auth_screen.dart';
import 'package:mindbook/screens/home_screen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: Display splash screen while waitng for userLoggedIn()
  runApp(new MaterialApp(
      debugShowCheckedModeBanner: false, home: await userLoggedIn()));
}

Future<Widget> userLoggedIn() async {
  return StreamBuilder<FirebaseUser>(
    stream: _auth.onAuthStateChanged,
    builder: (BuildContext context, snapshot) {
      if (snapshot.hasData && (!snapshot.data.isAnonymous)) {
        return HomeScreen();
      }

      return AuthScreen();
    },
  );
}
