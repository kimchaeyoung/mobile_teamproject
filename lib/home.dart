import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import 'package:team_project/recipe.dart';
import 'package:team_project/viewModel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  final _searchController = TextEditingController();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Recipe> recipes;

  @override
  Widget build(BuildContext context) {

    final recipeProvider = Provider.of<ViewModel>(context);
    int i = 0;

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
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.search),
                  SizedBox(width: 20.0),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'Search',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Text('Weekly Challenge', style: TextStyle(fontSize: 25.0)),
            SizedBox(height: 10),

            Expanded(
              child: StreamBuilder(
                  stream: recipeProvider.fetchRecipesAsStream(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      recipes = snapshot.data.documents.map((doc) => Recipe.fromMap(doc.data, doc.documentID)).toList();
                      return
                        new CarouselSlider(
                          height: 200,
                          items: recipes.map((index) {
                            if(i == recipes.length - 1){
                              i = 0;
                            }
                            else{
                              i++;
                            }
                            return Container(
                              child: Stack(
                                children: <Widget>[
                                  SizedBox(
                                    height: 200,
                                    child: Image.network(
                                      recipes[i].imgurl,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                                    child: Stack(
                                      children: <Widget>[
                                        Text(
                                            recipes[i].name,
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
                                            recipes[i].name,
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
                            );
                          }).toList(),

                        );
                    }
                    else {
                      return Text('fetching');
                    }
                  }
              ),
            ),

//        CarouselSlider(
//          height: 200.0,
//          items: recipes.map((i) {
//
//          }).toList(),
//        ),
            SizedBox(
              height: 20,
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

}