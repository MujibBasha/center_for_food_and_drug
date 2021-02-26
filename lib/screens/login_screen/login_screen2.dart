import 'package:center_for_food_and_drug/components/login_registration_components/already_have_an_account_acheck.dart';

import 'package:center_for_food_and_drug/components/login_registration_components/rounded_button.dart';
import 'package:center_for_food_and_drug/components/login_registration_components/rounded_input_field.dart';
import 'package:center_for_food_and_drug/components/login_registration_components/rounded_password_field.dart';
import 'package:center_for_food_and_drug/localization/localization_constants.dart';

import 'package:center_for_food_and_drug/screens/login_screen/background.dart';
import 'package:center_for_food_and_drug/screens/main_screen/inst_dashboard_screen.dart';
import 'package:center_for_food_and_drug/screens/registration_screen/signup_screen.dart';
import 'package:center_for_food_and_drug/screens/reset_password_screen/reset_screen.dart';
// import 'package:center_for_food_and_drug/screens/reset_password_screen/reset_screen.dart';
import 'package:center_for_food_and_drug/tasks_provider/provider_data.dart';
import 'package:center_for_food_and_drug/widgets/local_notification_widget.dart';
import 'package:flutter/material.dart';

import 'package:center_for_food_and_drug/service/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:center_for_food_and_drug/service/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:center_for_food_and_drug/screens/main_screen/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static String id = "/LoginScreen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  bool visible = true;
  bool showNot = false;

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  bool hasNotAccount = false;

  final signInFormKey = GlobalKey<FormState>();
  Authentication authentication = Authentication();

  void savePref({bool isLogIn, String userID}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("isLogIn", isLogIn);
    preferences.setString("userID", userID);
    print("isLogIn===${preferences.getBool("isLogIn")}");
    // print("userID===${preferences.getString("userID")}");
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
                  getTranslated(
                      context: context,
                      key: "body_question_text",
                      typeScreen: "WillPopScope_content"),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  getTranslated(
                      context: context,
                      key: "close_app_hint",
                      typeScreen: "WillPopScope_content"),
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
                  // await deleteUserInformation().then(
                  //       (value) {
                  //     if (value) {
                  //       Navigator.of(context).pop(true);
                  //     }
                  //   },
                  // );
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
          body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Stack(
          children: [
            Background(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: size.height * 0.01),
                    Text(
                      "LOGIN",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ), // + size.height * 0.35), //+
                    //TODO Change this Image
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Image.asset(
                        "assets/images/main_login_screen.png",
                      ),
                    ),

                    SizedBox(height: size.height * 0.01),
                    Form(
                      key: signInFormKey,
                      child: Column(
                        children: [
                          RoundedInputField(
                            hintText: getTranslated(
                                context: context,
                                key: "your_email",
                                typeScreen: "login_screen"),
                            typeOfTextField: "Email",
                            // onChanged: (value) {},
                            controller: emailController,
                            validatorFunction: (value) {
                              var newValue = value.trimLeft();

                              if (newValue.isEmpty) {
                                return getTranslated(
                                    context: context,
                                    key: "empty_form",
                                    typeScreen: "login_screen");
                              }
                              //ToDO
                              // getUser(email: newValue);
                              //isUser(email: newValue);
                              return RegExp(
                                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                      .hasMatch(newValue)
                                  ? null //userInfo != null
                                  // ? null
                                  //: "That email address doesn't exist"
                                  : getTranslated(
                                      context: context,
                                      key: "invalid_email",
                                      typeScreen: "login_screen");
                              //check if the current email is equal to any email inside of database
                            },
                          ),
                          RoundedPasswordField(
                            passwordEditingController: passwordController,
                            // onChanged: (value) {},
                            validatorFunction: (value) {
                              var newValue = value.trimLeft();

                              if (newValue.isEmpty) {
                                return getTranslated(
                                    context: context,
                                    key: "empty_form",
                                    typeScreen: "login_screen");
                                ;
                              }
                              if (newValue.length >= 7) {
                                return null;
                              } else {
                                return getTranslated(
                                    context: context,
                                    key: "invalid_password",
                                    typeScreen: "login_screen");
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    RoundedButton(
                      color: Colors.blue,
                      text: getTranslated(
                          context: context,
                          key: "login_button",
                          typeScreen: "login_screen"),
                      press: () async {
                        FocusScope.of(context).unfocus();
                        print(
                            "===========================================> ${emailController.text},${passwordController.text}");

                        setState(() {
                          isLoading = true;
                        });
                        //TODO chick if their is internet connection
                        if (signInFormKey.currentState.validate()) {
                          try {
                            await authentication
                                .signInUser(
                                    email: emailController.text,
                                    password: passwordController.text)
                                .then((value) async {
                              print(
                                  "+++++++++++++++++++++++++++++++++++++==> ${emailController.text}");
                              print(
                                  "+++++++++++++++++++++++++++++++++++++==> ${passwordController.text}");
                              print(
                                  "+++++++++++++++++++++++++++++++++++++==> $value");
                              if (value != null) {
                                //get username By email
                                QuerySnapshot userInfo = await DataBase()
                                    .getUserByEmail(
                                        email: emailController.text);

                                String userId =
                                    "${await userInfo.docs[0].get("username")}-${emailController.text}";
                                Provider.of<ProviderData>(context,
                                        listen: false)
                                    .userID = userId;
                                //save local Data of user
                                savePref(isLogIn: true, userID: userId);
                                print("finshed form savePref");
                                //TODO Send To Main App
                                Navigator.pushReplacementNamed(
                                  context,
                                  InstDashboardScreen.id,
                                );
                              }
                              setState(() {
                                isLoading = false;
                              });
                            });
                          } catch (e) {
                            print(
                                "+++++++++++++++++++++++++++++++++++++==> $e");
                            setState(() {
                              isLoading = false;
                              visible = true;
                              hasNotAccount = true;
                            });
                          }
                        } else {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                    ),
                    Visibility(
                      visible: visible,
                      child: MaterialButton(
                        highlightColor: Colors.lightBlueAccent,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResetScreen(
                                  showNot: () {
                                    setState(() {
                                      showNot = true;
                                    });
                                  },
                                ),
                              ));
                          setState(() {
                            hasNotAccount = false;
                            showNot = false;
                          });
                        },
                        child: Text(
                          getTranslated(
                              context: context,
                              key: "forget_password",
                              typeScreen: "login_screen"),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    // AlreadyHaveAnAccountCheck(
                    //   login: true,
                    //   press: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) {
                    //           return SignUpScreen();
                    //         },
                    //       ),
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
            ),
            LocalNotificationWidget(
              visible: showNot,
              size: size,
              message:
                  "${getTranslated(context: context, key: "reset_password_local_notification", typeScreen: "login_screen")} ${Provider.of<ProviderData>(context).resetEmail}",
              closeNotificationWidget: () {
                setState(() {
                  showNot = false;
                });
              },
            ),
            LocalNotificationWidget(
              visible: hasNotAccount,
              size: size,
              closeNotificationWidget: () {
                setState(() {
                  hasNotAccount = false;
                });
              },
              message: getTranslated(
                  context: context,
                  key: "do_not_have_account_yet",
                  typeScreen: "login_screen"),
            ),
          ],
        ),
      )),
    );
  }
}
