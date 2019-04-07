import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:location/location.dart';




class PollenPage extends StatefulWidget {

  List pollenper = new List();
  String temp,percip,humid;


  final PageController controller = new PageController();






  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return _PollenPage();
  }

}
  class _PollenPage extends State<PollenPage> {

    List pollenperr = new List();
    String tempp,percipp,humidd;
    @override
    initState() {
      super.initState();
      _makeGetRequest();
    }
    _makeGetRequest() async {
      // make request
      Response response = await get(
          'http://35.193.202.40/weather?id=USTX0353');

      // sample info available in response
      int statusCode = response.statusCode;
      Map<String, String> headers = response.headers;
      String contentType = headers['content-type'];
      //String json = response.body;
      //print(json);

      List responseJson = json.decode(response.body);

      for(int x=0; x<responseJson.length;x++){
        if(x<3){
          pollenperr.add(responseJson[x].toString());
        }
        if(x==3){
          humidd = responseJson[x].toString();
        }else if(x==4){
          percipp = responseJson[x].toString();
        }else{
          tempp = responseJson[x].toString();
        }

        setState(() {
          widget.pollenper = pollenperr;
          widget.humid = humidd;
          widget.temp = tempp;
          widget.percip = percipp;
        });
      }

      // TODO convert json to object...

    }
    @override
    Widget build(BuildContext context) {


      // TODO: implement build// TODO: implement build
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
              boxShadow: [
                new BoxShadow(
                  color: Color(0xffE2E2E2),
                  blurRadius: 6,
                  spreadRadius: 1,
                )
              ]),
          width: MediaQuery
              .of(context)
              .size
              .width * .90,
          height: MediaQuery
              .of(context)
              .size
              .height * .08,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.location_on,
                color: Color(0xffCAECD4),
                size: 35,
              ),
              SizedBox(
                width: 10,
              ),
              Center(
                child: Text(
                  "Denton, TX",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10,),
        Expanded(
          child: PageIndicatorContainer(
            pageView: PageView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Center(
                      child: Text(
                        'Tree Pollen',
                        style: TextStyle(fontSize: 30, color: Colors.black45),
                      ),
                    ),
                    Center(
                      child: CircularPercentIndicator(
                        radius: 130.0,
                        lineWidth: 8.0,
                        percent: widget.pollenper.length>0?double.parse(widget.pollenper[0]) :.5,
                        center: Container(
                          padding: EdgeInsets.all(20),
                          child: Image.asset('assests/tree_icon.png'),
                        ),
                        progressColor: Color(0xff76CC90),

                      ),
                    ), SizedBox(height: 5,), Container(
                      width: 120,
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 60,
                            child: Image.asset('assests/grteen_icon.png'),
                          ),
                          SizedBox(height: 10,),
                          Text(widget.pollenper.length>0?((double.parse(widget.pollenper[0])*100).round()).toString()+"%":"50%", style: TextStyle(
                              color: Color(0xff959595), fontSize: 20),),
                          SizedBox(height: 10,)

                        ],
                      ),
                      decoration: BoxDecoration(color: Color(0xffF6F6F6),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            new BoxShadow(
                              color: Color(0xffE2E2E2),
                              blurRadius: 6,
                              spreadRadius: 1,
                            )
                          ]),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Center(
                      child: Text(
                        'Grass Pollen	',
                        style: TextStyle(fontSize: 30, color: Colors.black45),
                      ),
                    ),
                    Center(
                      child: CircularPercentIndicator(
                        radius: 130.0,
                        lineWidth: 8.0,
                        percent: widget.pollenper.length>0?double.parse(widget.pollenper[1]) :.5,
                        center: Container(
                          padding: EdgeInsets.all(20),
                          child: Image.asset('assests/grass_icon.png'),
                        ),
                        progressColor: Color(0xff76CC90),

                      ),
                    ), SizedBox(height: 5,), Container(
                      width: 120,
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 60,
                            child: Image.asset('assests/grteen_icon.png'),
                          ),
                          SizedBox(height: 10,),
                          Text(widget.pollenper.length>0?((double.parse(widget.pollenper[1])*100).round()).toString()+"%":"50%", style: TextStyle(
                              color: Color(0xff959595), fontSize: 20),),
                          SizedBox(height: 10,)

                        ],
                      ),
                      decoration: BoxDecoration(color: Color(0xffF6F6F6),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            new BoxShadow(
                              color: Color(0xffE2E2E2),
                              blurRadius: 6,
                              spreadRadius: 1,
                            )
                          ]),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Center(
                      child: Text(
                        'Ragweed Pollen',
                        style: TextStyle(fontSize: 30, color: Colors.black45),
                      ),
                    ),
                    Center(
                      child: CircularPercentIndicator(
                        radius: 130.0,
                        lineWidth: 8.0,
                        percent: widget.pollenper.length>0?double.parse(widget.pollenper[2]) :.5,
                        center: Container(
                          padding: EdgeInsets.all(20),
                          child: Image.asset('assests/weed_icon.png'),
                        ),
                        progressColor: Color(0xff76CC90),

                      ),
                    ), SizedBox(height: 5,), Container(
                      width: 120,
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 60,
                            child: Image.asset('assests/grteen_icon.png'),
                          ),
                          SizedBox(height: 10,),
                          Text(widget.pollenper.length>0?((double.parse(widget.pollenper[2])*100).round()).toString()+"%":"50%", style: TextStyle(
                              color: Color(0xff959595), fontSize: 20),),
                          SizedBox(height: 10,)

                        ],
                      ),
                      decoration: BoxDecoration(color: Color(0xffF6F6F6),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            new BoxShadow(
                              color: Color(0xffE2E2E2),
                              blurRadius: 6,
                              spreadRadius: 1,
                            )
                          ]),
                    )
                  ],
                ),
              ],
              controller: widget.controller,
            ),
            align: IndicatorAlign.bottom,
            // your indicator align with container
            length: 3,
            // indicator count
            indicatorColor: Colors.grey,
            // unselected indicator color

            indicatorSelectorColor: Theme
                .of(context)
                .primaryColor,
            // selected indicator color
            padding: EdgeInsets.only(bottom: 10.0),
            // padding with bottom .when align top you should use properties `top:10.0`
            size: 15.0,
            // indicator size.
            indicatorSpace: 10.0, // space between circles
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                new BoxShadow(
                  color: Color(0xffE2E2E2),
                  blurRadius: 6,
                  spreadRadius: 1,
                )
              ]),
          child: Column(children: <Widget>[Text(
            'Summary',
            style: TextStyle(fontSize: 25, color: Colors.black45),
          ), SizedBox(height: 5,), Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: 80,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 60,
                      child: Image.asset('assests/weather_icon.png'),
                    ),
                    SizedBox(height: 10,),
                    Text(widget.temp!=null?widget.temp.toString():"50°F",
                      style: TextStyle(
                          color: Color(0xff959595), fontSize: 20),),
                    SizedBox(height: 10,)

                  ],
                ),
                decoration: BoxDecoration(color: Color(0xffF6F6F6),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      new BoxShadow(
                        color: Color(0xffE2E2E2),
                        blurRadius: 6,
                        spreadRadius: 1,
                      )
                    ]),
              ), Container(
                width: 80,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 60,
                      child: Image.asset('assests/water_icon.png'),
                    ),
                    SizedBox(height: 10,),
                    Text(widget.percip!=null?widget.percip.toString():"50%",
                      style: TextStyle(
                          color: Color(0xff959595), fontSize: 20),),
                    SizedBox(height: 10,)

                  ],
                ),
                decoration: BoxDecoration(color: Color(0xffF6F6F6),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      new BoxShadow(
                        color: Color(0xffE2E2E2),
                        blurRadius: 6,
                        spreadRadius: 1,
                      )
                    ]),
              ), Container(
                width: 80,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 60,
                      child: Image.asset('assests/wind_icon.png'),
                    ),
                    SizedBox(height: 10,),
                    Text(widget.humid!=null?widget.humid.toString():"50%",
                      style: TextStyle(
                          color: Color(0xff959595), fontSize: 20),),
                    SizedBox(height: 10,)

                  ],
                ),
                decoration: BoxDecoration(color: Color(0xffF6F6F6),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      new BoxShadow(
                        color: Color(0xffE2E2E2),
                        blurRadius: 6,
                        spreadRadius: 1,
                      )
                    ]),
              )
            ],
          ), SizedBox(height: 15,)
          ]),
        )
      ]);
    }

  }