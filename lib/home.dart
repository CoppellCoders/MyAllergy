import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10, top: 35),
                child: Text(
                  "Allergy Tracker",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 25),
                ),
              )
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
        SizedBox(height: 20),
        Container(
          decoration: new BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
              boxShadow: [new BoxShadow(color: Color(0xffE2E2E2),
                  blurRadius: 6,
                  spreadRadius: 1,)
              ]),
          width: MediaQuery
              .of(context)
              .size
              .width * .90,
          height: MediaQuery
              .of(context)
              .size
              .height * .06,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(width: 10,),
              Icon(
                Icons.location_on,
                color: Color(0xffCAECD4),
              )
            ],
          ),
        )
      ]
    );
  }
}
