import 'package:flutter/material.dart';
import 'package:team_project/list.dart';
import 'package:team_project/home.dart';
import 'package:team_project/reviewCreate.dart';
import 'package:flare_flutter/flare_actor.dart';

class Step3Page extends StatelessWidget {
  final Record detail;
  final bool flag;

  Step3Page({Key key, @required this.detail, this.flag}) : super(key: key);

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
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: 300,
                          height: 300,
                          child:
                          flag?
                          FlareActor(
                              "images/Bob (Minion).flr",
                              alignment:Alignment.center, fit:BoxFit.contain,animation: 'Dance'
                          ):
                          FlareActor(
                              "images/Bob (Minion).flr",
                              alignment:Alignment.center, fit:BoxFit.contain,animation: 'Stand'
                          ),
                        ),
                        flag?
                        Text("Success"): Text("Fail"),
                        Flexible(
                          flex: 2,
                          child: Container(
                            child: new RaisedButton(
                              child: new Text(
                                "리뷰 남기기",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ReviewCreatePage(detail: detail,)
                                    )
                                );
                              },
                              color: Colors.amber,
                            ),
                            //height: 30,
                          ),
                        ),
                        Flexible(
                          flex:7,
                          child: Container(

                          ),
                        ),
                        Flexible(
                            flex: 2,
                            child: ButtonTheme.bar(
                                child: new ButtonBar(
                                    alignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      //Spacer(flex: 1),
                                      new RaisedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => HomePage()));
                                        },
                                        child: new Text(
                                          "Home",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        color: Colors.grey,
                                      ),
                                    ]))),
                      ],
                    )))));
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[Text(detail.ingredient.toString())],
      ),
    );
  }
}