import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_project/step1.dart';
import 'package:team_project/choice.dart';

bool flag = true;

class ListRecipe extends StatefulWidget {
  @override
  _ListPageState createState() {
    return _ListPageState();
  }
}

class _ListPageState extends State<ListRecipe> {
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
      child: Hero(
        tag: record.name,
        child: new InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ChoicePage(detail: record);
            }));
          },
          child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Card(
                child: Column(
                  children: <Widget>[
                    Image.network(
                      record.imgurl,
                      width: 600,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      padding: const EdgeInsets.all(32),
                      child: Row(children: <Widget>[
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                drawStars(record.level),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        record.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Container(
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Icon(Icons.timer, color: Colors.grey[500],
                                            ),
                                            Text(
                                              " " + record.total_time.toString() + " 분",
                                              style: TextStyle(
                                                  color: Colors.grey[500]),
                                            )
                                          ],
                                        )
                                      ],
                                    )),

                              ]),
                        ),
                      ]),
                    )
                  ],
                ),
              )),
        )),
    );
  }
}

Widget drawStars(int i){
  if(i == 3){
    return Row(
      children: <Widget>[
        Icon(Icons.star, color: Colors.yellow, size: 20,),
        Icon(Icons.star, color: Colors.yellow, size: 20,),
        Icon(Icons.star, color: Colors.yellow, size: 20,),
      ],
    );
  }
  else if(i == 2){
    return Row(
      children: <Widget>[
        Icon(Icons.star, color: Colors.yellow, size: 20,),
        Icon(Icons.star, color: Colors.yellow, size: 20,),
      ],
    );
  }
  else {
    return Row(
      children: <Widget>[
        Icon(Icons.star, color: Colors.yellow, size: 20,),
      ],
    );
  }
}

class Record {
  final String id;
  final String name;
  final String imgurl;
  final String creator;
  final int level;
  final int total_time;
  final Map<dynamic, dynamic> review;
  final List<dynamic> ingredient;
  final List<dynamic> recipe;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : id = map['id'],
        name = map['name'],
        imgurl = map['imgurl'],
        total_time = map['total_time'],
        creator = map['creator'],
        level = map['level'],
        review = map['review'],
        ingredient = map['ingredient'],
        recipe = map['recipe'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$id$name$imgurl$total_time$creator$level$review$ingredient$recipe>";
}