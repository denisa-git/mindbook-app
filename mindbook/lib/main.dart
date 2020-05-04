import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mindbook/services/auth_service.dart';
import 'package:mindbook/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(MindbookApp());

class MindbookApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>.value(
      value: AuthService().currentUser,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        home: Screens(),
      ),
    );
  }
}
