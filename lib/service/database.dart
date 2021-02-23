import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class DataBase {
  // FirebaseFirestore _fireStore;
  //
  // DataBase() {
  //   initialFirebase();
  // }
  // initialFirebase() async {
  //   // try {
  //   await Firebase.initializeApp();
  //   _fireStore = FirebaseFirestore.instance;
  //   // } catch (e) {
  //   //   print(e);
  //   //   //show Screen
  //   // }
  // }
  //
  // Future getInstitutionByID({String userId}) async {
  //   await Firebase.initializeApp();
  //   return FirebaseFirestore.instance
  //       .collection("institutions")
  //       .doc(userId)
  //       .get();
  // }
  //
  // Future addInstitutionInfo({Map userInfoMap, String uniqueId}) async {
  //   await Firebase.initializeApp();
  //   FirebaseFirestore.instance
  //       .collection("institutions")
  //       .doc(uniqueId)
  //       .set(userInfoMap);
  // }

  //user section

  Future addUserInfo({Map userInfoMap, String userId}) async {
    await Firebase.initializeApp();
    FirebaseFirestore.instance.collection("users").doc(userId).set(userInfoMap);
  }

  Future saveUserData({Map userInfoMap}) async {
    await Firebase.initializeApp();
    FirebaseFirestore.instance.collection("UserData").add(userInfoMap);
  }

  Future getUserByUserID({String userId}) async {
    await Firebase.initializeApp();
    return FirebaseFirestore.instance.collection("users").doc(userId).get();
  }

  Future removeUserInfo({String userId}) async {
    await Firebase.initializeApp();
    return FirebaseFirestore.instance.collection("users").doc(userId).delete();
  }
  // Future getChatMessages() {
  //   // ignore: deprecated_member_use
  //   return _fireStore.collection("messages").getDocuments();
  // }

  // getChatMessageStream() async* {
  //   yield* _fireStore.collection("messages").orderBy('time').snapshots();
  // }

  Future getUserByEmail({String email}) async {
    //TODO
    await Firebase.initializeApp();
    return FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .get();
  }

  getEntitiesListStream() async* {
    //TODO
    print("+++++++++++++++++++++");
    await Firebase.initializeApp();
    yield* FirebaseFirestore.instance
        .collection("LY_FDA")
        .doc("LY_FDA")
        .collection("entities")
        .snapshots();
  }

  Future getEntityData_1({String entityID, String pageType}) async {
    //TODO
    print("+++++++++++++++++++++");
    await Firebase.initializeApp();
    return FirebaseFirestore.instance
        .collection("LY_FDA")
        .doc("LY_FDA")
        .collection("entities")
        .doc(entityID)
        .collection(pageType)
        .get();
  }

  getEntityData({String entityID, String pageType}) async* {
    //TODO
    print("+++++++++++++++++++++");
    await Firebase.initializeApp();
    yield* FirebaseFirestore.instance
        .collection("LY_FDA")
        .doc("LY_FDA")
        .collection("entities")
        .doc(entityID)
        .collection(pageType)
        .snapshots();
  }

  getReportListStream() async* {
    print("+++++++++++++++++++++");
    await Firebase.initializeApp();
    yield* FirebaseFirestore.instance
        .collection("LY_FDA")
        .doc("LY_FDA")
        .collection("archives")
        .snapshots();
  }

  getSpecializationListStream({String collageName, String sectionName}) async* {
    print("________________________");
    await Firebase.initializeApp();
    yield* FirebaseFirestore.instance
        .collection("collage")
        .doc(collageName)
        .collection("section")
        .doc(sectionName)
        .collection("specialization")
        .snapshots();
  }

  getSemesterListStream(
      {@required String collageName,
      @required String sectionName,
      @required String specializationName}) async* {
    print("________________________");
    await Firebase.initializeApp();
    yield* FirebaseFirestore.instance
        .collection("collage")
        .doc(collageName)
        .collection("section")
        .doc(sectionName)
        .collection("specialization")
        .doc(specializationName)
        .collection("semester")
        .snapshots();
  }

  // getBooksContentListStream(
  //     {@required String collageName,
  //     @required String sectionName,
  //     @required String specializationName,
  //     @required String semesterIndex}) async* {
  //   print("_____________uuuuuu___________");
  //   await Firebase.initializeApp();
  //   yield* FirebaseFirestore.instance
  //       .collection("collage")
  //       .doc(collageName)
  //       .collection("section")
  //       .doc(sectionName)
  //       .collection("specialization")
  //       .doc(specializationName)
  //       .collection("semester")
  //       .doc(semesterIndex)
  //       .collection("content")
  //       .doc("content")
  //       .collection("books")
  //       .snapshots();
  // }

  getContentListStream(
      {@required String collageName,
      @required String sectionName,
      @required String specializationName,
      @required String semesterIndex,
      @required String courseBy,
      @required String sectionType,
      @required String contentType}) async* {
    print("_____________uuuuuu___________");
    await Firebase.initializeApp();
    yield* FirebaseFirestore.instance
        .collection("collage")
        .doc(collageName)
        .collection("section")
        .doc(sectionName)
        .collection("specialization")
        .doc(specializationName)
        .collection("semester")
        .doc(semesterIndex)
        .collection("content")
        .doc("content")
        .collection(contentType)
        .doc(courseBy)
        .collection(sectionType)
        .snapshots();
  }

  getCurrentCoursesListStream(
      {@required String collageName,
      @required String sectionName,
      @required String specializationName,
      @required String semesterIndex,
      @required String contentType}) async* {
    print("_____________uuuuuu___________");
    await Firebase.initializeApp();
    yield* FirebaseFirestore.instance
        .collection("collage")
        .doc(collageName)
        .collection("section")
        .doc(sectionName)
        .collection("specialization")
        .doc(specializationName)
        .collection("semester")
        .doc(semesterIndex)
        .collection("content")
        .doc("content")
        .collection(contentType)
        .snapshots();
  }

  Future<bool> addData({
    @required dataType,
    @required Map data,
  }) async {
    await Firebase.initializeApp();
    var value = await FirebaseFirestore.instance.collection(dataType).add(data);
    if (value != null) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }

    return Future.value(false);
  }

  Future addImageInfo({Map data}) async {
    var value = await FirebaseFirestore.instance
        .collection("uploadPapersInfo")
        .add(data);
    if (value != null) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
}

