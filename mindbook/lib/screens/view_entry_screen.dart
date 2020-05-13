import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mindbook/models/entry.dart';

class ViewEntryScreen extends StatelessWidget {
  final Entry entry;

  ViewEntryScreen({Key key, @required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.edit), onPressed: () {}),
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () async {
              await Firestore.instance.runTransaction(
                  (transaction) => transaction.delete(entry.reference));
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Center(),
    );
  }
}
