import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mindbook/models/entry.dart';

class DatabaseService {
  String userId;

  DatabaseService(String uid) {
    userId = uid;
  }

  createEntry(Entry entry) {
    return Firestore.instance
        .collection('user')
        .document(userId)
        .collection('entry')
        .add(entry.toJson());
  }

  updateEntry(Entry oldEntry, Map<String, dynamic> newEntry) {
    return Firestore.instance
        .collection('user')
        .document(userId)
        .collection('entry')
        .document(oldEntry.reference.documentID)
        .updateData(newEntry);
  }

  entrySnapshots() {
    return Firestore.instance
        .collection('user')
        .document(userId)
        .collection('entry')
        .snapshots();
  }
}
