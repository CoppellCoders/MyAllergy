import 'package:flutter/material.dart';
import 'package:myallergy/AllergyHistoryModel.dart';
import 'package:myallergy/RaisedGradientButton.dart';
import 'package:myallergy/helper/ingrid.dart';
import 'package:myallergy/helper/potential_aller.dart';

class History extends StatelessWidget {
  List<AllergyHistoryModel> model;

  History(this.model);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10, top: 35),
                child: Text(
                  "Allergy History",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 25),
                ),
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.stretch,
          ),
          height: MediaQuery.of(context).size.height * .12,
          decoration: new BoxDecoration(
            gradient: new LinearGradient(colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).accentColor
            ]),
            borderRadius: new BorderRadius.only(
                bottomRight: Radius.circular(25.0),
                bottomLeft: Radius.circular(25.0)),
          ),
        ),
        Expanded(
            child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            print(model[index].getFood());
            return new Container(
                margin: EdgeInsets.only(top: 5, left: 15, right: 15),
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
                            boxShadow: [
                              new BoxShadow(
                                color: Colors.white,
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
                              model[index].food,
                              textAlign: TextAlign.left,
                              style: new TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                            Spacer(),
                            Text(
                              model[index].date,
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        )),
                    Container(
                      child: Column(
                        children: <Widget>[],
                      ),
                      decoration:
                          BoxDecoration(color: Color(0xffEFEFEF), boxShadow: [
                        new BoxShadow(
                          color: Color(0xffE2E2E2),
                          blurRadius: 6,
                          spreadRadius: 1,
                        )
                      ]),
                    ),
                    Container(
                      child: Ingrid(model[index].getIngrid()),
                    ),
                    SizedBox(height: 10,),
                    new Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        new Text(
                          'Notes: ' + model[index].note,
                          textAlign: TextAlign.start,
                        ),SizedBox(height: 40,),
                      ],
                    ),
                  ],
                ));
          },
          itemCount: model.length,
        )),
        Potential({"Milk","Soy","Wheat"})
      ],
    );
  }
}
