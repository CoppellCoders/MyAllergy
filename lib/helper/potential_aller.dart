import 'package:flutter/material.dart';
import 'package:myallergy/RaisedGradientButton.dart';

class Potential extends StatelessWidget {
  Set modell;
  List model;

  Potential(this.modell);



  @override
  Widget build(BuildContext context) {

    model = modell.toList();

    void createSnackBar(String message) {
      final snackBar = new SnackBar(content: new Text(message),duration: Duration(seconds: 1,milliseconds: 900),
          backgroundColor: Colors.green);

      // Find the Scaffold in the Widget tree and use it to show a SnackBar!
      Scaffold.of(context).showSnackBar(snackBar);
    }


  void _showDialog() {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Send to Doctor?"),
            content: new Text("This will send a notification to your doctor about your allergies"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),  new FlatButton(
                child: new Text("Send"),
                onPressed: () {
                  createSnackBar("Sucessfully sent report to doctor");
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    // TODO: implement build
    return new Container(

        margin: EdgeInsets.only(top: 10, left: 15, right: 15),
        decoration: new BoxDecoration(
            color: Colors.white,
            boxShadow: [
              new BoxShadow(
                color: Color(0xffE2E2E2),
                blurRadius: 6,
                spreadRadius: 1,
              )
            ],
            borderRadius: new BorderRadius.circular(25.0)),
        height: MediaQuery.of(context).size.height * .3,
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
                      "Potential Allergic Ingredients ",
                      textAlign: TextAlign.left,
                      style: new TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ],
                )),
            Expanded(
              child: ListView.builder(
                  itemCount: model.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        height: 30,
                        margin: EdgeInsets.only(right: 10,left: 10),
                        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(50)),boxShadow:  [new BoxShadow(
                          color: Color(0xffE2E2E2),
                          blurRadius: 6,
                          spreadRadius: 1,
                        )]),
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 10,),
                            Text(model[index]),
                            Spacer(),
                            Container(margin:EdgeInsets.only(right: 10),child:
                            Image.asset('assests/bad.png'),),

                            SizedBox(height: 10)
                          ],
                        ));
                  }),
            ),     Container(child:
            RaisedGradientButton(
                width: MediaQuery.of(context).size.width * .5,
                height: MediaQuery.of(context).size.height * .04,
                margin: EdgeInsets.only(
                    left: 10, right: 10, top: 20, bottom: 20),
                child: Text(
                  'Send report to Doctor',
                  style: TextStyle(color: Colors.white),
                ),
                gradient: LinearGradient(
                  colors: <Color>[
                    Theme.of(context).primaryColor,
    Theme.of(context).accentColor
                  ],
                ),
                onPressed: () {_showDialog();})
            )],
        ));


  }



}
