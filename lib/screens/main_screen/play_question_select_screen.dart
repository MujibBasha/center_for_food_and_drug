import 'package:center_for_food_and_drug/components/login_registration_components/streamState.dart';
import 'package:center_for_food_and_drug/screens/main_screen/paly_question_field_screen.dart';
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
        title: Text("Questionnaire"),
        centerTitle: true,
      ),
      // key: scaffoldAddMembersScreen,
      backgroundColor: Color(0XFF111b47), //0XFF0A0E21
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: ListView(children: [
                MainBar(
                  text: "Pages",
                  number: "2/3",
                ),
                SizedBox(
                  width: 15,
                ),
                Selector<ProviderData, int>(
                  selector: (context, data) => data.totalCurrentQuestion,
                  builder: (context, total, child) {
                    return MainBar(
                      text: "Total Question",
                      number: "$total",
                    );
                  },
                ),
                SizedBox(
                  width: 15,
                ),
                Selector<ProviderData, int>(
                  selector: (context, data) => data.totalCurrentQuestion,
                  builder: (context, total, child) {
                    return MainBar(
                      text: "answered",
                      number: "0/$total",
                    );
                  },
                ),
              ]),
            ),
            Expanded(
              child: QuestionSelectStreamState(entityID: widget.entityID),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 15,
        backgroundColor: Colors.blue,
        child: Icon(Icons.navigate_next_outlined, color: Colors.white),
        onPressed: () {
          FocusScope.of(context).unfocus();
          //TODO add ability to upload image to firebase from user and add this image inside the app by manager
          print(Provider.of<ProviderData>(context, listen: false).documentData);
        },
      ),
    );
  }
}
