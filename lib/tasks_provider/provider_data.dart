import 'dart:typed_data';

import 'package:flutter/material.dart';

class ProviderData extends ChangeNotifier {
  Uint8List pdfFileByte;

  String userID = "";
  String officeName = "";
  String fullName = "";
  String username = "";
  String email = "";
  String inputEmail = "";
  String phoneNumber = "";
  String idNumber = "";

  List<dynamic> controllers = [
    // {"textField": TextEditingController(), "question": ""},
  ];

  String resetEmail = "";
  bool playing = false;
  bool isNotified = true;
  String profileImageURL;

  Locale locale; //Locale("ar", "SA");

  void changeLocale(Locale loc) {
    locale = loc;
    notifyListeners();
  }

  void changeUserData({String data, String dataType}) {
    if (dataType == "username") {
      username = data;
    } else if (dataType == "email") {
      email = data;
    } else if (dataType == "officeName") {
      officeName = data;
    } else if (dataType == "fullName") {
      fullName = data;
    } else if (dataType == "phoneNumber") {
      phoneNumber = data;
    } else if (dataType == "idNumber") {
      idNumber = data;
    }

    notifyListeners();
  }

  void changeState(bool state, String typeState) {
    if (typeState == "playing") {
      playing = state;
    } else if (typeState == "isNotified") {
      isNotified = state;
    } else if (typeState == "") {}

    notifyListeners();
  }

  void upDateProFileImageURL(String imageURL) async {
    profileImageURL = imageURL;
    notifyListeners();
  }
}
