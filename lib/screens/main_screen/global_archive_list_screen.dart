// import 'package:administrative_control/components/login_registration_components/streamState.dart';
import 'package:center_for_food_and_drug/components/login_registration_components/streamState.dart';
import 'package:flutter/material.dart';

class GlobalArchiveListScreen extends StatefulWidget {
  @override
  _GlobalArchiveListScreenState createState() =>
      _GlobalArchiveListScreenState();
}

class _GlobalArchiveListScreenState extends State<GlobalArchiveListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Global Archives"),
        centerTitle: true,
      ),
      // key: scaffoldAddMembersScreen,
      backgroundColor: Color(0XFF111b47), //0XFF0A0E21
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ReportStreamState(),

              // collageName: widget.collageName,
              // sectionName: widget.sectionName,
              // specializationName: widget.specializationName,
              // semesterIndex: widget.semesterIndex,
              // courseBy: widget.courseBy,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 15,
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add),
        onPressed: () {
          //TODO add ability to upload image to firebase from user and add this image inside the app by manager
        },
      ),
    );
  }
}
