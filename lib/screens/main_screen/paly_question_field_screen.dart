import 'package:center_for_food_and_drug/components/login_registration_components/streamState.dart';
import 'package:center_for_food_and_drug/tasks_provider/provider_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayQuestionFieldScreen extends StatefulWidget {
  final String entityID;
  PlayQuestionFieldScreen({this.entityID});
  @override
  _PlayQuestionFieldScreenState createState() =>
      _PlayQuestionFieldScreenState();
}

class _PlayQuestionFieldScreenState extends State<PlayQuestionFieldScreen> {
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
              child: QuestionFieldStreamState(entityID: widget.entityID),
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

          List<Map<String, dynamic>> formData = [
            {
              "question1": Provider.of<ProviderData>(context, listen: false)
                  .controllers[0]["question"],
              "answer": Provider.of<ProviderData>(context, listen: false)
                  .controllers[0]["textField"]
                  .text,
            },
            {
              "question2": Provider.of<ProviderData>(context, listen: false)
                  .controllers[1]["question"],
              "answer": Provider.of<ProviderData>(context, listen: false)
                  .controllers[1]["textField"]
                  .text,
            },
            {
              "question3": Provider.of<ProviderData>(context, listen: false)
                  .controllers[2]["question"],
              "answer": Provider.of<ProviderData>(context, listen: false)
                  .controllers[2]["textField"]
                  .text,
            },
            {
              "question4": Provider.of<ProviderData>(context, listen: false)
                  .controllers[3]["question"],
              "answer": Provider.of<ProviderData>(context, listen: false)
                  .controllers[3]["textField"]
                  .text,
            },
            {
              "question5": Provider.of<ProviderData>(context, listen: false)
                  .controllers[4]["question"],
              "answer": Provider.of<ProviderData>(context, listen: false)
                  .controllers[4]["textField"]
                  .text,
            },
            {
              "question6": Provider.of<ProviderData>(context, listen: false)
                  .controllers[5]["question"],
              "answer": Provider.of<ProviderData>(context, listen: false)
                  .controllers[5]["textField"]
                  .text,
            },
          ];
          print(formData);
        },
      ),
    );
  }
}
