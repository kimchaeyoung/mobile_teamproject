import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:team_project/step1.dart';
import 'package:team_project/choice.dart';
import 'package:team_project/list.dart';

class LowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Low'),
        backgroundColor: Colors.amber,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('menu')
          .where("level", isEqualTo: 1)
          .snapshots(),
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
              child: new Stack(
                children: <Widget>[
                  new Container(
                    height: 124.0,
                    margin: new EdgeInsets.all(8.0),
                    decoration: new BoxDecoration(
                      color: new Color(0xFFFFEFD5),
                      shape: BoxShape.rectangle,
                      borderRadius: new BorderRadius.circular(5.0),
                      //border: BorderStyle(color:),
                      boxShadow: <BoxShadow>[
                        new BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10.0,
                          offset: new Offset(0.0, 10.0),
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    margin: new EdgeInsets.all(10.0),
                    //alignment: FractionalOffset.centerLeft,
                    child: new Image.network(
                      record.imgurl,
                      fit: BoxFit.cover,
                    ),
                    height: 120.0,
                    width: 140.0,
                  ),
                  Container(
                    margin: new EdgeInsets.only(
                        right: 10.0, top: 25.0, bottom: 10.0, left: 170.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              record.name,
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                      "주재료: " +
                                          record.ingredient[0]['ing_name'] +
                                          ", " +
                                          record.ingredient[1]['ing_name'],
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 10.0)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )

          )),
    );
  }
}