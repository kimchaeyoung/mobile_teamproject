import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import 'package:team_project/list.dart';
import 'package:team_project/step1.dart';
import 'package:team_project/viewModel.dart';

int i = 0;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final _searchController = TextEditingController();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Record> recipes;



  @override
  Widget build(BuildContext context) {

    final recipeProvider = Provider.of<ViewModel>(context);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
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
        title: Text('Master Chef Challenge'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.person,
              semanticLabel: 'mypage',
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/mypage');
            },
          ),
        ],
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
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            Text('Weekly Challenge', style: TextStyle(fontSize: 25.0)),
            SizedBox(height: 10),

            Expanded(
              child: StreamBuilder(
                  stream: Firestore.instance.collection('menu').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return _buildSlider(context, snapshot.data.documents);
                    }
                    else {
                      return LinearProgressIndicator();
                    }
                  }
              ),
            ),
            Expanded(
              child: ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    color: Colors.amber,
                    splashColor: Colors.amberAccent,
                    child: Padding(
                      padding: EdgeInsets.all(0),
                      child: Text('LOW'),
                    ),
                    onPressed:(){
                      Navigator.pushNamed(context, '/low');
                    },
                  ),
                  FlatButton(
                    color: Colors.amber,
                    splashColor: Colors.amberAccent,
                    child: Padding(
                      padding: EdgeInsets.all(0),
                      child: Text('MID'),
                    ),
                    onPressed:(){
                      Navigator.pushNamed(context, '/mid');
                    },
                  ),
                  FlatButton(
                    color: Colors.amber,
                    splashColor: Colors.amberAccent,
                    child: Padding(
                      padding: EdgeInsets.all(0),
                      child: Text('HIGH'),
                    ),
                    onPressed:(){
                      Navigator.pushNamed(context, '/high');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }

  Widget _buildSlider(BuildContext context, List<DocumentSnapshot> snapshot) {
    recipes = snapshot.map((doc) => Record.fromSnapshot(doc)).toList();
    return CarouselSlider(
      height: 300,
      items: recipes.map((index) {
        return Builder(
          builder: (BuildContext context){
            return GestureDetector(
              child: Stack(
                children: <Widget>[
                  SizedBox(
                    height: 300,
                    child: Image.network(
                      index.imgurl,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                    child: Stack(
                      children: <Widget>[
                        Text(
                            index.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 2
                                  ..color = Colors.white
                            )
                        ),
                        Text(
                            index.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            )
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              onTap: (){
                Navigator.push(
                    context, MaterialPageRoute(
                  builder: (context) =>
                      Step1Page(detail: index),
                )
                );
              },
            );
          }
        );
      }).toList(),

    );
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();

    print("Google User Sign Out");
  }

}