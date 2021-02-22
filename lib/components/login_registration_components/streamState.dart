import 'package:center_for_food_and_drug/components/login_registration_components/item_of_list.dart';
import 'package:center_for_food_and_drug/pdf_view_screen/view_pdf_screen.dart';
import 'package:center_for_food_and_drug/screens/main_screen/paly_question_field_screen.dart';
import 'package:center_for_food_and_drug/screens/main_screen/play_question_select_screen.dart';
import 'package:center_for_food_and_drug/tasks_provider/provider_data.dart';
import 'package:center_for_food_and_drug/widgets/question_form_tile_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:center_for_food_and_drug/service/database.dart';
import 'package:center_for_food_and_drug/tasks_provider/provider_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:administrative_control/components/item_of_paper_content_list.dart';
// import 'package:administrative_control/screens/search_section_screen.dart';
import 'package:center_for_food_and_drug/service/database.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

import 'package:provider/provider.dart';
// import 'package:administrative_control/screens/content_screen/paper_content_screen.dart';
//
// import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:administrative_control/screens/general_screen/show_list_courses.dart';

class EntitiesStreamState extends StatefulWidget {
  @override
  _EntitiesStreamStateState createState() => _EntitiesStreamStateState();
}

class _EntitiesStreamStateState extends State<EntitiesStreamState> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DataBase().getEntitiesListStream(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          print("gggggggggggggg");
        }
        if (!snapshot.hasData) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            ),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            return ItemOfEntitiesList(
              title: snapshot.data.docs[index].get("entity_type"),
              date: snapshot.data.docs[index].get("date"),
              onPressed: () {
                //TODO send this url to pdf viewer
                //snapshot.data.docs[index].get("url") ,
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlayQuestionFieldScreen(
                      entityID: snapshot.data.docs[index].get("entity_type"),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class ReportStreamState extends StatefulWidget {
  @override
  _ReportStreamStateState createState() => _ReportStreamStateState();
}

class _ReportStreamStateState extends State<ReportStreamState> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DataBase().getReportListStream(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          print("gggggggggggggg");
        }
        if (!snapshot.hasData) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            ),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            return ItemOfReportList(
              reportName: snapshot.data.docs[index].get("report_name"),
              date: snapshot.data.docs[index].get("date"),
              onPressed: () {
                //TODO send this url to pdf viewer
                //snapshot.data.docs[index].get("url") ,
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewPdfScreen(
                      pdfURL: snapshot.data.docs[index].get("url"),
                    ),
                  ),
                );
              },
              by: snapshot.data.docs[index].get("by"),
              location: snapshot.data.docs[index].get("location"),
            );
          },
        );
      },
    );
  }
}

class QuestionFieldStreamState extends StatefulWidget {
  final String entityID;
  // final TextEditingController controller;

  QuestionFieldStreamState({
    @required this.entityID,
  }); //@required this.controller
  @override
  _QuestionFieldStreamStateState createState() =>
      _QuestionFieldStreamStateState();
}

class _QuestionFieldStreamStateState extends State<QuestionFieldStreamState> {
  List questionName = [
    "entity_name",
    "location",
    "phone_number",
    "email",
    "manager_name",
    "date_created",
  ];

  // QuerySnapshot _snapshot;
  // int totalQuestion = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          DataBase().getEntityData(entityID: widget.entityID, pageType: "GIAE"),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          print("gggggggggggggg");
        }
        if (!snapshot.hasData) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            ),
          );
        }
        //to update total question in main Bar

        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Add Your Code here.
          Provider.of<ProviderData>(context, listen: false).changeTotal(
            snapshot.data.docs[0].get("number_of_item"),
          );
        });
        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data.docs[0].get(
              "number_of_item"), //TODO make this section dynamic by calculate the sum  of questions inside of DataBase not form Field that's update from the user
          itemBuilder: (context, index) {
            return QuestionFormTileWidget(
              questionTitle: snapshot.data.docs[0].get(questionName[index]),
              currentIndex: index,
            );
          },
        );
      },
    );
  }
}

class QuestionSelectStreamState extends StatefulWidget {
  final String entityID;
  // final TextEditingController controller;

  QuestionSelectStreamState(
      {@required this.entityID //, @required this.controller
      });
  @override
  _QuestionSelectStreamStateState createState() =>
      _QuestionSelectStreamStateState();
}

class _QuestionSelectStreamStateState extends State<QuestionSelectStreamState> {
  int totalQuestionStored = 0;

  @override
  void initState() {
    // TODO: implement initState
    totalQuestionStored =
        Provider.of<ProviderData>(context, listen: false).documentData.length;

    Provider.of<ProviderData>(context, listen: false).questionStored =
        totalQuestionStored;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DataBase()
          .getEntityData(entityID: widget.entityID, pageType: "page_1"),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          print("gggggggggggggg");
        }
        if (!snapshot.hasData) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            ),
          );
        }
        //to update total question in main Bar
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Add Your Code here.
          Provider.of<ProviderData>(context, listen: false)
              .changeTotal(snapshot.data.docs.length);
        });

        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 24),
          shrinkWrap: true,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            return QuestionSelectTileWidget(
              querySnapshot: snapshot.data.docs[index],
              currentIndex: index + totalQuestionStored, //
            );
          },
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Divider(),
          ),
        );
      },
    );
  }
}

//StreamBuilder(
//       stream:
//           DataBase().getEntityData(entityID: widget.entityID, pageType: "GIAE"),
//       builder: (context, AsyncSnapshot snapshot) {
//         if (snapshot.hasError) {
//           print("gggggggggggggg");
//         }
//         if (!snapshot.hasData) {
//           return Container(
//             child: Center(
//               child: CircularProgressIndicator(
//                 backgroundColor: Colors.lightBlueAccent,
//               ),
//             ),
//           );
//         }
//         return ListView.builder(
//           shrinkWrap: true,
//           itemCount: snapshot.data.docs[0].get("number_of_item"),
//           itemBuilder: (context, index) {
//             Provider.of<ProviderData>(context, listen: false)
//                 .controllers
//                 .add({"question": "", "answer": TextEditingController()});
//             return QuestionFormTileWidget(
//               questionTitle: snapshot.data.docs[0].get(questionName[index]),
//               controller: Provider.of<ProviderData>(context, listen: false)
//                   .controllers[index]["answer"],
//               currentIndex: index,
//             );
//           },
//         );
//       },
//     );
