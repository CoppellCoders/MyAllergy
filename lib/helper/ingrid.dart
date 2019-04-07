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
              child: Row(
                children: <Widget>[
                  Text((indexx + 1).toString()),
                  Text(model[indexx])
                ],
              ));
        }));
    }

}