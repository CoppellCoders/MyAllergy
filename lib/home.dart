import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PageController controller = new PageController();

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
        width: MediaQuery.of(context).size.width * .90,
        height: MediaQuery.of(context).size.height * .08,
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
                      percent: .50,
                      center: Container(
                        padding: EdgeInsets.all(20),
                        child: Image.asset('assets/tree_icon.png'),
                      ),
                      progressColor: Color(0xff76CC90),

                    ),
                  ), SizedBox(height: 5,),Container(
                    width: 120,
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 60,
                          child: Image.asset('assets/grteen_icon.png'),
                        ),
                        SizedBox(height: 10,),
                        Text('50%',style: TextStyle(color: Color(0xff959595),fontSize: 20),),
                        SizedBox(height: 10,)

                      ],
                    ),decoration:  BoxDecoration(color: Color(0xffF6F6F6),borderRadius: BorderRadius.all(Radius.circular(20)),  boxShadow: [
                    new BoxShadow(
                      color: Color(0xffE2E2E2),
                      blurRadius: 6,
                      spreadRadius: 1,
                    )
                  ]),
                  )
                ],
              ),
              Text('2'),
              Text('3'),
              Text('4'),
            ],
            controller: controller,
          ),
          align: IndicatorAlign.bottom,
          // your indicator align with container
          length: 4,
          // indicator count
          indicatorColor: Colors.grey,
          // unselected indicator color

          indicatorSelectorColor: Theme.of(context).primaryColor,
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
        decoration:  BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(20)),  boxShadow: [
    new BoxShadow(
    color: Color(0xffE2E2E2),
    blurRadius: 6,
    spreadRadius: 1,
    )
    ]),
        child: Column(children: <Widget>[Text(
          'Summary',
          style: TextStyle(fontSize: 25, color: Colors.black45),
        ),SizedBox(height: 5,),Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
               Container(
              width: 80,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 60,
                    child: Image.asset('assets/weather_icon.png'),
                  ),
                  SizedBox(height: 10,),
                  Text('50%',style: TextStyle(color: Color(0xff959595),fontSize: 20),),
                  SizedBox(height: 10,)

                ],
              ),decoration:  BoxDecoration(color: Color(0xffF6F6F6),borderRadius: BorderRadius.all(Radius.circular(20)),  boxShadow: [
              new BoxShadow(
                color: Color(0xffE2E2E2),
                blurRadius: 6,
                spreadRadius: 1,
              )
            ]),
            ),    Container(
              width: 80,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 60,
                    child: Image.asset('assets/water_icon.png'),
                  ),
                  SizedBox(height: 10,),
                  Text('50%',style: TextStyle(color: Color(0xff959595),fontSize: 20),),
                  SizedBox(height: 10,)

                ],
              ),decoration:  BoxDecoration(color: Color(0xffF6F6F6),borderRadius: BorderRadius.all(Radius.circular(20)),  boxShadow: [
              new BoxShadow(
                color: Color(0xffE2E2E2),
                blurRadius: 6,
                spreadRadius: 1,
              )
            ]),
            ),    Container(
              width: 80,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 60,
                    child: Image.asset('assets/wind_icon.png'),
                  ),
                  SizedBox(height: 10,),
                  Text('50%',style: TextStyle(color: Color(0xff959595),fontSize: 20),),
                  SizedBox(height: 10,)

                ],
              ),decoration:  BoxDecoration(color: Color(0xffF6F6F6),borderRadius: BorderRadius.all(Radius.circular(20)),  boxShadow: [
              new BoxShadow(
                color: Color(0xffE2E2E2),
                blurRadius: 6,
                spreadRadius: 1,
              )
            ]),
            )
          ],
        ),SizedBox(height: 15,)]),
      )
    ]);
  }
}
