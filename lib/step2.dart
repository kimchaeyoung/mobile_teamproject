import 'package:flutter/material.dart';
import 'package:team_project/list.dart';
import 'package:team_project/step3.dart';
import 'package:quiver/async.dart';

class Step2Page extends StatefulWidget {

  final Record detail;
  const Step2Page({Key key, this.detail}) : super(key: key);


  @override
  _Step2PageState createState() => _Step2PageState(detail: detail);
}


class _Step2PageState extends State<Step2Page> {
  final Record detail;
  _Step2PageState({this.detail});

  int _start = 600;
  int _current = 600;

  int _current_min = 0;

  int _current_second = 0;

  void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(minutes: _start),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() { _current = _start - duration.elapsed.inSeconds;
      _current_second= _current%60;
        // _current_min = _current/ ;
        //_current_min = Math.round(_current/60);
      });
    });

    sub.onDone(() {
      print("Done");
      sub.cancel();
    });
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
                child: Column(children: <Widget>[
                  //Image.network(detail.imgurl,width: 600,height: 200,fit: BoxFit.fill,),
                  //   Stack(
                  //   children: <Widget>[
//                      Container(
//                          child: Image.network(
//                            //detail.imgurl,
//                            fit: BoxFit.fill,
//                            width: 600,
//                            height: 200,
//                          )),
//                      ButtonTheme.bar(
//                        child: ButtonBar(
//                          children: <Widget>[
//                            IconButton(
//                              icon: Icon(Icons.arrow_forward),
//                              color: Colors.white,
//                              onPressed: () {
//                                Navigator.push(
//                                    context, MaterialPageRoute(
//                                  builder: (context) => Step3Page(detail: detail),
//                                )
//                                );
//                              },
//                            ),
//                          ],
//                        ),
//                      ),

                  //       ],
                  //    ),
                  Flexible(
                    flex: 6,
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
                                        //child: Text("start"),
                                      ),
                                      Text("$_current_min",)

                                    ],
                                  ),
//                                  child: RaisedButton(
//                                    onPressed: (){
//                                      startTimer();
//                                    },
//                                    child: Text("start"),
//                                  ),

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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Step3Page(detail: detail)));
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
        children: <Widget>[
          Text(detail.recipe[0].toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          //Text(detail.recipe[1].toString())
        ],
      ),
    );
  }
}