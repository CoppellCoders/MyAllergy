import 'package:flutter/material.dart';
import 'package:myallergy/RaisedGradientButton.dart';

class Potential extends StatelessWidget {
  Set modell;
  List model;

  Potential(this.modell);



  @override
  Widget build(BuildContext context) {
    model = modell.toList();
    // TODO: implement build
    return new Container(

        margin: EdgeInsets.only(top: 30, left: 15, right: 15),
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
        height: MediaQuery.of(context).size.height * .5,
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
                    return new Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(boxShadow: [
                        new BoxShadow(
                          color: Color(0xffE2E2E2),
                          blurRadius: 6,
                          spreadRadius: 1,
                        )
                      ],borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Text(model[index]),
                    );
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
                onPressed: () {})
            )],
        ));
  }
}
