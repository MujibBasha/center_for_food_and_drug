import 'package:center_for_food_and_drug/service/auth.dart';
import 'package:center_for_food_and_drug/tasks_provider/provider_data.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:center_for_food_and_drug/components/login_registration_components/rounded_button.dart';
import 'package:center_for_food_and_drug/components/login_registration_components/rounded_input_field.dart';
import 'package:center_for_food_and_drug/constants.dart';

import 'package:center_for_food_and_drug/screens/login_screen/background.dart';
import 'package:center_for_food_and_drug/service/auth.dart';
import 'package:center_for_food_and_drug/widgets/local_notification_widget.dart';

class ResetScreen extends StatefulWidget {
  final Function showNot;
  ResetScreen({this.showNot});
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  bool isLoading = false;
  bool showLocalNotification = false;
  final signInFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  Authentication authentication = Authentication();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Stack(
        children: [
          Background(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Reset Password",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ),
                  //TODO display image
                  // SvgPicture.asset(
                  //   "assets/icons/login.svg",
                  //   height: size.height * 0.35,
                  // ),
                  Form(
                    key: signInFormKey,
                    child: RoundedInputField(
                      typeOfTextField: "Email",
                      icon: Icons.email_outlined,
                      hintText: "Your Email",
                      controller: emailController,
                      validatorFunction: (value) {
                        var newValue = value.trimLeft();

                        if (newValue.isEmpty) {
                          return "Please Provide a valid Email";
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
                            : "Please provide a valid Email";
                        //check if the current email is equal to any email inside of database
                      },
                    ),
                  ),
                  RoundedButton(
                    color: Colors.blue,
                    text: "Submit",
                    press: () async {
                      FocusScope.of(context).unfocus();
                      // print("===========================================>");
                      // print(
                      //     "===========================================> ${emailController.text},${passwordController.text}");

                      setState(() {
                        isLoading = true;
                      });
                      if (signInFormKey.currentState.validate()) {
                        try {
                          await authentication
                              .sendPasswordResetEmail(
                                  email: emailController.text)
                              .then((value) {
                            Provider.of<ProviderData>(context, listen: false)
                                .resetEmail = emailController.text;

                            setState(() {
                              isLoading = false;
                            });
                            //TODO send uer to sign in screen
                            Navigator.pop(context);
                            //TODO show message till him the URL send to your email
                            widget.showNot();
                          });
                        } catch (e) {
                          //to show screen to
                          setState(() {
                            showLocalNotification = true;
                          });

                          print("+++++++++++++++++++++++++++++++++++++==> $e");
                          setState(() {
                            isLoading = false;
                            // visible = true;
                          });
                        }
                      } else {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                  MaterialButton(
                    highlightColor: Colors.white24,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Return to Sign in",
                      style: TextStyle(
                        //color: kPrimaryColor
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          LocalNotificationWidget(
            visible: showLocalNotification,
            size: size,
            message:
                "There is no user record\ncorresponding to this identifier.\nThe user may have been deleted.",
            closeNotificationWidget: () {
              setState(() {
                showLocalNotification = false;
              });
            },
          ),
        ],
      ),
    ));
  }
}
