import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_project/choice.dart';
import 'package:team_project/list.dart';

bool flag = true;

class HistoryPage extends StatefulWidget {

  final String uid;

  HistoryPage({Key key, @required this.uid}):super(key:key);

  @override
  _HistoryPageState createState() {
    return _HistoryPageState(uid: uid);
  }
}

class _HistoryPageState extends State<HistoryPage> {
  final String uid;
  _HistoryPageState({this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game History'),
        backgroundColor: Colors.amber,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('menu').where('completed', arrayContains: uid).snapshots(),
      //snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Hero(
          tag: record.name,
          child: new InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ChoicePage(detail: record);
              }));
            },
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Image.network(
                        record.imgurl,
                        width: 600,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        padding: const EdgeInsets.all(32),
                        child: Row(children: <Widget>[
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  drawStars(record.level),
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          record.name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                  Container(
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Icon(Icons.timer, color: Colors.grey[500],
                                              ),
                                              Text(
                                                " " + record.total_time.toString() + " 분",
                                                style: TextStyle(
                                                    color: Colors.grey[500]),
                                              )
                                            ],
                                          )
                                        ],
                                      )),

                                ]),
                          ),
                        ]),
                      )
                    ],
                  ),
                )),
          )),
    );
  }
}