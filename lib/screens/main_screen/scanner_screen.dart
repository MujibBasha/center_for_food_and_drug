import 'package:center_for_food_and_drug/localization/localization_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class ScannerScreen extends StatefulWidget {
  static String id = "Scanner";
  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  String _scanBarcode = 'Unknown';

  enablesPermission() async {
    final status = await Permission.camera.request();
  }

  @override
  void initState() {
    super.initState();
  }

  startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            "#ff6666", "Cancel", true, ScanMode.BARCODE)
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print("barcodeScanRes =$barcodeScanRes");
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  final scannerScaffoldKey = GlobalKey<ScaffoldState>();

  void showSnackBar({
    @required String text,
    @required bool isSucceeded,
  }) {
    // ignore: deprecated_member_use
    scannerScaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSucceeded ? Colors.white : Colors.red,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            key: scannerScaffoldKey,
            appBar: AppBar(title: const Text('Barcode scan')),
            body: Builder(builder: (BuildContext context) {
              return Container(
                  alignment: Alignment.center,
                  child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                            color: Colors.blue.withOpacity(0.9),
                            onPressed: () async {
                              final status = await Permission.camera.request();
                              print("${status.isGranted}");
                              if (status.isGranted) {
                                scanBarcodeNormal();
                              } else {
                                //TODO show snack Bar
                                showSnackBar(
                                  isSucceeded: false,
                                  text: getTranslated(
                                      context: context,
                                      key: "upload_image_local_notification",
                                      typeScreen: "general_content"),
                                );
                              }
                            },
                            child: Text("Start barcode scan")),
                        RaisedButton(
                            onPressed: () async {
                              final status = await Permission.camera.request();
                              print("${status.isGranted}");
                              if (status.isGranted) {
                                scanQR();
                              } else {
                                //TODO show snack Bar
                                showSnackBar(
                                  isSucceeded: false,
                                  text: getTranslated(
                                      context: context,
                                      key: "upload_image_local_notification",
                                      typeScreen: "general_content"),
                                );
                              }
                            },
                            child: Text("Start QR scan")),
                        RaisedButton(
                            onPressed: () async {
                              final status = await Permission.camera.request();
                              print("${status.isGranted}");
                              if (status.isGranted) {
                                startBarcodeScanStream();
                              } else {
                                //TODO show snack Bar
                                showSnackBar(
                                  isSucceeded: false,
                                  text: getTranslated(
                                      context: context,
                                      key: "upload_image_local_notification",
                                      typeScreen: "general_content"),
                                );
                              }
                            },
                            child: Text("Start barcode scan stream")),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Text('Scan result : $_scanBarcode\n',
                              style: TextStyle(fontSize: 20)),
                        )
                      ]));
            })));
  }
}
