import 'dart:async';

import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ScanPage extends StatefulWidget {
  @override
  ScanPageState createState() => new ScanPageState();
}

class ScanPageState extends State<ScanPage> {
  List data;
  String result = "Results will appear here";
  _makeGetRequest(upc) async {
    // make request
    Response response = await get(
        'http://35.193.202.40?upc=${upc}');

    // sample info available in response
    int statusCode = response.statusCode;
    Map<String, String> headers = response.headers;
    String contentType = headers['content-type'];
    //String json = response.body;
    //print(json);
    print(response.body);
    var responseJson = json.decode(response.body);
    print(responseJson);
    if(responseJson['error'] != null){
      setState(() {
        result = "Could not find item";
      });

    }else {
      await readCounter();
      List items = responseJson['ing'].toString().split(",");
      List probs = new List();
      for (var item in items) {
        for (var a in data) {
          print(item.toString().toLowerCase().trim() + " " +
              a.toString().split(":")[0].trim().toLowerCase());
          if (
              a.toString().split(":")[0].trim().toLowerCase().contains(item.toString().toLowerCase().trim()) ||
              item.toString().toLowerCase().contains(a.toString().split(":")[0].trim().toLowerCase())
          ) {
            probs.add(item.toString());
          }
        }
      }
      setState(() {
        result = (responseJson['name'].toString().split(",")[0] + "\n" +
            ((probs.length == 0) ? "Safe to eat" : "Not safe, contains: \n" +
                probs.toString()));
      });
    }

    // TODO convert json to object...

  }
  Future<int> readCounter() async {
    print('Counter being called');
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();
      print('data '+ contents);
      data = contents.substring(0, contents.length-1).split(";");
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
  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      _makeGetRequest(qrResult);

    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Scanner"),
      ),
      body: Container( height: 400,margin: EdgeInsets.all(20),decoration: new BoxDecoration(
          color: Colors.grey[100],
          boxShadow: [ new BoxShadow(
            color: Color(0xffE2E2E2),
            blurRadius: 6,
            spreadRadius: 1,
          )],
          borderRadius: new BorderRadius.circular(25.0)),child: Column(children: <Widget>[SizedBox(height: 10,),Center(child: Text("Result",style: new TextStyle(fontSize: 25.0,)),),Center(
        child: Text(
          result,
          style: new TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,),
        ),
      )],),),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt,color: Colors.white,),
        label: Text("Scan",style: TextStyle(color: Colors.white),),
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}