import 'package:flutter/material.dart';
import 'package:mindbook/services/auth_service.dart';

final AuthService _auth = AuthService();

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Mindbook',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Welcome back!'),
                    ],
                  ),
                ),
                TextField(
                    decoration: InputDecoration(
                  labelText: 'Email',
                )),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                      onPressed: () {},
                      color: Colors.white,
                      child: Text('Sign In', style: TextStyle(color: Colors.black),),
                      shape: StadiumBorder()),
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlineButton(
                      onPressed: () {},
                      // highlightedBorderColor: Colors.black,
                      child: Text('Sign Up'),
                      shape: StadiumBorder()),
                ),
                SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot your password?',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      shape: StadiumBorder()),
                ),
                Spacer(),
                Divider(),
                SizedBox(
                  width: double.infinity,
                  child: FlatButton.icon(
                      onPressed: () async {
                        await _auth.signInWithGoogle();
                      },
                      color: Colors.blue,
                      textColor: Colors.white,
                      icon: Icon(Icons.person),
                      label: Text('Sign in with Google'),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30),
                      )),
                ),
                SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                      onPressed: () async {
                        await _auth.signInAnonymously();
                      },
                      color: Colors.grey,
                      textColor: Colors.white,
                      child: Text('Sign in anonymously'),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30),
                      )),
                ),
              ],
            ),
          ),
        ),
      );
}
