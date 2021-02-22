import 'package:center_for_food_and_drug/localization/localization_constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
// import 'package:dsc_hackathon_pp/localization/localization_constants.dart';

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
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
          child: Icon(Icons.check_outlined, color: Colors.white),
          onPressed: () async {
            try {
              setState(() {
                isLoading = true;
              });
              //TODO send Data
              FocusScope.of(context).unfocus();

              if (employeeInfoFormKey.currentState.validate()) {
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
            } catch (e) {
              setState(() {
                isLoading = false;
              });
              print(e);
            }
          }),
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
