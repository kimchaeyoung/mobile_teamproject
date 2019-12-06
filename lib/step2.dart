import 'package:flutter/material.dart';
import 'package:team_project/list.dart';
import 'package:team_project/step3.dart';
import 'package:quiver/async.dart';
import 'dart:async';


class Step2Page extends StatefulWidget {

  final Record detail;
  const Step2Page({Key key, this.detail}) : super(key: key);


  @override
  _Step2PageState createState() => _Step2PageState(detail: detail);
}


class _Step2PageState extends State<Step2Page> {
  final Record detail;

  _Step2PageState({this.detail});
  bool flag = true;
  Timer _timer;
  int index = 0;
  int _start = 10;


  void startTimer() {
    _start = detail.recipe[index]['timer'];
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) =>
          setState(
                () {
              if (!mounted) return;
              if (_start < 1) {
                if(index == detail.recipe.length-1){
                  flag = false;
                  timer.cancel();
                }
                else {
                  print(detail.recipe.length);
                  index += 1;
                  startTimer();
                }
                //timer.cancel();
              } else {
                _start = _start - 1;
              }
            },
          ),
    );
  }

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
            const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Card(
                child:
                Column(children: <Widget>[
                  Flexible(
                    flex: 6,
                    child:
                    Container(
                      padding: const EdgeInsets.all(32),
                      child:

                      Row(
                        children: <Widget>[

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child:
                                Row(
                                  children: <Widget>[
                                    Text(detail.recipe[index]['recipe_des'].toString()),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(Icons.alarm_on),
                                      onPressed:
                                          (){
                                        startTimer();
                                      },
                                    ),
                                    Text("$_start")

                                  ],
                                ),
                              )

                            ],
                          ),

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
                          new RaisedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: new Text(
                              "BACK",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 80,
                          ),
                          new RaisedButton(
                            onPressed: () {
                              if(index == detail.recipe.length-1) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Step3Page(
                                                detail: detail, flag: flag)));
                              }
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

}