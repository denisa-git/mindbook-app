import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mindbook/models/entry.dart';

class DatabaseService {

  static String userId;

  DatabaseService(String uid) {
    userId = uid;
  }

  final CollectionReference userCollection = Firestore.instance.collection('user');
  final CollectionReference entryCollection = Firestore.instance.collection('user').document(userId).collection('entry');

  createEntry(Entry entry) {
    return entryCollection.add(entry.toJson());
  }

}
