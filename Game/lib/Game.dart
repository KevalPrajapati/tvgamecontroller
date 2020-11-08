import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

String code = "0frrrr";
Firestore _db = Firestore.instance;

class _GameState extends State<Game> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[800],
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('games')
              .where('code', isEqualTo: code)
              .snapshots(),
          builder: (context, snapshot) {
            // print(snapshot.data[0].toString() + ' h e y');
            // print(snapshot.data.documents[0].data['redx']);
            if (snapshot.data == null) {
              print("null");
              return CircularProgressIndicator();
            }
            print("not null");
            return Stack(
              children: [
                AnimatedPositioned(
                  child: Container(
                    color: Colors.red,
                    child: Text(
                      "reds turn",
                    ),
                  ),
                  duration: Duration(seconds: 1),
                  top: 10,
                  left: 1,
                ),
                AnimatedPositioned(
                  child: Container(
                    // color: Colors.red,
                    // child: Text("hey"),
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red),
                  ),
                  duration: Duration(seconds: 1),
                  top: snapshot.data.documents[0].data['redy'],
                  left: snapshot.data.documents[0].data['redx'],
                ),
                AnimatedPositioned(
                  child: Container(
                      // color: Colors.blue
                      // child: Text("hey"),
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.blue)),
                  duration: Duration(seconds: 1),
                  top: snapshot.data.documents[0].data['bluey'],
                  left: snapshot.data.documents[0].data['bluex'],
                ),
                AnimatedPositioned(
                  child: Container(
                      // color: Colors.white,
                      // child: Text("hey"),
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.yellow)),
                  duration: Duration(seconds: 1),
                  top: snapshot.data.documents[0].data['yellowy'],
                  left: snapshot.data.documents[0].data['yellowx'],
                ),
                AnimatedPositioned(
                    duration: Duration(seconds: 1),
                    top: 10,
                    right: 20,
                    child: IconButton(
                      icon: Icon(
                        Icons.mic,
                        size: 50,
                      ),
                      onPressed: () {
                        final snackBar =
                            SnackBar(content: Text('Coming soon   ;)'));
                        _scaffoldKey.currentState.showSnackBar(snackBar);
                      },
                    ))
              ],
            );
          }),
    );
  }
}
