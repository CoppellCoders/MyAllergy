import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:myallergy/add_alergy.dart';
import 'package:myallergy/RaisedGradientButton.dart';


class AllergyList extends StatefulWidget {
  @override
  AllergyListState createState() => new AllergyListState();
}

class AllergyListState extends State<AllergyList> {
  List data;



  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[
      Container(
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10, top: 35),
              child: Text(
                "Allergy List",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 25),
              ),
            ),
            Spacer(),
            IconButton(icon: Icon(Icons.add,color: Colors.white,size: 40,), onPressed: (){
              Navigator.push(context, new MaterialPageRoute(builder: (context) => AddAlergyPage())).then((onValue){
                initState();
              });
            },)
          ],
          crossAxisAlignment: CrossAxisAlignment.stretch,
        ),
        height: MediaQuery
            .of(context)
            .size
            .height * .12,
        decoration: new BoxDecoration(
          gradient: new LinearGradient(colors: [
            Theme
                .of(context)
                .primaryColor,
            Theme
                .of(context)
                .accentColor
          ]),
          borderRadius: new BorderRadius.only(
              bottomRight: Radius.circular(25.0),
              bottomLeft: Radius.circular(25.0)),
        ),
      ),

      Flexible(child:
    ListView.builder(
    itemCount: data == null ? 0 : data.length,
      itemBuilder: (BuildContext context, int index) {
        print(data.length);
        String cur = data[index];
        print(cur);
        return new Container(
            margin: EdgeInsets.only(top: 30,left: 15,right: 15, bottom: 10),
            decoration: new BoxDecoration(
                color: Colors.white,
                boxShadow: [ new BoxShadow(
                  color: Color(0xffE2E2E2),
                  blurRadius: 6,
                  spreadRadius: 1,
                )],
                borderRadius: new BorderRadius.circular(25.0)),
            height: MediaQuery.of(context).size.height * .2,
            width: MediaQuery.of(context).size.width * .9,
            child: Column(
              children: <Widget>[
                new Container(
                    decoration: new BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        boxShadow: [
                          new BoxShadow(
                            color: Color(0xffE2E2E2),
                            blurRadius: 6,
                            spreadRadius: 1,
                          )
                        ],
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
                        IconButton(icon: Icon(Icons.edit,color: Colors.white,), padding: EdgeInsets.all(0),)
                      ],
                    )),
                new Row(children: <Widget>[
                  new Text('Notes: ${cur.substring(cur.indexOf(":")+1)}', textAlign: TextAlign.start,),
                ],),
                new Expanded(
                  flex: 0,
                  child: RaisedGradientButton(
                      width: MediaQuery.of(context).size.width * .3,
                      height: MediaQuery.of(context).size.height * .04,
                      margin: EdgeInsets.only(
                          left: 10, right: 10, top: 20, bottom: 20),
                      child: Text(
                        'Remove',
                        style: TextStyle(color: Colors.white),
                      ),
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xffFFA1A1),
                          Color(0xffFFA1A1)
                        ],
                      ),
                      onPressed: () {
                        data.removeAt(index);
                        String write = "";
                        for(var i = 0; i < data.length; i++){
                          if(i!=data.length-1){
                            write+=data[i]+"\n";
                          }else{
                            write+=data[i]+"";
                          }
                        }
                        print(write);
                        writeCounter(write);
                        setState(() {
                          data = data;
                        });
                      }),
                )
              ],
            ));
      },
    ))
    ],);



  }
  Future<File> writeCounter(String data) async {
    final file = await _localFile;

    // Write the file
    print('Writing File');
    return file.writeAsString('$data', mode: FileMode.write);
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
        data = contents.trim().split("\n");
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
