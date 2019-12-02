import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_project/step1.dart';
import 'package:team_project/mypage.dart';
import 'package:team_project/list.dart';

bool flag = true;

class MyRecipePage extends StatefulWidget {

  final List<dynamic> myrecipe;

  MyRecipePage({Key key, @required this.myrecipe}):super(key:key);

  @override
  _MyRecipePageState createState() {
    return _MyRecipePageState();
  }
}

class _MyRecipePageState extends State<MyRecipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Master Chef Challenge'),
        backgroundColor: Colors.amber,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('menu').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Card(
          child: Column(
            children: <Widget> [
              Image.network(
                record.imgurl,
                width: 600,
                height: 200,
                fit: BoxFit.cover,
              ),
              Container(
                padding: const EdgeInsets.all(32),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child:
                            Row(
                              children: <Widget>[
                                Text(
                                  record.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(flag? (Icons.keyboard_arrow_down) : (Icons.keyboard_arrow_up)),
                                  onPressed: () {
                                    setState(() {
                                      flag = !flag;
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                          Container(
                            child:
                            Row(
                              children: <Widget>[
                                Text(
                                  record.name,
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                  ),
                                ),
                                FlatButton(
                                    child: Text("Start"),
                                    onPressed: () {
                                      Navigator.push(
                                          context, MaterialPageRoute(
                                        builder: (context) =>
                                            Step1Page(detail: record),
                                      )
                                      );
                                    }
                                )
                              ],
                            ),
                          ),
                          flag ? Column()
                              : Column(
                            children: <Widget>[
                              Divider(),
                              Text("Reviews"),
                              Text(record.reviews[0]['review'].toString())
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}