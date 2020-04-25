import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mindbook/screens/auth_screen.dart';
import 'package:mindbook/screens/home_screen.dart';
import 'package:provider/provider.dart';

class Screens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<FirebaseUser>(context);
    if (currentUser == null){
      return AuthScreen();
    } else {
      return HomeScreen();
    }
  }
}
