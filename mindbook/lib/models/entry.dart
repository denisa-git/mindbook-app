import 'package:cloud_firestore/cloud_firestore.dart';

class Entry {
  final Timestamp timestamp;
  final String title;
  final String content;
  final int emotion;
  final DocumentReference reference;

  Entry.fromMap(Map<String, dynamic> map, {this.reference})
      : timestamp = map['timestamp'],
        title = map['title'],
        content = map['content'],
        emotion = map['emotion'];

  Entry.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  Map<String, dynamic> toJson() => {
    'title': title,
  };

  @override
  String toString() => "Entry<$title>";
}
