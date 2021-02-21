import 'dart:async';

import 'package:center_for_food_and_drug/localization/localization_constants.dart';
import 'package:center_for_food_and_drug/screens/main_screen/inst_dashboard_screen.dart';
import 'package:center_for_food_and_drug/tasks_provider/provider_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:center_for_food_and_drug/service/auth.dart';
import 'package:center_for_food_and_drug/service/database.dart';
import 'package:center_for_food_and_drug/widgets/local_notification_widget.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:shared_preferences/shared_preferences.dart';

class VerificationScreen extends StatefulWidget {
  static final id = "VerificationScreen";
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  User user;
  bool isForward = false;

  Authentication authentication = Authentication();
  Timer timer;

  bool visible = false;
  bool showNotification = false;

  final verificationScaffoldKey = GlobalKey<ScaffoldState>();

  String gifImage = "assets/images/first.gif";

  void savePref({bool isLogIn}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("isLogIn", isLogIn);
    print("isLogIn===${preferences.getBool("isLogIn")}");
  }

  Future<void> checkEmailVerified() async {
    try {
      print("call");
      user = authentication.getCurrentUser();
      await user.reload();
      if (user.emailVerified) {
        timer.cancel();
        //TODO show to Ui Something
        setState(() {
          gifImage = "assets/images/1.gif";
          isForward = true;
        });

        await Future.delayed(const Duration(seconds: 3));
        savePref(isLogIn: true);
        Navigator.pushReplacementNamed(
            context, InstDashboardScreen.id); // DashboardScreen.id);
      }
    } catch (e) {
      print(e);
      setState(() {
        visible = true;
        showNotification = true;
      });
    }
  }

  Future<bool> deleteUserInformation() async {
    try {
      timer.cancel();
      print(
          "+++++++++++++++++++++++++++++++++ $user ${Provider.of<ProviderData>(context, listen: false).userID}");
      await authentication.deleteCurrentUser();
      await DataBase().removeUserInfo(
          userId: Provider.of<ProviderData>(context, listen: false).userID);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  void dispose() {
    print("dispose");
    timer.cancel();
    // if (!isForward) {
    //   //todo delete account
    //   deleteUserInformation().then((value) {
    //     print("ok");
    //   });
    //}
    super.dispose();
  }

  @override
  void initState() {
    try {
      user = authentication.getCurrentUser();
      user.sendEmailVerification();

      timer = Timer.periodic(
        Duration(seconds: 2),
        (timer) {
          checkEmailVerified();
        },
      );
    } catch (e) {
      print(e);
      setState(() {
        visible = true;
        showNotification = true;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // const double horizontalPadding = width * 0.08775;
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
                      key: "body_answer_text",
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
                  await deleteUserInformation().then(
                    (value) {
                      if (value) {
                        Navigator.of(context).pop(true);
                      }
                    },
                  );
                  setState(() {
                    showNotification = false;
                  });
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
            backgroundColor: Colors.blue.shade700,
          ),
        );
      },
      child: Scaffold(
        key: verificationScaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                width: size.width,
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text(
                        getTranslated(
                            context: context,
                            key: "head_text",
                            typeScreen: "verification_screen"),
                        style: TextStyle(
                          color: Colors.pink,
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      // SizedBox(
                      //   height: size.height * 0.050143,
                      // ),
                      Container(
                        child: Image.asset(
                          gifImage,
                        ),
                      ),
                      // SizedBox(
                      //   height: size.height * 0.050143,
                      // ),
                      Text(
                        "${getTranslated(context: context, key: "send_email_hint_part1", typeScreen: "verification_screen")} ${Provider.of<ProviderData>(context, listen: false).inputEmail}\n${getTranslated(context: context, key: "send_email_hint_part2", typeScreen: "verification_screen")}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.1 * 4,
                      ),
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(top: size.height * 0.5),
              //   child: ClipPath(
              //     clipper: VerifiyClipper(
              //         controllerPoint:
              //             Offset(size.width * 0.55, size.height * 0.15)),
              //     child: Container(
              //       decoration: BoxDecoration(
              //         gradient: LinearGradient(
              //           begin: Alignment.topLeft,
              //           end: Alignment.topRight,
              //           colors: [
              //             Colors.lightBlueAccent,
              //             Colors.tealAccent,
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.5),
                child: ClipPath(
                  clipper: VerifiyClipper(
                      controllerPoint:
                          Offset(size.width * 0.5, size.height * 0.15)),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                        colors: [
                          Color(0XFF0A0E21),
                          Colors.pink.shade900,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.5),
                child: ClipPath(
                  clipper: VerifiyClipper(
                      controllerPoint:
                          Offset(size.width * 0.55, size.height * 0.17)),
                  child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topRight,
                          colors: [
                            //Colors.tealAccent.shade400,
                            Color(0XFF0A0E21),

                            Colors.pink.shade900,
                            // Color(0xffEB1555),
                            //Colors.lightBlueAccent,
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: size.height * 0.025,
                          ),
                          // SpinKitWave(
                          //   color: Colors.black26,
                          //   size: 40.0,
                          // ),
                          SizedBox(
                            width: size.width,
                            height: size.height * 0.007,
                          ),
                          Text(
                            getTranslated(
                                context: context,
                                key: "describe",
                                typeScreen: "verification_screen"),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: size.width,
                            height: size.height * 0.015,
                          ),
                          Visibility(
                            visible: visible,
                            child: RaisedButton(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 25),
                                // color: Colors.lightBlueAccent,
                                color: Colors.pink.shade900,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.replay_outlined),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      getTranslated(
                                          context: context,
                                          key: "resend_button",
                                          typeScreen: "verification_screen"),
                                      style: Theme.of(context).textTheme.button,
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  user = authentication.getCurrentUser();
                                  user.sendEmailVerification();

                                  timer = Timer.periodic(
                                    Duration(seconds: 5),
                                    (timer) {
                                      checkEmailVerified();
                                    },
                                  );
                                  setState(() {
                                    visible = false;
                                  });
                                  // ignore: deprecated_member_use
                                  verificationScaffoldKey.currentState
                                      .showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        getTranslated(
                                            context: context,
                                            key: "resent_note",
                                            typeScreen: "verification_screen"),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      backgroundColor: Color(0XFF25347b),
                                    ),
                                  );
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0))),
                          ),
                          SizedBox(
                            height: size.height * 0.025,
                          ),
                          RaisedButton(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 25),
                              // color: Colors.lightBlueAccent,
                              color: Colors.pink.shade900,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.arrow_back_ios_outlined),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    getTranslated(
                                        context: context,
                                        key: "back_button",
                                        typeScreen: "verification_screen"),
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                ],
                              ),
                              onPressed: () async {
                                //TODO delete current user accout
                                await deleteUserInformation().then((value) {
                                  if (value) {
                                    Navigator.pop(context);
                                  }
                                });
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(30.0))),
                        ],
                      )),
                ),
              ),
              LocalNotificationWidget(
                  visible: showNotification,
                  size: size,
                  message: getTranslated(
                      context: context,
                      key: "lose_internet_connections",
                      typeScreen: "general_content"),
                  closeNotificationWidget: () {
                    setState(() {
                      showNotification = false;
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class VerifiyClipper extends CustomClipper<Path> {
  final Offset controllerPoint;

  VerifiyClipper({this.controllerPoint});
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(
        controllerPoint.dx, controllerPoint.dy, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
