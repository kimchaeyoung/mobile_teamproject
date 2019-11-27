import 'package:flutter/material.dart';
import 'package:team_project/list.dart';


class Step3Page extends StatelessWidget {

  final Record detail;

  Step3Page({Key key, @required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar:
          AppBar(
            title: Text('Master Chef', style: TextStyle(color: Colors.black),),
            backgroundColor: Colors.yellow,
          ),
    );
  }
}
