import 'package:cloud_firestore/cloud_firestore.dart';

class Entry {
  final Timestamp timestamp;
  final String title;
  final String content;
  final int emotion;
  final List<String> tags;
  final List<String> wheelEmotions;
  final DocumentReference reference;

  Entry.fromMap(Map<String, dynamic> map, {this.reference})
      : timestamp = map['timestamp'],
        title = map['title'],
        content = map['content'],
        emotion = map['emotion'],
        tags = List.from(map['tags']),
        wheelEmotions = List.from(map['wheelEmotions']);

  Entry.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  Map<String, dynamic> toJson() => {
    'timestamp': timestamp,
    'title': title,
    'content': content,
    'emotion': emotion,
    'tags': tags,
    'wheelEmotions': wheelEmotions
  };

  @override
  String toString() => "Entry<$title:$content:$emotion:$reference>";
}
