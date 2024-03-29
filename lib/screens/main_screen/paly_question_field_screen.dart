import 'package:bot_toast/bot_toast.dart';
import 'package:center_for_food_and_drug/components/login_registration_components/streamState.dart';
import 'package:center_for_food_and_drug/localization/localization_constants.dart';
import 'package:center_for_food_and_drug/screens/main_screen/play_question_select_screen.dart';
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
  final questionFieldScaffoldKey = GlobalKey<ScaffoldState>();

  // @override
  // void dispose() {
  //   print("dispose of field");
  //   Provider.of<ProviderData>(context, listen: false)
  //       .generalEntityInfoDocumentData
  //       .clear();
  //   Provider.of<ProviderData>(context, listen: false).controllers.clear();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        return showDialog(
          context: questionFieldScaffoldKey.currentContext,
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
                  Navigator.of(context).pop(true);

                  Provider.of<ProviderData>(context, listen: false)
                      .generalEntityInfoDocumentData
                      .clear();
                  Provider.of<ProviderData>(context, listen: false)
                      .controllers
                      .clear();

                  //Provider.of<ProviderData>(context, listen: false).clearData();

                  // await Future.delayed(Duration(microseconds: 500));
                },
                child: Text(
                  getTranslated(
                      context: context,
                      key: "yes_button",
                      typeScreen: "WillPopScope_content"),
                  style: TextStyle(color: Colors.lightBlueAccent),
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
                  style: TextStyle(color: Colors.lightBlueAccent),
                ),
              ),
            ],
            backgroundColor: Color(0xff0A0E21),
          ),
        );
      },
      child: Scaffold(
        key: questionFieldScaffoldKey,
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
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: SizedBox(
                  height: 40,
                  child: ListView(
                      // shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        MainBar(
                          text: "Pages",
                          number: "1/3",
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Selector<ProviderData, int>(
                          selector: (context, data) =>
                              data.totalCurrentQuestion,
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
                          selector: (context, data) =>
                              data.totalCurrentQuestion,
                          builder: (context, total, child) {
                            return MainBar(
                              text: "Answered",
                              number: "0/$total",
                            );
                          },
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Selector<ProviderData, int>(
                          selector: (context, data) =>
                              data.totalCurrentQuestion,
                          builder: (context, total, child) {
                            return MainBar(
                              text: "Required Questions",
                              number: "$total",
                            );
                          },
                        ),
                        SizedBox(
                          width: 15,
                        ),
                      ]),
                ),
              ),
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
            FocusScope.of(context).unfocus();
            BotToast.showText(
                text: "Saved", contentColor: Colors.lightBlueAccent);
            print(Provider.of<ProviderData>(context, listen: false)
                .generalEntityInfoDocumentData);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    PlayQuestionSelectScreen(entityID: widget.entityID),
              ),
            );
          },
        ),
      ),
    );
  }
}

class MainBar extends StatefulWidget {
  final String number;
  final String text;
  MainBar({this.number, this.text});
  @override
  _MainBarState createState() => _MainBarState();
}

class _MainBarState extends State<MainBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30))),
              padding: EdgeInsets.all(5),
              child: Text(widget.number),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              padding: EdgeInsets.all(5),
              child: Text(widget.text),
            )
          ],
        ));
  }
}
