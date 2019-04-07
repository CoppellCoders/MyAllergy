import 'package:flutter/material.dart';
import 'package:myallergy/add_alergy.dart';
import 'package:myallergy/allergy_list.dart';
import 'package:myallergy/Pollen.dart';
import 'package:myallergy/scan.dart';
class Hold extends StatefulWidget {
  @override
  HoldState createState() {
    return new HoldState();
  }
}

class HoldState extends State<Hold> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: new BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (newIndex) => setState(() {
              _currentIndex = newIndex;
            }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            title: Text('History'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Profile')),
          BottomNavigationBarItem(
              icon: Icon(Icons.cloud), title: Text('Pollen'))
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        //has to be in order
        children: <Widget>[
          PollenPage(),
          PollenPage(),
          AllergyList(),
          ScanPage(),
        ],
      ),
    );
  }
}
