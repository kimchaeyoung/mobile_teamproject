import 'package:flutter/material.dart';
import 'package:team_project/list.dart';
import 'package:team_project/step2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Step1Page extends StatelessWidget{

  final Record detail;

  Step1Page({Key key, @required this.detail}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Master Chef', style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.yellow,
        ),
        body:
          Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                      child: Image.network(
                        detail.imgurl,
                        fit: BoxFit.cover,
                        width: 600,
                        height: 300,
                      )),
                  ButtonTheme.bar(
                    child: ButtonBar(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_forward),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.push(
                                context, MaterialPageRoute(
                              builder: (context) => Step2Page(detail: detail),
                            )
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              _buildBody(context),
            ],
          )

    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(detail.ingredient.toString())
        ],
      ),
    );
  }
}

