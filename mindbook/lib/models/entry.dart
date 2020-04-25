import 'package:cloud_firestore/cloud_firestore.dart';

class Entry {
  final Timestamp dateTime;
  final String title;
  final String desc;
  final String content;
  final int emotion;
  final DocumentReference reference;

  Entry.fromMap(Map<String, dynamic> map, {this.reference})
      : dateTime = map['dateTime'],
        title = map['title'],
        desc = map['desc'],
        content = map['content'],
        emotion = map['emotion'];

  Entry.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Entry<$title:$desc>";

  // TODO: more getters like the one above
}
