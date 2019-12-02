import 'package:flutter/material.dart';
import 'package:team_project/list.dart';
import 'package:team_project/history.dart';
import 'package:team_project/myrecipe.dart';
import 'package:team_project/step2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Step1Page extends StatelessWidget {
  final Record detail;

  Step1Page({Key key, @required this.detail}) : super(key: key);

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
                  Stack(
                    children: <Widget>[
                      Container(
                          child: Image.network(
                            detail.imgurl,
                            fit: BoxFit.fill,
                            width: 600,
                            height: 200,
                          )),
                      ButtonTheme.bar(
                        child: ButtonBar(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.arrow_forward),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Step2Page(detail: detail),
                                    ));
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    flex: 4,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(32, 32, 32, 15),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      _buildBody(context),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  Flexible(
                    flex: 1,
                    child: ButtonTheme.bar(
                      child: new ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(width: 100,),
                          new RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Step2Page(detail: detail)
                                  ));
                            },
                            child: new Text("NEXT",
                                style: TextStyle(color: Colors.white)),
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

  Widget _buildBody(BuildContext context) {
    return Container(
      child: Wrap(
        direction: Axis.vertical,
        children: [
          Center(

            child: Text(
              detail.name + " 재료",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            ),
          ),
          SizedBox(
            width: 200,
            height: 120,
            child:
            ListView.builder(
                padding: const EdgeInsets.all(1),
                itemCount: detail.ingredient.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Center(child: Text(
                        detail.ingredient[index]['ing_name'] + " - " +
                            detail.ingredient[index]['ing_weight'])),
                  );
                }
            ),
          )
        ],
      ),
    );
  }
}