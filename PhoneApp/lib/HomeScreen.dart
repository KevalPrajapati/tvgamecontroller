import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  String code;
  String color;
  HomeScreen({this.code, this.color});

  @override
  HomeScreenState createState() => HomeScreenState(code, color);
}

CollectionReference games = Firestore.instance.collection('games');
var gamesref;
bool gameavail = false;

final Firestore _db = Firestore.instance;
Stream values;
String docid;
double verticlespeed = 50.2;
double horizontalspeed = 30.2;

class HomeScreenState extends State<HomeScreen> {
  String code;
  String color;
  HomeScreenState(this.code, this.color);

  String text = "hello";

  List<DocumentSnapshot> posts;
  // docid=code;

  getgamesdata() async {
    QuerySnapshot snap = await _db
        .collection("games")
        .where("code", isEqualTo: code)
        .getDocuments();
    posts = snap.documents;
    print(posts[0].data['inuse']);
    gameavail = posts[0].data['inuse'];
    print(posts);

    List<String> productName = [];

    Stream<QuerySnapshot> productRef = Firestore.instance
        .collection("games")
        .where("code", isEqualTo: code)
        .snapshots();
    productRef.forEach((field) {
      field.documents.asMap().forEach((index, data) {
        print(data['redx']);
        docid = data.documentID;
      });
    });

    values = _db.collection('games').where("code", isEqualTo: code).snapshots();
    // sumStream(values);
    values.listen((event) {
      print(event.toString());
    });
  }

  Future<bool> sumStream(var values) async {
    // var sum = 0;
    await for (var value in values) {
      print(values[0].data['redx']);
    }
    // return sum;
  }
  // @override
  // void initState() {
  //   super.initState();
  //   // Firebase.initializeApp();
  //   setState(() {});
  // }s
  // final myStream = gameavail.stream.asBroadcastStream;
  // final subscription = myStream.listen(

  // (data)=>print('bool $data'),
  // )
  String colorx;
  String colory;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    colorx = color + 'x';
    colory = color + 'y';
    print("code of the game is" + "  $code");
    getgamesdata();
  }

  @override
  Widget build(BuildContext context) {
    // Firebase.initializeApp();
    return Scaffold(
      backgroundColor: Colors.grey[800],
      // appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          // height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              // Text(""),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 2 - 100),
                      // padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Listener(
                            onPointerDown: (details) {
                              _buttonPressed = true;
                              Wpressed();
                            },
                            onPointerUp: (details) {
                              _buttonPressed = false;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.orange, border: Border.all()),
                              padding: EdgeInsets.all(16.0),
                              child: Icon(
                                Icons.arrow_upward,
                                size: 100,
                              ),
                            ),
                          ),
                          Listener(
                            onPointerDown: (details) {
                              _buttonPressed = true;
                              Spressed();
                            },
                            onPointerUp: (details) {
                              _buttonPressed = false;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.orange, border: Border.all()),
                              padding: EdgeInsets.all(16.0),
                              child: Icon(
                                Icons.arrow_downward,
                                size: 100,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 10),
                      child: Row(
                        children: [
                          Listener(
                            onPointerDown: (details) {
                              _buttonPressed = true;
                              Apressed();
                            },
                            onPointerUp: (details) {
                              _buttonPressed = false;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.orange, border: Border.all()),
                              padding: EdgeInsets.all(16.0),
                              child: Icon(
                                Icons.arrow_left,
                                size: 100,
                              ),
                            ),
                          ),
                          Listener(
                            onPointerDown: (details) {
                              _buttonPressed = true;
                              Dpressed();
                            },
                            onPointerUp: (details) {
                              _buttonPressed = false;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.orange, border: Border.all()),
                              padding: EdgeInsets.all(16.0),
                              child: Icon(
                                Icons.arrow_right,
                                size: 100,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  joingame() {}

  void Dpressed() async {
    String colorx = color + "x";
    // String colory = color + "y";
    // make sure that only one loop is active
    if (_loopActive) return;

    _loopActive = true;

    while (_buttonPressed) {
      // do your thing
      var ref = _db.collection('games').document(code);
      await ref.updateData(<String, dynamic>{
        colorx: FieldValue.increment(horizontalspeed),
      });
      // wait a bit
      await Future.delayed(Duration(milliseconds: 200));
    }

    _loopActive = false;
  }

  void Apressed() async {
    // make sure that only one loop is active
    if (_loopActive) return;

    // String colory = color + "y";

    _loopActive = true;

    while (_buttonPressed) {
      // do your thing
      var ref = _db.collection('games').document(code);
      await ref.updateData(<String, dynamic>{
        colorx: FieldValue.increment(-horizontalspeed),
      });
      // wait a bit
      await Future.delayed(Duration(milliseconds: 200));
    }

    _loopActive = false;
  }

  void Wpressed() async {
    // String colorx = color + "x";
    String colory = color + "y";
    // make sure that only one loop is active
    if (_loopActive) return;

    _loopActive = true;

    while (_buttonPressed) {
      // do your thing
      var ref = _db.collection('games').document(code);
      await ref.updateData(<String, dynamic>{
        colory: FieldValue.increment(-verticlespeed),
      });
      // wait a bit
      await Future.delayed(Duration(milliseconds: 200));
    }

    _loopActive = false;
  }

  void Spressed() async {
    // String colorx = color + "x";
    String colory = color + "y";
    // make sure that only one loop is active
    if (_loopActive) return;

    _loopActive = true;

    while (_buttonPressed) {
      // do your thing
      var ref = _db.collection('games').document(code);
      await ref.updateData(<String, dynamic>{
        colory: FieldValue.increment(verticlespeed),
      });
      // wait a bit
      await Future.delayed(Duration(milliseconds: 200));
    }

    _loopActive = false;
  }
}

bool _loopActive = false;
bool _buttonPressed = false;
