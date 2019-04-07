import 'package:flutter/material.dart';
import 'package:myallergy/RaisedGradientButton.dart';
import 'package:myallergy/allergy_list.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class AddAlergyPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddAlergyPage();
  }


}


class _AddAlergyPage extends State<AddAlergyPage> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String allergy, description;
  @override
  Widget build(BuildContext context) {
    return
    new Scaffold(
      body: new Center(
          child: new Container(
              margin: EdgeInsets.only(top: 30),
              decoration: new BoxDecoration(
                  color: Colors.white,
                  boxShadow: [new BoxShadow(color: Colors.black)],
                  borderRadius: new BorderRadius.circular(25.0)),
              height: MediaQuery.of(context).size.height * .4,
              width: MediaQuery.of(context).size.width * .9,
              child: new Form(
                key: formKey,
                child: new Column(
                  children: <Widget>[
                    new Expanded(
                      flex: 0,
                      child: new Container(
                          height: MediaQuery.of(context).size.height * .075,
                          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                          decoration: new BoxDecoration(
                              color: new Color(0xFFF9F9F9),
                              shape: BoxShape.rectangle,
                              boxShadow: [new BoxShadow(color: Colors.black)],
                              borderRadius: new BorderRadius.circular(25.0)),
                          child: new TextFormField(
                            textAlign: TextAlign.left,
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Title',
                                contentPadding: EdgeInsets.all(10)),
                            validator: (input) =>
                            (input.length == 0)
                                ? "Please enter allergy"
                                : null,
                            onSaved: (input) => allergy = input,
                          )
                      ),
                    ),
                    new Expanded(
                      child: new Container(
                          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                          height: MediaQuery.of(context).size.height * .25,
                          decoration: new BoxDecoration(
                              color: new Color(0xFFF9F9F9),
                              boxShadow: [ new BoxShadow(
                                color: Color(0xffE2E2E2),
                                blurRadius: 6,
                                spreadRadius: 1,
                              )],
                              borderRadius: new BorderRadius.circular(25.0)),
                          child: new TextFormField(
                            textAlign: TextAlign.left,
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Description',
                                contentPadding: EdgeInsets.all(10)),
                            onSaved: (input) => description = input,
                          )),
                    ),
                    new Expanded(
                      flex: 0,
                      child: RaisedGradientButton(
                          width: MediaQuery.of(context).size.width * .5,
                          height: MediaQuery.of(context).size.height * .075,
                          margin: EdgeInsets.only(
                              left: 10, right: 10, top: 20, bottom: 20),
                          child: Text(
                            'Add Allergy',
                            style: TextStyle(color: Colors.white),
                          ),
                          gradient: LinearGradient(
                            colors: <Color>[
                              Theme.of(context).accentColor,
                              Theme.of(context).primaryColor
                            ],
                          ),
                          onPressed: () {
                            submit(context);
                          }),
                    )
                  ],
                )),



    )));
  }
  void submit(context){
    if(formKey.currentState.validate()){
      formKey.currentState.save();
      writeCounter("$allergy:$description;");


    }
  }
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.txt');
  }
  Future<File> writeCounter(String data) async {
    final file = await _localFile;

    // Write the file
    print('Writing File');
    return file.writeAsString('$data', mode: FileMode.append);
  }

}
