import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
            title: Text('Master Chef', style: TextStyle(color: Colors.black),),
            backgroundColor: Colors.yellow
        ),
        body: Center(
            child: IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () =>
                  Navigator.pushNamed(context, '/listrecipe'),
            )
        ),
      ),
    );
  }
}

