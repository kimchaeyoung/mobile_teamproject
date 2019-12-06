import 'package:flutter/material.dart';
import 'package:team_project/list.dart';
import 'package:team_project/step1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReviewCreatePage extends StatefulWidget {
  final Record detail;

  const ReviewCreatePage({Key key, this.detail}) : super(key: key);

  @override
  _ReviewCreateState createState() {
    return _ReviewCreateState(detail: detail);
  }
}

class _ReviewCreateState extends State<ReviewCreatePage> {

  final Record detail;
  final TextEditingController _reviews = TextEditingController();
  final dataReference = Firestore.instance.collection('menu');


  _ReviewCreateState({this.detail});

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String uid = "";

  Future<FirebaseUser> getFirebaseUser() async{
    FirebaseUser user = await firebaseAuth.currentUser();

    setState(() {
      uid = user.uid.toString();
    });

    return user;
  }

  void initState() {
    super.initState();
    getFirebaseUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Master Chef Challenge'),
        backgroundColor: Colors.amber,
      ),
      body:
      Padding(
        key: ValueKey(detail.name),
        padding:
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Container(
                  child: Image.network(
                    widget.detail.imgurl,
                    fit: BoxFit.fill,
                    width: 500,
                    height: 250,
                  ),
                ),
              ),
              SizedBox(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _reviews,
                      decoration: InputDecoration(labelText: '한줄평을 남겨주세요', labelStyle: new TextStyle(color: Colors.blueAccent)),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                child: Text("add"),
                onPressed: () async{
                  setState(() {
                    widget.detail.review[uid] = _reviews.text;
                  });

                  await dataReference.reference().document(detail.reference.documentID)
                      .updateData({'review': widget.detail.review});
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Step1Page(detail: detail)
                      )
                  );
                },
              )
            ],
          ),
        ),
      ),

    );
  }
}