import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:host/CreateGame.dart';
import 'package:host/JoinGame.dart';

import 'HomeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft]);
 
  await SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: Shortcuts(shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.select): ActivateIntent(),
      }, child: JoinGame()),
    );
  }
}
