import 'package:flutter/material.dart';
import 'package:team_project/list.dart';
import 'package:team_project/review.dart';
import 'package:team_project/step1.dart';
import 'package:team_project/step2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:team_project/low.dart';
import 'package:team_project/mid.dart';
import 'package:team_project/high.dart';

class ChoicePage extends StatelessWidget {
  final Record detail;

  ChoicePage({Key key, @required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text(
            'Master Chef Challenge',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.amber,
        ),
        body: Padding(
            key: ValueKey(detail.name),
            padding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Card(
                child: Column(children: <Widget>[
                  //Image.network(detail.imgurl,width: 600,height: 200,fit: BoxFit.fill,),
                  Container(
                      child: Image.network(
                        detail.imgurl,
                        fit: BoxFit.fill,
                        width: 600,
                        height: 200,
                      )),
                  Flexible(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      child: Text(detail.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                              color: Colors.grey[700])),

                    ),
                  ),
                  Flexible(
                    flex: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Flexible(
                          flex: 2,
                          child: Column(children: <Widget>[
                            Text("level",
                                style: TextStyle(color: Colors.grey[500])),

                            Text(
                              detail.level.toString(),
                              style: TextStyle(fontSize: 25),
                            ),
                          ]),
                        ),
                        Flexible(
                          flex: 2,
                          child: Column(children: <Widget>[
                            Text("preptime",
                                style: TextStyle(color: Colors.grey[500])),
                            Text(
                              "10" + "m",
                              style: TextStyle(fontSize: 25),
                            ),
                          ]),
                        ),
                        Flexible(
                          flex: 2,
                          child: Column(children: <Widget>[
                            Text("cook time",
                                style: TextStyle(color: Colors.grey[500])),
                            Text(
                              "20" + "m",
                              style: TextStyle(fontSize: 25),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),

                  Flexible(
                    flex: 1,
                    child: ButtonTheme(
                      minWidth: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ReviewPage(detail: detail)));
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            //padding: EdgeInsets.all(8.0),
                            child: new Text("REVIEW",
                                style: TextStyle(
                                    color: Colors.amberAccent, fontSize: 15)),
                            color: Colors.grey[100],
                          ),
                          RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Step1Page(detail: detail)));
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            //padding: EdgeInsets.all(8.0),
                            child: new Text("START",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0)),
                            color: Colors.amberAccent,
                          ),
                          //Spacer(flex: 1,)
                        ],
                      ),
                    ),
                  )
                ]),
              ),
            )));
  }

//  Widget _buildBody(BuildContext context) {
//    return Container
//
//    );
//
//
//  }
}