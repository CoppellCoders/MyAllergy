import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:myallergy/add_alergy.dart';

class AllergyList extends StatefulWidget {
  @override
  AllergyListState createState() => new AllergyListState();
}

class AllergyListState extends State<AllergyList> {
  List data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (BuildContext context, int index) {
        print(data.length);
        String cur = data[index];
        print(cur);
        return new Container(
            margin: EdgeInsets.only(top: 30),
            decoration: new BoxDecoration(
                color: Colors.white,
                boxShadow: [new BoxShadow(color: Colors.black)],
                borderRadius: new BorderRadius.circular(25.0)),
            height: MediaQuery.of(context).size.height * .2,
            width: MediaQuery.of(context).size.width * .9,
            child: Column(
              children: <Widget>[
                new Container(
                    decoration: new BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        boxShadow: [new BoxShadow(color: Colors.black)],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0))),
                    height: MediaQuery.of(context).size.height * .07,
                    width: MediaQuery.of(context).size.width * 1,
                    padding: EdgeInsets.all(10.0),
                    child: new Row(
                      children: <Widget>[
                        new Text(
                          cur.substring(0, cur.indexOf(":")),
                          textAlign: TextAlign.left,
                          style: new TextStyle(
                              color: Colors.white, fontSize: 20.0),
                        ),
                        Spacer(),
                        IconButton(icon: Icon(Icons.add), padding: EdgeInsets.all(0),)
                      ],
                    )),
              ],
            ));
      },
    );
  }

  @override
  void initState() {
    print('Init state called');
    readCounter();
  }

  Future<int> readCounter() async {
    print('Counter being called');
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();
      print('data '+ contents);
      this.setState(() {
        data = contents.split(";");
      });
      print(data);
    } catch (e) {
      print(e);
      // If encountering an error, return 0
      return 0;
    }
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.txt');
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
}
