import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'utils/utils.dart' as Utils;

import 'screen/home_screen.dart' as Home;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return MaterialApp(
      title: Utils.APP_NAME,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Colors.pink,
        primaryColor: Color.fromRGBO(0, 188, 212, 1),
        primaryColorDark: Color.fromRGBO(224, 64, 251, 1),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home.Screen(),
    );
  }
}
