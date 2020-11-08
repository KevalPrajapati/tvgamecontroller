import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateGame extends StatefulWidget {
  @override
  _CreateGameState createState() => _CreateGameState();
}

String code;

class _CreateGameState extends State<CreateGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Center(
        child: TextField(
          onChanged: (val) {
            code = val;
          },
          onSubmitted: (val) {
            print(code);
            Firestore.instance.collection("games").document(code).setData({
              // "photourl": user.photoUrl,
              "code": code,
              "redtaken": false,
              "yellowtaken": false,
              "bluetaken": false,
              "redx": 50,
              "redy": 50,
              "yellowx": 20,
              'yellowy': 20,
              "bluex": 230,
              "bluey": 20
            });
            // assert(user != null);
            // assert(
          },
        ),
      ),
    );
  }
}
