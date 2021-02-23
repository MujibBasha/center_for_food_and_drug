// import 'package:administrative_control/components/login_registration_components/streamState.dart';
import 'package:center_for_food_and_drug/components/login_registration_components/streamState.dart';
import 'package:center_for_food_and_drug/screens/main_screen/local_archive_list_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class ArchivesScreen extends StatefulWidget {
  @override
  _ArchivesScreenState createState() => _ArchivesScreenState();
}

class _ArchivesScreenState extends State<ArchivesScreen> {
  String contentType = "globalArchives";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: contentType == "globalArchives"
            ? Text("Global Archives")
            : Text("Local Archives"),
        centerTitle: true,
      ),
      // key: scaffoldAddMembersScreen,
      backgroundColor: Color(0XFF111b47), //0XFF0A0E21
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: contentType == "globalArchives"
                  ? ReportStreamState()
                  : Container(),

              // collageName: widget.collageName,
              // sectionName: widget.sectionName,
              // specializationName: widget.specializationName,
              // semesterIndex: widget.semesterIndex,
              // courseBy: widget.courseBy,
            ),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        backgroundColor: Color(0XFF0A0E21),
        items: <Widget>[
          Icon(
            Icons.assignment_outlined,
            size: 30,
            color: Color(0XFF0A0E21),
          ),
          Icon(
            Icons.archive_outlined,
            size: 30,
            color: Color(0XFF0A0E21),
          ),
        ],
        onTap: (index) {
          //Handle button tap
          if (index == 0) {
            setState(
              () {
                contentType = "globalArchives";
                // getFiles();
              },
            );
          } else if (index == 1) {
            setState(
              () {
                contentType = "localArchives";
                // getFiles();
              },
            );
          }
        },
        animationCurve: Curves.bounceInOut,
        animationDuration: Duration(milliseconds: 200),
      ),
    );
  }
}
