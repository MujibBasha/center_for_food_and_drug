// import 'package:administrative_control/components/login_registration_components/streamState.dart';
import 'dart:io';

import 'package:center_for_food_and_drug/components/login_registration_components/item_of_local_content.dart';
import 'package:center_for_food_and_drug/components/login_registration_components/streamState.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_file_utils/flutter_file_utils.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:center_for_food_and_drug/widgets/slidable_widget.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:center_for_food_and_drug/get list of file/file_manager.dart';
import 'package:permission_handler/permission_handler.dart';

class LocalArchiveListScreen extends StatefulWidget {
  @override
  _LocalArchiveListScreenState createState() => _LocalArchiveListScreenState();
}

class _LocalArchiveListScreenState extends State<LocalArchiveListScreen> {
  var files;

  void getFiles() async {
    //asyn function to get list of files
    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    var root = storageInfo[0]
        .rootDir; //storageInfo[1] for SD card, geting the root directory
    print("root =$root");

    var fm = FileManager(
        root: Directory(
            "storage/emulated/0/center_for_food_and_drug/download/local_archive")); // any specific path you need to get specific file extensions from at as a list of file like(/storage/emulated/0/name of folder in your phone"
    //TODO change to this  /data/user/0/com.lightmoonstudioo.dsc_hackathon_pp/app_flutter/download/localPDF/ specific path folder
    files = await fm.filesTree(extensions: [
      "pdf",
    ] //optional, to filter files, list only pdf files
        );
    setState(() {}); //update the UI
  }

  ///storage/emulated/0/Android/data/com.lightmoonstudioo.center_for_food_and_drug/files
  /////storage/emulated/0/center_for_food_and_drug/download/local_archive
  void showSnackBar({
    @required String text,
    @required SlidableAction action,
  }) {
    // ignore: deprecated_member_use
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  void _createDownloadReportFolder() async {
    // var dir = await getApplicationDocumentsDirectory();
    final Directory path = Directory(
        "storage/emulated/0/center_for_food_and_drug/download/local_archive");

    if ((await path.exists())) {
      // TODO:
      print("exist PDF Dir");
    } else {
      // TODO:
      print("not exist PDF Dir");
      path.create(recursive: true);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _createDownloadReportFolder();
    getFiles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // key: scaffoldAddMembersScreen,
      //0XFF0A0E21
      child: ListView.builder(
        //if file/folder list is grabbed, then show here
        itemCount: files?.length ?? 0,
        itemBuilder: (context, index) {
          //TODO add ability to remove current content form phone
          return SlidableWidget(
              child: ItemOfLocalContent(
                currentFile: files[index],
              ),
              isLocalContent: true,
              slidableOnPressed: (SlidableAction action) async {
                switch (action) {
                  case SlidableAction.delete:
                    final status = await Permission.storage.request();
                    if (status.isGranted) {
                      print("delete current content");
                      await files[index].delete();
                      setState(() {
                        getFiles();
                      });
                      // var dir = await getApplicationDocumentsDirectory();
                    }
                    break;
                  case SlidableAction.more:
                    // ignore: deprecated_member_use
                    showSnackBar(
                        text: "No more option", action: SlidableAction.more);

                    break;
                  case SlidableAction.downloadVideo:
                    print("you can not Download this video ");
                    break;
                }
              });
        },
      ),
    );
  }
}
