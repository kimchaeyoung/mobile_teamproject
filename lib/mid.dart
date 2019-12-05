import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:team_project/step1.dart';
import 'package:team_project/choice.dart';
import 'package:team_project/list.dart';

class MidPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mid'),
        backgroundColor: Colors.amber,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('menu').where("level", isEqualTo:2).snapshots(),
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
                                              Text(
                                                  "주재료: " +
                                                      record.ingredient[0]
                                                      ['ing_name'] +
                                                      ", " +
                                                      record.ingredient[1]
                                                      ['ing_name'],
                                                  style: TextStyle(
                                                    color: Colors.grey[500],
                                                  )),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Icon(Icons.timer, color: Colors.grey[500],
                                              ),
                                              Text(
                                                "  분",
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