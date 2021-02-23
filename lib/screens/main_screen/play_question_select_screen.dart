import 'package:bot_toast/bot_toast.dart';
import 'package:center_for_food_and_drug/components/login_registration_components/streamState.dart';
import 'package:center_for_food_and_drug/localization/localization_constants.dart';
import 'package:center_for_food_and_drug/screens/main_screen/paly_question_field_screen.dart';
import 'package:center_for_food_and_drug/screens/main_screen/play_employee_question_screen.dart';
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
  void dispose() {
    print("dispose of select");
    Provider.of<ProviderData>(context, listen: false)
        .reportInfoDocumentData
        .clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(
              getTranslated(
                  context: context,
                  key: "main_text",
                  typeScreen: "WillPopScope_content"),
              style: TextStyle(color: Colors.pink),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "are you shore ?",
                  // getTranslated(
                  //     context: context,
                  //     key: "body_question_text",
                  //     typeScreen: "WillPopScope_content"),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  "you will lose the current data",
                  // getTranslated(
                  //     context: context,
                  //     key: "close_app_hint",
                  //     typeScreen: "WillPopScope_content"),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            actions: [
              FlatButton(
                onPressed: () async {
                  // int end = Provider.of<ProviderData>(context, listen: false)
                  //     .reportInfoDocumentData
                  //     .length;
                  // int start = Provider.of<ProviderData>(context, listen: false)
                  //     .questionStored;
                  Provider.of<ProviderData>(context, listen: false)
                      .reportInfoDocumentData
                      .clear();
                  Navigator.of(context).pop(true);

                  // .removeRange(start, end);
                },
                child: Text(
                  getTranslated(
                      context: context,
                      key: "yes_button",
                      typeScreen: "WillPopScope_content"),
                  style: TextStyle(color: Colors.pink),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  getTranslated(
                      context: context,
                      key: "no_button",
                      typeScreen: "WillPopScope_content"),
                  style: TextStyle(color: Colors.pink),
                ),
              ),
            ],
            backgroundColor: Color(0xff0A0E21),
          ),
        );
      },
      child: Scaffold(
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
                child: SizedBox(
                  height: 40,
                  child: ListView(scrollDirection: Axis.horizontal, children: [
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
            print(Provider.of<ProviderData>(context, listen: false)
                .generalEntityInfoDocumentData);
            print("second document");
            print(Provider.of<ProviderData>(context, listen: false)
                .reportInfoDocumentData);
            BotToast.showText(
                text: "Saved", contentColor: Colors.lightBlueAccent);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlayEmployeeQuestionScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
