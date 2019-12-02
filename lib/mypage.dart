import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:team_project/history.dart';
import 'package:team_project/myrecipe.dart';



class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}


class _MyPageState extends State<MyPage> {

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final CollectionReference ref = Firestore.instance.collection('users');
  TextEditingController _textFieldController = TextEditingController();

  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  String email = "";
  String photo = "";
  String uid = "";
  String docId = "";

  var user;

  Future<FirebaseUser> getFirebaseUser() async{
    FirebaseUser user = await firebaseAuth.currentUser();

    setState(() {
      email = user.email.toString();
      photo = user.photoUrl.toString();
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
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            semanticLabel: 'menu',
          ),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
        title: Text('My Page'),
      ),
      drawer: Drawer(
          child: ListView(
              children: <Widget>[
                DrawerHeader(
                  //padding: EdgeInsets.fromLTRB(16.0, 110.0, 16.0, 8.0),
                  child: Image.network('https://firebasestorage.googleapis.com/v0/b/master-chef-challenge.appspot.com/o/mcc.png?alt=media&token=05262af8-bfb3-4a2e-a382-e2f489a9a579'),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                  ),
                ),
                ListTile(
                  title: Text('Home',
                    style: Theme.of(context).textTheme.title.copyWith(color: Colors.amber),
                  ),
                  leading: Icon(Icons.home, color: Colors.amber),
                  onTap: () {
                    Navigator.pushNamed(context, '/');
                  },
                ),
                ListTile(
                  title: Text('Start Game',
                    style: Theme.of(context).textTheme.title.copyWith(color: Colors.black26),
                  ),
                  leading: Icon(Icons.local_dining, color: Colors.amber),
                  onTap: () {
                    Navigator.pushNamed(context, '/listrecipe');
                  },
                ),
                ListTile(
                  title: Text('Create Game',
                    style: Theme.of(context).textTheme.title.copyWith(color: Colors.black26),
                  ),
                  leading: Icon(Icons.games, color: Colors.amber),
                  onTap: () {
                    Navigator.pushNamed(context, '/createpage');
                  },
                ),
                ListTile(
                  title: Text('Logout',
                    style: Theme.of(context).textTheme.title.copyWith(color: Colors.black26),
                  ),
                  leading: Icon(Icons.power_settings_new, color: Colors.amber),
                  onTap: () {
                    signOutGoogle();
                    Navigator.pushNamed(context, '/login');
                  },
                ),
              ]
          )
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            snapshot.data.documents.forEach((DocumentSnapshot snap){
              if(snap['uid'] == uid){
                docId = snap.documentID;
                print(docId);
                user = User.fromSnapshot(snap);
              }
            });
            return Center(
              child: ListView(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                children: <Widget>[
                  SizedBox(height: 40),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 100,
                        child: Image.network(user.photo, fit: BoxFit.cover),
                      ),
                      SizedBox(height: 20),
                      Text(user.nickname),
                      Text('Lv. ' + user.level.toString()),
                    ],
                  ),

                  SizedBox(height: 30),

                  Divider(),

                  SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Colors.amber,
                          splashColor: Colors.amberAccent,
                          onPressed: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => MyRecipePage(myrecipe: user.myrecipe))
                            );
                          },
                          highlightElevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.local_dining,
                                  size: 50,
                                  color: Colors.white,
                                ),
                                Text(
                                  'My Recipe',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child:
                        RaisedButton(
                          color: Colors.amber,
                          splashColor: Colors.amberAccent,
                          onPressed: () {
                            Navigator.push(
                              context, MaterialPageRoute(builder: (context) => HistoryPage(history: user.history))
                            );
                          },
                          highlightElevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.access_alarm,
                                  size: 50,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Game History',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    color: Colors.amber,
                    splashColor: Colors.amberAccent,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('변경할 닉네임을 입력'),
                              content: TextField(
                                controller: _textFieldController,
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: new Text('변경'),
                                  onPressed: () {
                                    user.reference.updateData({'nickname': _textFieldController.text});
                                    _textFieldController.clear();
                                    Navigator.of(context).pop();
                                  },
                                ),
                                FlatButton(
                                  child: new Text('취소'),
                                  onPressed: () {
                                    _textFieldController.clear();
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          });
                    },
                    highlightElevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child:
                      Text(
                        'Change Nickname',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    color: Colors.amber,
                    splashColor: Colors.amberAccent,
                    onPressed: () {
                      signOutGoogle();
                      Navigator.pushNamed(context, '/login');
                    },
                    highlightElevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child:
                      Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();

    print("Google User Sign Out");
  }


}

class User {
  final String uid;
  final String nickname;
  final String photo;
  final int level;
  final List<dynamic> history;
  final List<dynamic> myrecipe;
  final DocumentReference reference;

  User.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['uid'] != null),
        uid = map['uid'],
        nickname = map['nickname'],
        photo = map['photo'],
        level = map['level'],
        history = map['history'],
        myrecipe = map['myrecipe'];

  User.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$uid$nickname$level$history$myrecipe>";
}