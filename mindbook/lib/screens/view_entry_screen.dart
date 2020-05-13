import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mindbook/models/entry.dart';

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
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                        Text(toEmotion(entry.emotion),
                            style: TextStyle(fontSize: 42)),
                        SizedBox(
                          width: 16,
                        ),
                        Flexible(
                            child: Text(entry.title,
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.visible,
                                softWrap: true)),
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
                    Text(entry.content),
                    Divider(),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.info_outline),
                          SizedBox(width: 8),
                          Text('Sentiment analysis of entry:'),
                          SizedBox(width: 8),
                          // get SA result
                          if (false)
                            Text('Analysing...')
                          else
                            Text('get data')
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
