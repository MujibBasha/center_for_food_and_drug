import 'package:center_for_food_and_drug/components/login_registration_components/streamState.dart';
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
  @override
  void dispose() {
//to delete all data when close this window
    for (TextEditingController item
        in Provider.of<ProviderData>(context, listen: false).controllers) {
      item.clear();
    }
    super.dispose();
  }

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
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: ListView(children: [
                MainBar(
                  text: "Pages",
                  number: "1/3",
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
          // //TODO add ability to upload image to firebase from user and add this image inside the app by manager
          // print(
          //     ">>>>>>>>${Provider.of<ProviderData>(context, listen: false).documentData.length}");
          // for (dynamic item in Provider.of<ProviderData>(context, listen: false)
          //     .documentData) {
          //   print("item:$item");
          //   Provider.of<ProviderData>(context, listen: false).page_0.add(
          //     {"question": item["question"], "answer": item["answer"].text},
          //   );
          // }
          // print(Provider.of<ProviderData>(context, listen: false)
          //     .page_0); //Provider.of<ProviderData>(context, listen: false).page_0
          FocusScope.of(context).unfocus();
          print(Provider.of<ProviderData>(context, listen: false).documentData);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PlayQuestionSelectScreen(entityID: widget.entityID),
            ),
          );
        },
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
