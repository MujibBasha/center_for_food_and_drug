import 'package:center_for_food_and_drug/components/login_registration_components/streamState.dart';
import 'package:flutter/material.dart';

class CheckListScreen extends StatefulWidget {
  @override
  _CheckListScreenState createState() => _CheckListScreenState();
}

class _CheckListScreenState extends State<CheckListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entities"),
        centerTitle: true,
      ),
      // key: scaffoldAddMembersScreen,
      backgroundColor: Color(0XFF111b47), //0XFF0A0E21
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: EntitiesStreamState(),

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
