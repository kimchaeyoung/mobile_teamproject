import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:carousel_slider/carousel_slider.dart';



class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}


class _MyPageState extends State<MyPage> {

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  String email = "";
  String photo = "";

  Future<FirebaseUser> getFirebaseUser() async{
    FirebaseUser user = await firebaseAuth.currentUser();

    setState(() {
      email = user.email.toString();
      photo = user.photoUrl.toString();
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
                  padding: EdgeInsets.fromLTRB(16.0, 110.0, 16.0, 8.0),
                  child: Text('Master Chef Challenge', style: Theme.of(context).textTheme.headline.copyWith(color: Colors.white)),
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
                    Navigator.pushNamed(context, '/');
                  },
                ),
                ListTile(
                  title: Text('Setting',
                    style: Theme.of(context).textTheme.title.copyWith(color: Colors.black26),
                  ),
                  leading: Icon(Icons.settings, color: Colors.amber),
                  onTap: () {
                    Navigator.pushNamed(context, '/');
                  },
                ),
                ListTile(
                  title: Text('Logout',
                    style: Theme.of(context).textTheme.title.copyWith(color: Colors.black26),
                  ),
                  leading: Icon(Icons.power_settings_new, color: Colors.amber),
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                ),
              ]
          )
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
          children: <Widget>[
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 100,
                  child: Image.network(photo, fit: BoxFit.cover),
                ),
                SizedBox(width: 20),
                Text(email),
              ],
            ),

            SizedBox(height: 40),

            Divider(),

          SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    color: Colors.amber,
                    splashColor: Colors.amberAccent,
                    onPressed: () {


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
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              color: Colors.amber,
              splashColor: Colors.amberAccent,
              onPressed: () {


              },
              highlightElevation: 0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child:
                Text(
                  'Setting',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }


}

