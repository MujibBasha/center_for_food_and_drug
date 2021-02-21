import 'package:center_for_food_and_drug/components/login_registration_components/already_have_an_account_acheck.dart';
import 'package:center_for_food_and_drug/components/login_registration_components/rounded_button.dart';
import 'package:center_for_food_and_drug/components/login_registration_components/rounded_input_field.dart';
import 'package:center_for_food_and_drug/components/login_registration_components/rounded_password_field.dart';
import 'package:center_for_food_and_drug/localization/localization_constants.dart';
// import 'package:center_for_food_and_drug/localization/localization_constants.dart';
// import 'package:center_for_food_and_drug/models/task_data.dart';
//center_for_food_and_drug  center_for_food_and_drug

import 'package:center_for_food_and_drug/screens/login_screen/login_screen2.dart';
import 'package:center_for_food_and_drug/screens/main_screen/inst_dashboard_screen.dart';
import 'package:center_for_food_and_drug/screens/registration_screen/background.dart';
import 'package:center_for_food_and_drug/screens/registration_screen/or_divider.dart';
import 'package:center_for_food_and_drug/screens/registration_screen/social_icon.dart';
// import 'package:center_for_food_and_drug/screens/verify_screen/verification_screen.dart';
import 'package:center_for_food_and_drug/service/auth.dart';
import 'package:center_for_food_and_drug/service/database.dart';
import 'package:center_for_food_and_drug/tasks_provider/provider_data.dart';
import 'package:center_for_food_and_drug/widgets/local_notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:center_for_food_and_drug/widgets/checkbox_form_field.dart';
// import 'package:center_for_food_and_drug/screens/user_info_screen/private_policy_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isLoading = false;
  bool showNotification = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController institutionName = TextEditingController();
  TextEditingController userIDNumber = TextEditingController();

  final signUpFormKey = GlobalKey<FormState>();
  Authentication authentication = Authentication();

  void savePref({bool isLogIn, String userID}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("isLogIn", isLogIn);
    preferences.setString("userID", userID);
    print("isLogIn===${preferences.getBool("isLogIn")}");
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
                      // Text(
                      //   "SIGNUP",
                      //   style: TextStyle(fontWeight: FontWeight.bold),
                      // ),
                      SizedBox(height: size.height * 0.01),
                      //ToDO
                      SvgPicture.asset(
                        "assets/icons/signup.svg",
                        height: size.height * 0.32,
                      ),

                      Form(
                        key: signUpFormKey,
                        child: Column(
                          children: [
                            RoundedInputField(
                              hintText: getTranslated(
                                  context: context,
                                  key: "username",
                                  typeScreen: "sign_up_screen"),
                              typeOfTextField: "username",
                              validatorFunction: (value) {
                                var newValue = value.trimLeft();
                                if (newValue.isEmpty) {
                                  return getTranslated(
                                      context: context,
                                      key: "empty_form",
                                      typeScreen: "login_screen");
                                } else if (newValue.length < 4) {
                                  return getTranslated(
                                      context: context,
                                      key: "invalid_username",
                                      typeScreen: "sign_up_screen");
                                } else {
                                  return null;
                                }
                              },
                              controller: usernameController,
                            ),
                            RoundedInputField(
                              icon: Icons.email_outlined,
                              typeOfTextField: "Email",
                              hintText: getTranslated(
                                  context: context,
                                  key: "your_email",
                                  typeScreen: "sign_up_screen"),
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

                                return RegExp(
                                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                        .hasMatch(newValue)
                                    ? null
                                    : getTranslated(
                                        context: context,
                                        key: "invalid_email",
                                        typeScreen: "sign_up_screen");
                              },
                            ),
                            RoundedInputField(
                              icon: Icons.business_center_outlined,
                              hintText: "The name of the office or branch",
                              // getTranslated(
                              //     context: context,
                              //     key: "username",
                              //     typeScreen: "sign_up_screen"),
                              typeOfTextField: "username",
                              validatorFunction: (value) {
                                var newValue = value.trimLeft();
                                if (newValue.isEmpty) {
                                  return getTranslated(
                                      context: context,
                                      key: "empty_form",
                                      typeScreen: "login_screen");
                                } else if (newValue.length < 4) {
                                  return getTranslated(
                                      context: context,
                                      key: "invalid_username",
                                      typeScreen: "sign_up_screen");
                                } else {
                                  return null;
                                }
                              },
                              controller: institutionName,
                            ),
                            RoundedInputField(
                              icon: Icons.assignment_ind_outlined,
                              hintText: "your ID number",
                              // getTranslated(
                              //     context: context,
                              //     key: "username",
                              //     typeScreen: "sign_up_screen"),
                              typeOfTextField: "username",
                              validatorFunction: (value) {
                                var newValue = value.trimLeft();
                                if (newValue.isEmpty) {
                                  return getTranslated(
                                      context: context,
                                      key: "empty_form",
                                      typeScreen: "login_screen");
                                } else if (newValue.length < 4) {
                                  return getTranslated(
                                      context: context,
                                      key: "invalid_username",
                                      typeScreen: "sign_up_screen");
                                } else {
                                  return null;
                                }
                              },
                              controller: userIDNumber,
                            ),
                            RoundedPasswordField(
                              // onChanged: (value) {},
                              validatorFunction: (value) {
                                var newValue = value.trimLeft();

                                if (newValue.isEmpty) {
                                  return getTranslated(
                                      context: context,
                                      key: "empty_form",
                                      typeScreen: "login_screen");
                                }
                                if (newValue.length >= 7) {
                                  return null;
                                } else {
                                  return getTranslated(
                                      context: context,
                                      key: "invalid_password",
                                      typeScreen: "sign_up_screen");
                                  "Please provide password with +7 Character";
                                }
                              },
                              passwordEditingController: passwordController,
                            ),
                            CheckboxFormField(
                              title: Row(
                                children: [
                                  Text(
                                    getTranslated(
                                        context: context,
                                        key: "terms_part1",
                                        typeScreen: "sign_up_screen"),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print("clicked on Terms of Services");
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         PrivatePolicyScreen(),
                                      //   ),
                                      // );
                                    },
                                    child: Text(
                                      getTranslated(
                                          context: context,
                                          key: "terms_part2",
                                          typeScreen: "sign_up_screen"),
                                      style: TextStyle(color: Colors.lightBlue),
                                    ),
                                  ),
                                ],
                              ),
                              validator: (bool value) {
                                if (value == true) {
                                  return null;
                                } else {
                                  return getTranslated(
                                      context: context,
                                      key: "unchecked_term_and",
                                      typeScreen: "sign_up_screen");
                                }
                              },
                            ),
                          ],
                        ),
                      ),

                      RoundedButton(
                        color: Colors.pink.shade900,
                        text: getTranslated(
                            context: context,
                            key: "sign_up_button",
                            typeScreen: "sign_up_screen"),
                        press: () async {
                          FocusScope.of(context).unfocus();
                          setState(() {
                            isLoading = true;
                          });

                          if (signUpFormKey.currentState.validate()) {
                            try {
                              await authentication
                                  .signUpNewUser(
                                      email: emailController.text,
                                      password: passwordController.text)
                                  .then((value) async {
                                if (value != null) {
                                  String userId =
                                      "${usernameController.text}-${emailController.text}";

                                  var deviceToken = await FirebaseNotification()
                                      .getUserDeviceToken();

                                  // Send userId To Provider
                                  Provider.of<ProviderData>(
                                    context,
                                    listen: false,
                                  ).userID = userId;
                                  Provider.of<ProviderData>(context,
                                          listen: false)
                                      .inputEmail = emailController.text;

                                  Map<String, dynamic> userInfoMap = {
                                    "email": "${emailController.text}",
                                    "full_name": "${usernameController.text}",
                                    "password": "${passwordController.text}",
                                    "id_number": "${userIDNumber.text}",
                                    "phone_number": "null", //"${phoneNa.text}",
                                    "office_name": "${institutionName.text}",
                                    "user_id": "$userId",
                                    "deviceToken": deviceToken,
                                  };
                                  print(userInfoMap);
                                  //TODO fix this ex

                                  await DataBase().addUserInfo(
                                      userInfoMap: userInfoMap, userId: userId);

                                  //this method to save user data forever
                                  await DataBase()
                                      .saveUserData(userInfoMap: userInfoMap);

                                  print(userInfoMap);
                                  // savePref(isLogIn: false, userID: userId);
                                  //TODO Send To verification screen
                                  Navigator.pushNamed(
                                      context, InstDashboardScreen.id);
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                                setState(() {
                                  isLoading = false;
                                });
                              });
                            } catch (e) {
                              print(
                                  "+++++++++++++++++++++++++++++++++++++++++++>$e");
                              setState(() {
                                isLoading = false;
                                showNotification = true;
                              });
                            }
                          } else {
                            setState(
                              () {
                                isLoading = false;
                              },
                            );
                          }
                        },
                      ),
                      SizedBox(height: size.height * 0.01),
                      AlreadyHaveAnAccountCheck(
                        login: false,
                        press: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      // OrDivider(),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: <Widget>[
                      //     SocalIcon(
                      //       iconSrc: "assets/icons/facebook.svg",
                      //       press: () {},
                      //     ),
                      //     SocalIcon(
                      //       iconSrc: "assets/icons/twitter.svg",
                      //       press: () {},
                      //     ),
                      //     SocalIcon(
                      //       iconSrc: "assets/icons/google-plus.svg",
                      //       press: () {},
                      //     ),
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
              LocalNotificationWidget(
                visible: showNotification,
                size: size,
                closeNotificationWidget: () {
                  setState(() {
                    showNotification = false;
                  });
                },
                message: getTranslated(
                    context: context,
                    key: "local_notification",
                    typeScreen: "sign_up_screen"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
