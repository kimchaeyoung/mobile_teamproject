import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_project/step1.dart';

import 'package:team_project/choice.dart';
import 'package:team_project/list.dart';

class ReviewPage extends StatelessWidget {
  final Record detail;

  ReviewPage({Key key, @required this.detail}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Master Chef Challenge'),
          backgroundColor: Colors.amber,
        ),
        body: new Column(
        children: <Widget>[
          new Container(
            child: Image.network(
            detail.imgurl,
            fit: BoxFit.fill,
            width: 600,
            height: 250,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(3.0),

            child: Align(
              alignment: Alignment.topRight,
              child: Text("Review", style: TextStyle(backgroundColor: Colors.amberAccent, fontSize: 17),),
            )
          ),
          new Expanded(
            child: _buildBody(context),
          )
        ]
      )
    );
  }

  Widget _buildBody(BuildContext context) {

    return ListView.separated(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 20.0),
      itemCount: detail.review.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.only(left: 20),
          height: 100,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: Row(children: <Widget>[
                    Text(
                      '${detail.review.keys.elementAt(index)}',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ]),
                ),
                Expanded(
                  child: Row(children: <Widget>[
                    Text(
                      '${detail.review.values.elementAt(index)}',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    )
                  ]),
                ),

              ]),

        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        color: Colors.black,
      ),
    );
  }
}