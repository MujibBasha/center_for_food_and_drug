import 'dart:io';
import 'dart:ui';

import 'package:center_for_food_and_drug/localization/localization_constants.dart';
import 'package:center_for_food_and_drug/screens/main_screen/inst_dashboard_screen.dart';
import 'package:center_for_food_and_drug/tasks_provider/provider_data.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:dsc_hackathon_pp/localization/localization_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';
import 'package:bot_toast/bot_toast.dart';

const kPrimaryColor = Colors.lightBlueAccent;
const kPrimaryLightColor = Color(0xFFF1E6FF);

class PlayEmployeeQuestionScreen extends StatefulWidget {
  @override
  _PlayEmployeeQuestionScreenState createState() =>
      _PlayEmployeeQuestionScreenState();
}

class _PlayEmployeeQuestionScreenState
    extends State<PlayEmployeeQuestionScreen> {
  bool isLoading = false;

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController descriptionsController = TextEditingController();
  TextEditingController officeNameController = TextEditingController();
  GlobalKey<ScaffoldState> employeeInfoScaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> employeeInfoFormKey = GlobalKey<FormState>();
  void showSnackBar({
    @required String text,
    @required bool isSucceeded,
  }) {
    // ignore: deprecated_member_use
    employeeInfoScaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: TextStyle(
            color: isSucceeded ? Colors.white : Colors.redAccent.shade200,
          ),
        ),
        backgroundColor: Color(0XFF25347b),
      ),
    );

    setState(() {
      if (isSucceeded) {
        emailController.clear();
        fullNameController.clear();
        phoneNumberController.clear();
        descriptionsController.clear();
      }
    });
  }

  pw.Document pdf = pw.Document();
  // final PdfImage assetImage = await pdfImageFromImageProvider(
  // pdf: pdf.document,
  // image: const AssetImage('assets/test.jpg'),
  // );
  // final image = pw.ImageProvider(
  //   pw.ImageProvider("PdfLogo.png"),
  // );
  writeOnPdf(BuildContext con) {
    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(32),
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        header: (pw.Context context) {
          print("start_wirte PDF");
          if (context.pageNumber == 1) {
            return null;
          }
          return pw.Container(
              alignment: pw.Alignment.centerRight,
              margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
              padding: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
              decoration: const pw.BoxDecoration(
                //TODO
                color: PdfColors.grey,
                border: pw.Border(
                  left: pw.BorderSide.none,
                  right: pw.BorderSide.none,
                  top: pw.BorderSide.none,
                ),
                // left: pw.BorderSide.none,right:pw.BorderSide.none,top:pw.BorderSide.none,
              ),
              child: pw.Text('Report',
                  style: pw.Theme.of(context)
                      .defaultTextStyle
                      .copyWith(color: PdfColors.grey)));
        },
        footer: (pw.Context context) {
          return pw.Container(
              alignment: pw.Alignment.centerRight,
              margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
              child: pw.Text(
                  'Page ${context.pageNumber} of ${context.pagesCount}',
                  style: pw.Theme.of(context)
                      .defaultTextStyle
                      .copyWith(color: PdfColors.grey)));
        },
        build: (pw.Context context) {
          print("start_wirte PDF builder");
          return <pw.Widget>[
            pw.Header(
                level: 0,
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: <pw.Widget>[
                      pw.Text('Report', textScaleFactor: 2),
                      pw.Text("Icon"),
                    ])),
            pw.Header(level: 1, text: 'General Info About Entity'),
            pw.ListView.builder(
                itemCount: Provider.of<ProviderData>(con, listen: false)
                    .generalEntityInfoDocumentData
                    .length,
                itemBuilder: (pw.Context pwContext, index) {
                  print("start_wirte PDF listview.builder");
                  return pw.Container(
                      padding: pw.EdgeInsets.all(10),
                      child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: <pw.Widget>[
                            pw.Header(
                                level: 2,
                                text: Provider.of<ProviderData>(con,
                                            listen: false)
                                        .generalEntityInfoDocumentData[index]
                                    ["question"],
                                textStyle: pw.TextStyle(fontSize: 18)),
                            pw.Header(
                                level: 3,
                                text: Provider.of<ProviderData>(con,
                                            listen: false)
                                        .generalEntityInfoDocumentData[index]
                                    ["answer"],
                                textStyle: pw.TextStyle(
                                    fontSize: 16, color: PdfColors.grey)),
                          ]));
                }),
            pw.SizedBox(height: 40),
            pw.Header(level: 1, text: ''),
            pw.Header(level: 1, text: 'Report Information'),
            pw.ListView.builder(
                itemCount: Provider.of<ProviderData>(con, listen: false)
                    .reportInfoDocumentData
                    .length,
                itemBuilder: (pw.Context pwContext, index) {
                  print("start_wirte PDF listview.builder");
                  return pw.Container(
                      padding: pw.EdgeInsets.all(10),
                      child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: <pw.Widget>[
                            pw.Header(
                                level: 2,
                                text: Provider.of<ProviderData>(con,
                                        listen: false)
                                    .reportInfoDocumentData[index]["question"],
                                textStyle: pw.TextStyle(fontSize: 18)),
                            pw.Header(
                                level: 3,
                                text: Provider.of<ProviderData>(con,
                                        listen: false)
                                    .reportInfoDocumentData[index]["answer"],
                                textStyle: pw.TextStyle(
                                    fontSize: 16, color: PdfColors.grey)),
                          ]));
                }),

            //printing employee information
            pw.Header(level: 1, text: 'Employee Information'),

            pw.Row(children: [
              pw.Header(
                  level: 2,
                  text: "FullName: ",
                  textStyle: pw.TextStyle(fontSize: 18)),
              pw.Header(
                  level: 3,
                  text: fullNameController.text,
                  textStyle: pw.TextStyle(fontSize: 16, color: PdfColors.grey)),
            ]),
            pw.Row(children: [
              pw.Header(
                  level: 2,
                  text: "Email: ",
                  textStyle: pw.TextStyle(fontSize: 18)),
              pw.Header(
                  level: 3,
                  text: emailController.text,
                  textStyle: pw.TextStyle(fontSize: 16, color: PdfColors.grey)),
            ]),

            pw.Row(children: [
              pw.Header(
                  level: 2,
                  text: "PhoneNumber: ",
                  textStyle: pw.TextStyle(fontSize: 18)),
              pw.Header(
                  level: 3,
                  text: phoneNumberController.text,
                  textStyle: pw.TextStyle(fontSize: 16, color: PdfColors.grey)),
            ]),
            pw.Row(children: [
              pw.Header(
                  level: 2,
                  text: "Office Name: ",
                  textStyle: pw.TextStyle(fontSize: 18)),
              pw.Header(
                  level: 3,
                  text: officeNameController.text,
                  textStyle: pw.TextStyle(fontSize: 16, color: PdfColors.grey)),
            ]),
            pw.SizedBox(height: 20),
            pw.Header(level: 1, text: 'Note From Employee'),
            pw.Paragraph(
              text: descriptionsController.text,
            )
          ];
        }));
  }

  Future savePdf() async {
    print("start_save PDF");
    Directory documentDirectory =
        await getExternalStorageDirectory(); //getApplicationDocumentsDirectory
    String documentPath = documentDirectory.path;
    print("Path==> $documentPath");
    final String path = "$documentPath/qqqooo.pdf";
    File file = File(path);
    // file.writeAsBytesSync(await pdf.save());
    await file.writeAsBytes(await pdf.save());
  }

  @override
  void dispose() {
    print("dispose of employee");
    fullNameController.clear();
    emailController.clear();

    descriptionsController.clear();
    officeNameController.clear();
    phoneNumberController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                  // Provider.of<ProviderData>(context, listen: false)
                  //     .documentData
                  //     .clear();
                  // Provider.of<ProviderData>(context, listen: false)
                  //     .controllers
                  //     .clear();
                  // pdf.
                  Navigator.of(context).pop(true);
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
        key: employeeInfoScaffoldKey,
        appBar: AppBar(
          title: Text("Employee Info"),
          centerTitle: true,
        ),
        body: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Container(
            alignment: AlignmentDirectional.center,
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Your",

                            // getTranslated(
                            //     context: context,
                            //     key: "app_name_part1",
                            //     typeScreen: "general_content"),
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            "Information",
                            // getTranslated(
                            //     context: context,
                            //     key: "app_name_part2",
                            //     typeScreen: "general_content"),
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightBlueAccent.shade400),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Form(
                        key: employeeInfoFormKey,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              width: size.width * 0.8,
                              decoration: BoxDecoration(
                                color: kPrimaryLightColor,
                                borderRadius: BorderRadius.circular(29),
                              ),
                              child: TextFormField(
                                autocorrect: false,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                validator: (value) {
                                  var newValue = value.trimLeft();
                                  if (newValue.isEmpty) {
                                    return "this field is required";
                                    // getTranslated(
                                    //   context: context,
                                    //   key: "invalid_book_name",
                                    //   typeScreen: "connect_with_us_screen");
                                  } else if (newValue.length < 4) {
                                    return "Please Provide a valid username with 6+ Character";
                                    getTranslated(
                                        context: context,
                                        key: "invalid_book_name_length",
                                        typeScreen: "connect_with_us_screen");
                                  } else {
                                    return null;
                                  }
                                },
                                // // onChanged: onChanged,
                                controller: fullNameController,
                                keyboardType: TextInputType.name,
                                cursorColor: kPrimaryColor,
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.drive_file_rename_outline,
                                    color: kPrimaryColor,
                                  ),
                                  labelText: "Full Name",
                                  hintText: "Full Name",
                                  // getTranslated(
                                  //     context: context,
                                  //     key: "username",
                                  //     typeScreen: "connect_with_us_screen"),

                                  hintStyle: TextStyle(
                                    color: Colors.black38,
                                  ),

                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              width: size.width * 0.8,
                              decoration: BoxDecoration(
                                color: kPrimaryLightColor,
                                borderRadius: BorderRadius.circular(29),
                              ),
                              child: TextFormField(
                                autocorrect: false,
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                                validator: (value) {
                                  var newValue = value.trimLeft();
                                  if (newValue.isEmpty) {
                                    return getTranslated(
                                        context: context,
                                        key: "invalid_email",
                                        typeScreen: "connect_with_us_screen");
                                  }

                                  return RegExp(
                                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                          .hasMatch(newValue)
                                      ? null
                                      : getTranslated(
                                          context: context,
                                          key: "invalid_email",
                                          typeScreen: "connect_with_us_screen");
                                },
                                // // onChanged: onChanged,
                                controller: emailController,
                                cursorColor: kPrimaryColor,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.email,
                                    color: kPrimaryColor,
                                  ),
                                  labelText: "Email",
                                  hintText: getTranslated(
                                      context: context,
                                      key: "your_email",
                                      typeScreen: "connect_with_us_screen"),
                                  hintStyle: TextStyle(
                                    color: Colors.black38,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              width: size.width * 0.8,
                              decoration: BoxDecoration(
                                color: kPrimaryLightColor,
                                borderRadius: BorderRadius.circular(29),
                              ),
                              child: TextFormField(
                                autocorrect: false,
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                                validator: (value) {
                                  var newValue = value.trimLeft();
                                  if (newValue.isEmpty) {
                                    return "this field is required";
                                    // getTranslated(
                                    //   context: context,
                                    //   key: "invalid_book_name",
                                    //   typeScreen: "connect_with_us_screen");
                                  } else if (newValue.length < 1) {
                                    return "Please Provide a valid Offic Name";
                                    getTranslated(
                                        context: context,
                                        key: "invalid_book_name_length",
                                        typeScreen: "connect_with_us_screen");
                                  } else {
                                    return null;
                                  }
                                },
                                // // onChanged: onChanged,
                                controller: officeNameController,
                                keyboardType: TextInputType.name,
                                cursorColor: kPrimaryColor,
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.drive_file_rename_outline,
                                    color: kPrimaryColor,
                                  ),
                                  labelText: "Office Name",
                                  hintText: "Office Name",
                                  // getTranslated(
                                  //     context: context,
                                  //     key: "username",
                                  //     typeScreen: "connect_with_us_screen"),

                                  hintStyle: TextStyle(
                                    color: Colors.black38,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              width: size.width * 0.8,
                              decoration: BoxDecoration(
                                color: kPrimaryLightColor,
                                borderRadius: BorderRadius.circular(29),
                              ),
                              child: TextFormField(
                                autocorrect: false,
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                                validator: (value) {
                                  var newValue = value.trimLeft();
                                  if (newValue.isEmpty) {
                                    return "this section is required";
                                    // getTranslated(
                                    //   context: context,
                                    //   key: "required_field",
                                    //   typeScreen: "general_content");
                                  } else if (newValue.length < 10) {
                                    return "Please Provide a valid Phone Number ex:0911234567";
                                    // getTranslated(
                                    //   context: context,
                                    //   key: "required_field_length",
                                    //   typeScreen: "connect_with_us_screen");
                                  } else {
                                    return null;
                                  }
                                },
                                // // onChanged: onChanged,
                                controller: phoneNumberController,
                                keyboardType: TextInputType.text,
                                cursorColor: kPrimaryColor,
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.phone,
                                    color: kPrimaryColor,
                                  ),
                                  hintText: "Phone Number",
                                  labelText: "Your Number",
                                  // getTranslated(
                                  //     context: context,
                                  //     key: "subject",
                                  //     typeScreen: "connect_with_us_screen"),
                                  hintStyle: TextStyle(
                                    color: Colors.black38,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 65),
                              width: size.width * 0.8,
                              decoration: BoxDecoration(
                                color: kPrimaryLightColor,
                                borderRadius: BorderRadius.circular(29),
                              ),
                              child: TextFormField(
                                autocorrect: false,
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                                validator: (value) {
                                  var newValue = value.trimLeft();
                                  return null;
                                  // if (newValue.isEmpty) {
                                  //   return getTranslated(
                                  //       context: context,
                                  //       key: "required_field",
                                  //       typeScreen: "general_content");
                                  // } else if (newValue.length < 4) {
                                  //   return getTranslated(
                                  //       context: context,
                                  //       key: "required_field_length",
                                  //       typeScreen: "invalid_username");
                                  // } else {
                                  //
                                  // }
                                },
                                // // onChanged: onChanged,
                                controller: descriptionsController,
                                keyboardType: TextInputType.text,
                                cursorColor: kPrimaryColor,
                                decoration: InputDecoration(
                                  // icon: Icon(
                                  //   ,
                                  //   color: kPrimaryColor,
                                  // ),
                                  labelText: "optional",
                                  hintText: getTranslated(
                                      context: context,
                                      key: "descriptions",
                                      typeScreen: "connect_with_us_screen"),

                                  hintStyle: TextStyle(
                                    color: Colors.black38,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            elevation: 15,
            backgroundColor: Colors.blue,
            child: Icon(Icons.save, color: Colors.white), //check_outlined
            onPressed: () async {
              try {
                setState(() {
                  isLoading = true;
                });
                //TODO send Data
                FocusScope.of(context).unfocus();

                final status = await Permission.storage.request();
                if (status.isGranted) {
                  if (employeeInfoFormKey.currentState.validate()) {
                    writeOnPdf(context);
                    await savePdf();
                    //to clear the last document  and update new value inside of it
                    pdf = pw.Document();
                    BotToast.showText(
                        text: "The Report Saved Successfully",
                        contentColor: Colors.lightBlueAccent);
                    showDialog(
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
                              "Back To Dashboard ?",
                              // getTranslated(
                              //     context: context,
                              //     key: "body_question_text",
                              //     typeScreen: "WillPopScope_content"),
                              //"GO TO"
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            // Text(
                            //   "you will lose the current data",
                            //   // getTranslated(
                            //   //     context: context,
                            //   //     key: "close_app_hint",
                            //   //     typeScreen: "WillPopScope_content"),
                            //   style: TextStyle(
                            //     color: Colors.white,
                            //   ),
                            // ),
                          ],
                        ),
                        actions: [
                          FlatButton(
                            onPressed: () async {
                              // Provider.of<ProviderData>(context, listen: false)
                              //     .documentData
                              //     .clear();
                              // Provider.of<ProviderData>(context, listen: false)
                              //     .controllers
                              //     .clear();
                              // pdf.
                              Navigator.of(context).pop(true);
                              Navigator.popUntil(context,
                                  ModalRoute.withName(InstDashboardScreen.id));
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

                    print("SSSSSSSSSSSSsss");
                    // Map<String, Object> data = {
                    // "subject": phoneNumberController.text ?? "null",
                    // "descriptions":
                    // descriptionsController.text ?? "null",
                    //
                    // //TODO add user Info here
                    // "email_user": emailController.text ?? "null",
                    // "username_user":
                    // fullNameController.text ?? "null",
                    // "email": Provider.of<ProviderData>(context,
                    // listen: false)
                    //     .email ??
                    // "naull",
                    // "username": Provider.of<ProviderData>(context,
                    // listen: false)
                    //     .username ??
                    // "naull",
                    // };
                    // await DataBase()
                    //     .addData(
                    // dataType: "Connect_With_Us_Content",
                    // data: data)
                    //     .then((value) {
                    // if (value) {
                    // setState(() {
                    // showSnackBar(
                    // text: getTranslated(
                    // context: context,
                    // key: "send_completed",
                    // typeScreen: "general_content"),
                    // isSucceeded: true);
                    // });
                    // } else {
                    // setState(() {
                    // showSnackBar(
                    // text: getTranslated(
                    // context: context,
                    // key: "send_failed",
                    // typeScreen: "general_content"),
                    // isSucceeded: false);
                    // });
                    // }
                    // });

                    setState(() {
                      isLoading = false;
                    });
                  } else {
                    setState(() {
                      isLoading = false;
                    });
                  }
                }
              } catch (e) {
                setState(() {
                  isLoading = false;
                });
                print(e);
              }
            }),
      ),
    );

    //
    //   Scaffold(
    //   appBar: AppBar(
    //     title: Text("Employee Info"),
    //     centerTitle: true,
    //   ),
    //   // key: scaffoldAddMembersScreen,
    //   backgroundColor: Color(0XFF111b47), //0XFF0A0E21
    //   body: Container(
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.stretch,
    //       children: [
    //         // Container(
    //         //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
    //         //   child: ListView(children: [
    //         //     MainBar(
    //         //       text: "Pages",
    //         //       number: "2/3",
    //         //     ),
    //         //     SizedBox(
    //         //       width: 15,
    //         //     ),
    //         //     Selector<ProviderData, int>(
    //         //       selector: (context, data) => data.totalCurrentQuestion,
    //         //       builder: (context, total, child) {
    //         //         return MainBar(
    //         //           text: "Total Question",
    //         //           number: "$total",
    //         //         );
    //         //       },
    //         //     ),
    //         //     SizedBox(
    //         //       width: 15,
    //         //     ),
    //         //     Selector<ProviderData, int>(
    //         //       selector: (context, data) => data.totalCurrentQuestion,
    //         //       builder: (context, total, child) {
    //         //         return MainBar(
    //         //           text: "answered",
    //         //           number: "0/$total",
    //         //         );
    //         //       },
    //         //     ),
    //         //   ]),
    //         // ),
    //         Expanded(
    //           child: QuestionSelectStreamState(entityID: widget.entityID),
    //         ),
    //       ],
    //     ),
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     elevation: 15,
    //     backgroundColor: Colors.blue,
    //     child: Icon(Icons.check_outlined, color: Colors.white),
    //     onPressed: () {
    //       //TODO add ability to upload image to firebase from user and add this image inside the app by manager
    //       // print(Provider.of<ProviderData>(context, listen: false).documentData);
    //       //TODO send question Data and employee Data to DataBase
    //     },
    //   ),
    // );
  }
}
