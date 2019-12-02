import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:team_project/list.dart';

class CreatePage extends StatefulWidget {
  //const CreatePage({ key key}):

  //final FirebaseUser user;

  //CreatePage({Key key, @required this.user}) : super(key: key);

  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final textEditingController_desc = TextEditingController();
  final textEditingController_price = TextEditingController();
  final textEditingController_description = TextEditingController();
  final textEditingController_name = TextEditingController();
  final textEditingController_ingname = TextEditingController();
  final textEditingController_ingweight = TextEditingController();

  void dispose() {
    textEditingController_desc.dispose();
    textEditingController_price.dispose();
    textEditingController_description.dispose();
    textEditingController_name.dispose();
    textEditingController_ingname.dispose();
    textEditingController_ingweight.dispose();

    super.dispose();
  }

  File _image;

  Future _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  List<dynamic> review_input = ["rr", "qq"];

//  //Map <String, int> map =
//
//  List<String> name_i= ["cake","cheese"];
//  List<int> weight_i = [30,5];
//  Map<dynamic,dynamic> ingredi = { "name" : "name_i", "weight": "weight_i"};
//  List<dynamic> ingredient_input = [];
//  List<dynamic> recipe_input=[];

  createAlertDialog(BuildContext context) {
    TextEditingController ing_name_Controller = new TextEditingController();
    TextEditingController ing_weight_Controller = new TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Add Ingredient"),
            content: Container(
              child: Column(
                children: <Widget>[
//                 Row(
//                   children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'name', border: OutlineInputBorder()),
                    controller: ing_name_Controller,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'weight', border: OutlineInputBorder()),
                    controller: ing_weight_Controller,
                  ),
                  //    ],
                  // )
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                  elevation: 5.0,
                  child: Text('ADD'),
                  onPressed: () {
//                    Firestore.instance.collection('baby').add({
//                      'name': customController.text,
//                      'votes': 0,
//                      'dislike': 0
                    // });
                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text(
            'Create Recipe',
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.file_upload),
                //child: Text("Save"),
                onPressed: () {
                  var c_time = new DateTime.now();

                  if (_image != null) {
                    final firebaseStorageRef = FirebaseStorage.instance
                        .ref()
                        .child('prod')
                        .child(c_time.toString() + '.png');

                    final task = firebaseStorageRef.putFile(
                        _image, StorageMetadata(contentType: 'image/png'));

                    task.onComplete.then((value) {
                      var downloadUrl = value.ref.getDownloadURL();

                      downloadUrl.then((url) {
                        var doc =
                        Firestore.instance.collection('menu').document();
                        doc.setData({
                          //'id': doc.documentID,
                          //'description': textEditingController_description.text,
                          'imgurl': url == null
                              ? 'https://image.shutterstock.com/image-vector/no-image-available-icon-template-260nw-1036735678.jpg'
                              : url.toString(),
                          'level': int.parse(textEditingController_price.text),
                          'name': textEditingController_name.text,
                          'desc': "",
                          'reviews': "",
                          'ingredient': "ll",
                          'recipe': "step1",
                        });
                      });
                    });
                  } else {
                    var DefaultDoc =
                    Firestore.instance.collection('menu').document();
                    DefaultDoc.setData({
                      'imgurl':
                      'https://image.shutterstock.com/image-vector/no-image-available-icon-template-260nw-1036735678.jpg',
                      'level': int.parse(textEditingController_price.text),
                      'name': textEditingController_name.text,
                      'desc': "",
                      'reviews': review_input,
                      'ingredient': "ll",
                      'recipe': "step1",
                    });
                  }
                })
          ],
          backgroundColor: Colors.amber,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(50.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("TITLE"),
                ],
              ),

              TextField(
                decoration: InputDecoration(
                  hintText: 'FOOD NAME',
                  hintStyle:
                  TextStyle(fontSize: 22, fontStyle: FontStyle.italic),
                  border: InputBorder.none,
                ),
                controller: textEditingController_name,
              ),

              SizedBox(
                height: 10,
              ),
              Row(children: <Widget>[
                Text("INGREDIENT"),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: (){

                  },
                )
              ],),

              new Row(
                children: <Widget>[
                  new Flexible(
                    flex:1,
                    child: new TextField(
                      decoration: InputDecoration(
                          hintText: 'ingredient name',hintStyle: TextStyle(fontStyle: FontStyle.italic) ),
                      controller: textEditingController_ingname,
                    ),),
                  SizedBox(width: 10.0,),
                  new Flexible(
                    flex:1,
                    child: new TextField(
                      decoration: InputDecoration(
                          hintText: 'ingredient weight',hintStyle: TextStyle(fontStyle: FontStyle.italic)),
                      controller: textEditingController_ingweight,
                    ),),

                ],
              ),


              SizedBox(
                height: 15,
              ),
              Row(
                children: <Widget>[
                  Text("DESC"),
                ],
              ),

              TextField(
                decoration: InputDecoration(
                  hintText: 'DESC',
                  hintStyle:
                  TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                  border: InputBorder.none,
                ),
                controller: textEditingController_name,
              ),

              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Text("RECIPE"),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: <Widget>[
                  Text(
                    "STEP1",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              TextField(
                decoration: InputDecoration(
                  hintText: 'STEP1',
                  hintStyle:
                  TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                  border: OutlineInputBorder(),
                ),
                controller: textEditingController_name,
              ),
              SizedBox(
                height: 8,
              ),

              Row(
                children: <Widget>[
                  Text(
                    "STEP2",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              TextField(
                decoration: InputDecoration(
                  hintText: 'STEP2',
                  hintStyle:
                  TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                  border: OutlineInputBorder(),
                ),
                controller: textEditingController_name,
              ),

              SizedBox(
                height: 8,
              ),

              Row(
                children: <Widget>[
                  Text(
                    "STEP3",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              TextField(
                decoration: InputDecoration(
                  hintText: 'STEP3',
                  hintStyle:
                  TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                  border: OutlineInputBorder(),
                ),
                controller: textEditingController_name,
              ),

              SizedBox(
                height: 15.0,
              ),
              FlatButton(
                onPressed: () {
                  createAlertDialog(context);
                },
                child: Text("Ingredient"),
              ),
              _buildBody(),
            ],
          ),
        )

      //Container(),

    );
  }

  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        _image == null
            ? Image.network(
          "https://image.shutterstock.com/image-vector/no-image-available-icon-template-260nw-1036735678.jpg",
          fit: BoxFit.cover,
          width: 200,
          height: 200,
        )
            : Image.file(_image),
        FlatButton(
          onPressed: _getImage,
          child: Icon(Icons.add_a_photo),
        ),
      ],
    );
  }
}