import 'package:center_for_food_and_drug/components/login_registration_components/streamState.dart';
import 'package:center_for_food_and_drug/tasks_provider/provider_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayQuestionSelectScreen extends StatefulWidget {
  final String entityID;
  PlayQuestionSelectScreen({this.entityID});
  @override
  _PlayQuestionSelectScreenState createState() =>
      _PlayQuestionSelectScreenState();
}

class _PlayQuestionSelectScreenState extends State<PlayQuestionSelectScreen> {
  bool giaeSection = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("General Info"),
        centerTitle: true,
      ),
      // key: scaffoldAddMembersScreen,
      backgroundColor: Color(0XFF111b47), //0XFF0A0E21
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(),
            Expanded(
              child: giaeSection
                  ? QuestionFieldStreamState(entityID: widget.entityID)
                  : QuestionSelectStreamState(entityID: widget.entityID),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 15,
        backgroundColor: Colors.blue,
        child: Icon(Icons.navigate_next_outlined, color: Colors.white),
        onPressed: () {
          //TODO add ability to upload image to firebase from user and add this image inside the app by manager
          List<Map<String, dynamic>> formData = [];
          for (Map item in Provider.of<ProviderData>(context, listen: false)
              .controllers) {
            formData.add(
              {"question": item["question"], "answer": item["answer"]},
            );
          }
          setState(() {
            giaeSection = false;
          });
          print(formData);
        },
      ),
    );
  }
}
