import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mindbook/models/entry.dart';

class DatabaseService {

  static String userId;

  DatabaseService(String uid) {
    userId = uid;
  }

  final CollectionReference _userCollection = Firestore.instance.collection('user');
  final CollectionReference _entryCollection = Firestore.instance.collection('user').document(userId).collection('entry');

  createEntry(Entry entry) {
    return _entryCollection.add(entry.toJson());
  }

  entrySnapshots() {
    return _entryCollection.snapshots();
  }

}
