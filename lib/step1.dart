import 'package:flutter/material.dart';
import 'package:team_project/list.dart';
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
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.all(32),
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
                          //Spacer(flex: 1),
//                          new RaisedButton(
//                            onPressed: () {},
//                            child: new Text(
//                              "BACK",
//                              style: TextStyle(color: Colors.white),
//                            ),
//                            color: Colors.grey,
//                          ),
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
          Text(detail.ingredient[0]['ing_name'].toString() +" - " +detail.ingredient[0]['ing_weight'].toString()+"g"),
          Text(detail.ingredient[1]['ing_name'].toString() +" - " +detail.ingredient[1]['ing_weight'].toString()+"g" ),
        ],
      ),
    );
  }
}