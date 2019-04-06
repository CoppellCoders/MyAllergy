import 'package:flutter/material.dart';
import 'package:myallergy/holder.dart';
import 'package:myallergy/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primaryColor: Color(0xff00A473),
        accentColor: Color(0xff00E7B0),

        primarySwatch: Colors.green,
      ),
      home: Hold(),

    );
  }
}

