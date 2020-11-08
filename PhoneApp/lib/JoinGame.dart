import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:host/HomeScreen.dart';

class JoinGame extends StatefulWidget {
  @override
  _JoinGameState createState() => _JoinGameState();
}

String code;
String colorselected = 'choose a color';

class _JoinGameState extends State<JoinGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              onChanged: (val) {
                code = val;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(
                  color: Colors.redAccent,
                  onPressed: () {
                    setState(() {
                      colorselected = "red";
                    });
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    // color: Colors.red,
                    // child: Text("red"),
                  ),
                ),
                RaisedButton(
                  color: Colors.blueAccent,
                  onPressed: () {
                    setState(() {
                      colorselected = "blue";
                    });
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    // color: Colors.red,
                    // child: Text("red"),
                  ),
                ),
                RaisedButton(
                  color: Colors.yellow,
                  onPressed: () {
                    setState(() {
                      colorselected = "yellow";
                    });
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    // color: Colors.red,
                    // child: Text("red"),
                  ),
                ),
                // RaisedButton(
                //   color: Colors.redAccent,
                //   onPressed: () {},
                //   child: Container(
                //     height: 100,
                //     width: 100,
                //     // color: Colors.red,
                //     // child: Text("red"),
                //   ),
                // ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  colorselected,
                  style: TextStyle(color: Colors.white, fontSize: 50),
                ),
                RaisedButton(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100,
                    ),
                    onPressed: () async {
                      print(code);
                      await Firestore.instance
                          .collection("games")
                          .document(code)
                          // .where("code", isEqualTo: code).
                          // .getDocuments()
                          .updateData({
                        // "photourl": user.photoUrl,

                        'redtaken': colorselected == "red" ? true : false,
                        'yellowtaken': colorselected == "yellow" ? true : false,
                        'bluetaken': colorselected == "blue" ? true : false,
                      });

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen(
                                    code: code,
                                    color: colorselected,
                                  )));
                    }),
              ],
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      ),
    );
  }
}
