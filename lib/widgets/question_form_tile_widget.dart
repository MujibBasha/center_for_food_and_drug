import 'package:center_for_food_and_drug/tasks_provider/provider_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuestionFormTileWidget extends StatefulWidget {
  final String questionTitle;
  final TextEditingController controller;
  final int currentIndex;

  QuestionFormTileWidget({
    @required this.questionTitle,
    @required this.controller,
    @required this.currentIndex,
  });
  @override
  _QuestionFormTileWidgetState createState() => _QuestionFormTileWidgetState();
}

class _QuestionFormTileWidgetState extends State<QuestionFormTileWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProviderData>(context, listen: false)
        .controllers[widget.currentIndex]["question"] = widget.questionTitle;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black45,
      elevation: 10,
      child: Container(
          padding: EdgeInsets.only(top: 10),
          child: Column(children: [
            Text(
              "Q${(widget.currentIndex) + 1} ${this.widget.questionTitle}",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 4,
            ),
            QuestionTextFieldTile(
              controller: widget.controller,
            ),
            SizedBox(
              height: 5,
            ),
          ])),
    );
  }
}

class QuestionTextFieldTile extends StatefulWidget {
  final TextEditingController controller;
  QuestionTextFieldTile({@required this.controller});
  @override
  _QuestionTextFieldTileState createState() => _QuestionTextFieldTileState();
}

class _QuestionTextFieldTileState extends State<QuestionTextFieldTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      child: TextFormField(
        autocorrect: false,
        decoration: InputDecoration(hintText: " ...", labelText: "required"),
        controller: widget.controller,
      ),
    );
  }
}

//for second screen

class QuestionSelectTileWidget extends StatefulWidget {
  final DocumentSnapshot querySnapshot;

  final int currentIndex;

  QuestionSelectTileWidget({
    @required this.querySnapshot,
    @required this.currentIndex,
  });
  @override
  _QuestionSelectTileWidgetState createState() =>
      _QuestionSelectTileWidgetState();
}

class _QuestionSelectTileWidgetState extends State<QuestionSelectTileWidget> {
  String optionSelected = "";
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Text(
            "${(widget.currentIndex) + 1} ${widget.querySnapshot.get("question")}"),
        SizedBox(
          height: 5,
        ),
        GestureDetector(
            onTap: () {
              setState(() {
                optionSelected = widget.querySnapshot.get("option1");
                Provider.of<ProviderData>(context, listen: false)
                        .controllers[widget.currentIndex]["answer"] =
                    optionSelected;
                Provider.of<ProviderData>(context, listen: false)
                        .controllers[widget.currentIndex]["question"] =
                    widget.querySnapshot.get("question");
                //Send this to provider TODO
              });
            },
            child: OptionTile(
                option: "A",
                description: widget.querySnapshot.get("option1"),
                optionSelected: optionSelected)),
        GestureDetector(
            onTap: () {
              setState(() {
                optionSelected = widget.querySnapshot.get("option2");
                Provider.of<ProviderData>(context, listen: false)
                        .controllers[widget.currentIndex]["answer"] =
                    optionSelected;
                Provider.of<ProviderData>(context, listen: false)
                        .controllers[widget.currentIndex]["question"] =
                    widget.querySnapshot.get("question");
              });
            },
            child: OptionTile(
                option: "B",
                description: widget.querySnapshot.get("option2"),
                optionSelected: optionSelected)),
        GestureDetector(
            onTap: () {
              setState(() {
                optionSelected = widget.querySnapshot.get("option3");
                Provider.of<ProviderData>(context, listen: false)
                        .controllers[widget.currentIndex]["answer"] =
                    optionSelected;
                Provider.of<ProviderData>(context, listen: false)
                        .controllers[widget.currentIndex]["question"] =
                    widget.querySnapshot.get("question");
              });
            },
            child: OptionTile(
                option: "C",
                description: widget.querySnapshot.get("option3"),
                optionSelected: optionSelected)),
        GestureDetector(
            onTap: () {
              setState(() {
                optionSelected = widget.querySnapshot.get("option4");
                Provider.of<ProviderData>(context, listen: false)
                        .controllers[widget.currentIndex]["answer"] =
                    optionSelected;
                Provider.of<ProviderData>(context, listen: false)
                        .controllers[widget.currentIndex]["question"] =
                    widget.querySnapshot.get("question");
              });
            },
            child: OptionTile(
                option: "D",
                description: widget.querySnapshot.get("option4"),
                optionSelected: optionSelected)),
      ],
    ));
  }
}

// class QuestionSelect extends StatefulWidget {
//   @override
//   _QuestionSelectState createState() => _QuestionSelectState();
// }
//
// class _QuestionSelectState extends State<QuestionSelect> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child:Column(
//         children: [
//           Text("s"),
//           SizedBox(height: 5,),
//           OptionTile(option: null, description: null, optionSelected: null),
//         ],
//       )
//     );
//   }
// }

class OptionTile extends StatefulWidget {
  final String option, description, optionSelected;
  OptionTile({
    @required this.option,
    @required this.description,
    @required this.optionSelected,
  });
  @override
  _OptionTileState createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(children: [
      Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: widget.description == widget.optionSelected
                  ? Colors.green.withOpacity(0.6)
                  : Colors.grey),
        ),
        child: Text(
          widget.option,
          style: TextStyle(
            color: widget.description == widget.optionSelected
                ? Colors.blue
                : Colors.grey,
          ),
        ),
      ),
      SizedBox(
        width: 8,
      ),
      Text(widget.description,
          style: TextStyle(
            fontSize: widget.description == widget.optionSelected ? 18 : 17,
            color: widget.description == widget.optionSelected
                ? Colors.black
                : Colors.black87,
          ))
    ]));
  }
}
