import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String userId;
  DatabaseService({this.userId});

  final CollectionReference userCollection = Firestore.instance.collection('user');

  Future createUserPrefs() async {
    // final CollectionReference userEntryCollection = Firestore.instance.collection('user').document(this.userId).collection('entry');
    return await userCollection.document(userId).setData({
      'theme': 'light',
      'timeformat': '12-hour'
    });
  }

}
