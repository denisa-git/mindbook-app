import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mindbook/models/entry.dart';
import 'package:http/http.dart' as http;
import 'package:mindbook/models/sentiment.dart';
import 'package:mindbook/services/database_service.dart';
import 'package:provider/provider.dart';

class ViewEntryScreen extends StatefulWidget {
  final Entry entry;
  ViewEntryScreen({Key key, @required this.entry}) : super(key: key);
  _ViewEntryScreen createState() => _ViewEntryScreen(entry: entry);
}

class _ViewEntryScreen extends State<ViewEntryScreen> {
  final Entry entry;
  bool editState;
  ScrollController _scrollController;
  bool _scrollIdle;
  Future<Sentiment> futureSentiment;
  FirebaseUser _currentUser;

  TextEditingController _entryTitle;
  TextEditingController _entryContent;

  _ViewEntryScreen({@required this.entry});

  @override
  void initState() {
    editState = false;
    _scrollIdle = true;
    _scrollController = ScrollController()
      ..addListener(() {
        bool _idle = _scrollController.position.userScrollDirection ==
            ScrollDirection.forward;
        if (_scrollIdle != _idle) {
          setState(() {});
        }
        _scrollIdle = _idle;
      });
    futureSentiment = fetchSentiment();
    _entryTitle = new TextEditingController()..text = entry.title;
    _entryContent = new TextEditingController()..text = entry.content;
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<Sentiment> fetchSentiment() async {
    if (entry.content == "") {
      Map<String, String> emptyMap = {
        "sentiment": 'Missing content',
      };

      return Sentiment.fromJson(emptyMap);
    }
    String error = "Error";
    try {
      final response = await http.post(
        'https://net1.dev/analyse',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'text': entry.content,
        }),
      );
      if (response.statusCode == 200) {
        return Sentiment.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load sentiment');
      }
    } catch (e) {
      print(e);
    }

    Map<String, String> emptyMap = {
      "sentiment": error,
    };

    return Sentiment.fromJson(emptyMap);
  }

  @override
  Widget build(BuildContext context) {
    _currentUser = Provider.of<FirebaseUser>(context);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
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
      body: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(toEmotion(entry.emotion - 1),
                            style: TextStyle(fontSize: 42)),
                        SizedBox(
                          width: 16,
                        ),
                        Flexible(
                          child: TextField(
                            controller: _entryTitle,
                            readOnly: !editState,
                            decoration: InputDecoration.collapsed(
                                hintText: 'Entry title'),
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Wrap(
                      children: <Widget>[
                        Wrap(
                          spacing: 14,
                          alignment: WrapAlignment.start,
                          children:
                              List<Widget>.generate(entry.tags.length, (index) {
                            return Chip(
                              label: Text(capitalize(entry.tags[index])),
                            );
                          }).toList(),
                        ),
                        Divider(),
                        Wrap(
                          spacing: 14,
                          alignment: WrapAlignment.start,
                          children: List<Widget>.generate(
                              entry.wheelEmotions.length, (index) {
                            return Chip(
                              label:
                                  Text(capitalize(entry.wheelEmotions[index])),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    Divider(),
                    TextField(
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      controller: _entryContent,
                      readOnly: !editState,
                      decoration:
                          InputDecoration.collapsed(hintText: 'Entry content'),
                    ),
                    Divider(),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.info_outline),
                          SizedBox(width: 8),
                          Text('Sentiment analysis of entry:'),
                          SizedBox(width: 4),
                          FutureBuilder<Sentiment>(
                              future: futureSentiment,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                      snapshot.data.sentiment.toUpperCase());
                                } else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }
                                return SizedBox(
                                  width: 12,
                                  height: 12,
                                  child: CircularProgressIndicator(),
                                );
                              })
                        ]),
                    SizedBox(height: 16)
                  ],
                ),
              ))
            ],
          ),
        ),
        floatingActionButton: _scrollIdle
            ? FloatingActionButton.extended(
                onPressed: () {
                  setState(() {
                    if (editState) {
                      DatabaseService db = DatabaseService(_currentUser.uid);
                      Map<String, dynamic> thisMap = {
                        'title': _entryTitle.text,
                        'content': _entryContent.text
                      };
                      db.updateEntry(entry, thisMap);
                    }
                    editState = !editState;
                  });
                },
                label: Text(editState ? 'Save' : 'Edit'),
                icon: Icon(editState ? Icons.save : Icons.edit),
              )
            : Container(),
      ),
    );
  }

  String toEmotion(int emotionNum) {
    final emotions = ['😞', '😓', '🙂', '😌', '🤩'];
    return emotions[emotionNum];
  }

  String capitalize(String _string) {
    return "${_string[0].toUpperCase()}${_string.substring(1)}";
  }
}
