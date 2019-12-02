import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_project/home.dart';


class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(60, 0, 60, 10),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/master-chef-challenge.appspot.com/o/mcc.png?alt=media&token=05262af8-bfb3-4a2e-a382-e2f489a9a579',
                  height: 250,
                ),
              ],
            ),
            SizedBox(height: 10.0),
            _googleSignInButton(),
          ],
        ),
      ),
    );
  }

  Widget _googleSignInButton() {
    return RaisedButton(
      color: Colors.white,
      splashColor: Colors.white10,
      onPressed: () {
        signInWithGoogle().whenComplete(() {
//          Navigator.of(context).push(
//            MaterialPageRoute(
//              builder: (context) {
//                return HomePage();
//              },
//            ),
//          );
        });
      },
      highlightElevation: 0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'GOOGLE LOGIN',
              style: TextStyle(
                fontSize: 15,
                color: Colors.orangeAccent,
              ),
            ),

          ],
        ),
      ),
    );
  }

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    print("signInWithGoogle succeded:  ${user.uid}");

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('처음이세요?'),
            actions: <Widget>[
              new FlatButton(
                child: new Text('네'),
                onPressed: () {
                  Firestore.instance.collection('users').add({'uid': user.uid.toString(), 'email': user.email.toString(), 'photo': user.photoUrl.toString(), 'nickname': user.uid.toString(), 'level': 1, 'history': [], 'myrecipe': []});
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return HomePage();
                      },
                    ),
                  );
                },
              ),
              new FlatButton(
                child: new Text('아니오'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return HomePage();
                      },
                    ),
                  );
                },
              )
            ],
          );
        });



    return user;
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();

    print("Google User Sign Out");
  }



}