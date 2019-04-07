import 'package:flutter/material.dart';
import 'package:myallergy/AllergyHistoryModel.dart';
import 'package:myallergy/add_alergy.dart';
import 'package:myallergy/allergy_his.dart';
import 'package:myallergy/allergy_list.dart';
import 'package:myallergy/Pollen.dart';
import 'package:myallergy/scan.dart';
class Hold extends StatefulWidget {
  List<AllergyHistoryModel> model = new List();

  List<String> food = new List();
  List<bool> fooda = new List();
  @override
  HoldState createState() {
    food.add("Durum Semolia");
    food.add("Niacin");


    fooda.add(false);
    fooda.add(true);
    model.add(new AllergyHistoryModel("Spaghetti",food ,fooda  , "Received rashes on arm","Apr 6 2018"));
    model.add(new AllergyHistoryModel("Coca-Cola",food ,fooda  , "Body felt tingily","Apr 7 2018"));
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
          History(widget.model),
          AllergyList(),
          ScanPage(),
        ],
      ),
    );
  }
}


