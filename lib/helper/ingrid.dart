import 'package:flutter/material.dart';

class Ingrid extends StatelessWidget{
  List<String> model;

  Ingrid(this.model);

  @override
  Widget build(BuildContext context) {
    print(model);
    // TODO: implement build
    return Expanded(flex: 1,child:ListView.builder(
        itemCount:model.length,
        itemBuilder: (BuildContext context, int indexx) {
          return Container(
            height: 30,
            margin: EdgeInsets.only(right: 10,left: 10,top: 5),
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(50)),boxShadow:  [new BoxShadow(
              color: Color(0xffE2E2E2),
              blurRadius: 6,
              spreadRadius: 1,
            )]),
              child: Row(
                children: <Widget>[
                  Text("  "+(indexx + 1).toString()),
                  SizedBox(width: 15,),
                  Text(model[indexx]),
                  Spacer(),
                  Container(margin:EdgeInsets.only(right: 10),child:
                  Image.asset('assests/good.png'),),

                  SizedBox(height: 10)
                ],
              ));
        }));
    }

}