class DataBaseStorage {
  Future loadIcon({String imageName}) async {
    await Firebase.initializeApp();
    return await FirebaseStorage.instance
        .ref()
        .child(imageName)
        .getDownloadURL();
  }

  Future uploadImage({File image, String imageName}) async {
    await Firebase.initializeApp();
    print(
        "IIIIIIIIIIIIIMMMMMMMMMMMMMMMMMAAAAAAAAAAAAAAGGGGGGWWWWWWWW +++++++++++===========$imageName");
    StorageReference imagePathRef = FirebaseStorage.instance
        .ref()
        .child("/Upload_Images/exams_papers/")
        .child(imageName);
    StorageUploadTask task = imagePathRef.putFile(image);
    var imageURL = await (await task.onComplete).ref.getDownloadURL();
    print(" +++++++++++===========$imageURL");
    return imageURL.toString();
  }

  // Future uploadImage({File image,String imageName}) async{
  //   await Firebase.initializeApp();
  //     Storage FirebaseStorage.instance.ref().child("/Upload_Images/exams_papers/").child("$imageName.png");
  //
  // }

  Future uploadProfileImage({File image, String imageName}) async {
    await Firebase.initializeApp();
    print(
        "IIIIIIIIIIIIIMMMMMMMMMMMMMMMMMAAAAAAAAAAAAAAGGGGGGWWWWWWWW +++++++++++===========$imageName");
    StorageReference imagePathRef =
        FirebaseStorage.instance.ref().child("profileImages").child(imageName);
    StorageUploadTask task = imagePathRef.putFile(image);
    var imageURL = await (await task.onComplete).ref.getDownloadURL();
    print(" +++++++++++===========$imageURL");
    return imageURL.toString();
  }
}

class FirebaseNotification {
  int ssd = 1;
  Future getUserDeviceToken() async {
    await Firebase.initializeApp();
    return FirebaseMessaging().getToken();
  }
}
