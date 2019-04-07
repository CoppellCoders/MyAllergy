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
  String result = "Hey there !";
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
    await readCounter();
    List items = responseJson['ing'].toString().split(",");
    List probs = new List();
    for (var item in items){
      for(var a in data){
        print(item.toString().toLowerCase().trim() + " " + a.toString().split(":")[0].trim().toLowerCase());
        if(item.toString().toLowerCase().trim()==a.toString().split(":")[0].trim().toLowerCase()){
          probs.add(item.toString());
        }
      }
    }
    setState(() {
      result = probs.length == 0 ? "Safe to eat" : probs.toString();
    });

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
      body: Center(
        child: Text(
          result,
          style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        label: Text("Scan"),
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}