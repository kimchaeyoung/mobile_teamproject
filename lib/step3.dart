import 'package:flutter/material.dart';
import 'package:team_project/list.dart';

class Step3Page extends StatelessWidget {
  final Record detail;

  Step3Page({Key key, @required this.detail}) : super(key: key);

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
                        Container(
                          child: Image.network(
                            'https://dimg.donga.com/a/660/0/90/5/ugc/CDB/SODA/Article/5d/a6/d1/6a/5da6d16a1d5fd2738de6.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Container(
                            child: FlatButton(
                              child: Text(
                                  "리뷰 남기기"
                              ),
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
                                                  builder: (context) => ListRecipe()));
                                        },
                                        child: new Text(
                                          "LIST",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        color: Colors.grey,
                                      ),
//                Container(
//                  child: Image.network(
//                    detail.failimg,fit:BoxFit.fill
//                  ),
//                )
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