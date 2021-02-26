// import 'package:center_for_food_and_drug/components/components_for_drawer_screen/drawer_item.dart';
import 'package:center_for_food_and_drug/localization/localization_constants.dart';

// import 'package:center_for_food_and_drug/screens/download_screen/download_screen.dart';
import 'package:center_for_food_and_drug/screens/login_screen/login_screen2.dart';
import 'package:center_for_food_and_drug/screens/main_screen/archive_screen.dart';
// import 'package:center_for_food_and_drug/screens/user_info_screen/about_us.dart';
import 'package:flutter/material.dart';

import 'package:center_for_food_and_drug/components/login_registration_components/components_for_drawer_screen/drawer_item.dart';

import 'package:center_for_food_and_drug/constants.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
// import 'package:todoey/models/task_data.dart';
// import 'package:todoey/screens/history_screen.dart';
// import 'package:todoey/screens/profile_screen.dart';
// import 'package:todoey/service/auth.dart';
import 'package:wiredash/wiredash.dart';
import 'package:provider/provider.dart';
import 'package:center_for_food_and_drug/tasks_provider/provider_data.dart';
// import 'package:center_for_food_and_drug/screens/user_info_screen/profile_screen.dart';
// import 'package:center_for_food_and_drug/screens/user_info_screen/connect_with_us.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final drawerScaffoldKey = GlobalKey();

  void deletePref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.remove("userID");
    preferences.setBool("isLogIn", false);
    print("inside of drawer screen");
    print("islogIn=${preferences.getBool("isLogIn")}");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return
        //ClipPath(
        //       clipper: _DrawerClipper(),
        Theme(
      data: ThemeData.dark(),
      child: ClipPath(
        clipper: _DrawerClipper(),
        child: Drawer(
          elevation: 20,
          child: Scaffold(
            key: drawerScaffoldKey,
            backgroundColor: Color(0XFF0A0E21).withOpacity(0.85),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipPath(
                    clipper: DrawerUserInfoClipper(),
                    child: Container(
                      padding: EdgeInsets.only(top: 40, bottom: 60),
                      width: double.infinity,
                      //color: Colors.blue,
                      decoration: BoxDecoration(
                        color: Color(0XFF0A0E21), //0XFF0A0E21
                        //borderRadius: BorderRadius.circular(10),
                        // image: DecorationImage(
                        //   image:
                        //       AssetImage("assets/images/icons/background_B.png"),
                        //   colorFilter: ColorFilter.mode(
                        //       Colors.black.withOpacity(0.8), BlendMode.dstATop),
                        //   fit: BoxFit.cover,
                        // ),
                        // gradient: LinearGradient(
                        //   begin: Alignment(-0.55, 0.06),
                        //   end: Alignment(0.76, 1.62),
                        //   colors: [const Color(0x004d4d4d), const Color(0xff0000ff)],
                        //   stops: [0.0, 1.0],
                        // ),
                        // gradient: LinearGradient(
                        //   begin: Alignment(-1.38, -1.0),
                        //   end: Alignment(0.88, 1.12),
                        //   colors: [
                        //     const Color(0xc7fff700),
                        //     const Color(0xffa7f772),
                        //     const Color(0xff00f6ff)
                        //   ],
                        //   stops: [0.0, 0.464, 1.0],
                        // ),
                        // gradient: LinearGradient(
                        //   begin: Alignment(-0.03, -1.0),
                        //   end: Alignment(0.0, 1.0),
                        //   colors: [const Color(0xffc300f2), const Color(0xff00e5ff)],
                        //   stops: [0.0, 1.0],
                        // ),
                        // image: DecorationImage(
                        //   alignment: Alignment.topCenter,
                        //   image: AssetImage('assets/images/top_header.png'),
                        // ),
                        // borderRadius: BorderRadius.only(
                        //   bottomRight: Radius.circular(9999),
                        //   bottomLeft: Radius.circular(9999),
                        // ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 30.0, bottom: 5),
                        child: Column(
                          children: [
                            //TODO
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Container(
                                    child: Center(
                                      child: Icon(
                                        Icons.clear_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: Colors.lightBlueAccent,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            ///TODO connect this to firebase
                            // Container(
                            //   decoration: BoxDecoration(
                            //     shape: BoxShape.circle,
                            //   ),
                            //   child: Icon(
                            //     Icons.supervised_user_circle,
                            //     size: 80,
                            //     color: Colors.white,
                            //   ),
                            // ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 35,
                              child: Provider.of<ProviderData>(
                                        context,
                                      ).profileImageURL ==
                                      null
                                  ? Icon(
                                      Icons.supervised_user_circle,
                                      size: 70,
                                      color:
                                          Colors.lightBlue, // Colors.black45,
                                    )
                                  : null,
                              backgroundImage: Provider.of<ProviderData>(
                                        context,
                                      ).profileImageURL ==
                                      null
                                  ? null
                                  : NetworkImage(
                                      Provider.of<ProviderData>(
                                        context,
                                      ).profileImageURL,
                                    ),
                            ),
                            TextUserInfo(
                              usernameOrEmai: Provider.of<ProviderData>(context,
                                      listen: false)
                                  .username,
                              style: usernameTextStyle,
                            ),
                            TextUserInfo(
                              usernameOrEmai: (Provider.of<ProviderData>(
                                          context,
                                          listen: false)
                                      .email)
                                  .replaceAll("gmail.com", ""),
                              style: emailTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: SingleChildScrollView(
                        padding: EdgeInsets.only(top: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //TODO
                            DrawerItem(
                              text: getTranslated(
                                  context: context,
                                  key: "profile_item",
                                  typeScreen: "drawer_items"),
                              icon: Icons.assignment_ind_outlined,
                              onPressed: () {
                                // ignore: deprecated_member_use
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      getTranslated(
                                          context: context,
                                          key: "unavailable_item",
                                          typeScreen: "general_content"),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    backgroundColor: Color(0XFF25347b),
                                  ),
                                );
                                Navigator.pop(context);
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => ProfileScreen(),
                                //   ),
                                // );
                              },
                            ),
                            DrawerItem(
                              icon: Icons.cloud_download_outlined,
                              text: "Archives",
                              //getTranslated(
                              // context: context,
                              // key: "download_item",
                              // typeScreen: "drawer_items"),
                              onPressed: () async {
                                final storageStatus =
                                    await Permission.storage.request();

                                if (storageStatus.isGranted) {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ArchivesScreen(),
                                    ),
                                  );
                                } else {
                                  Navigator.pop(context);
                                  // ignore: deprecated_member_use
                                  Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        getTranslated(
                                            context: context,
                                            key: "permission_note",
                                            typeScreen: "general_content"),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      backgroundColor: Color(0XFF25347b),
                                    ),
                                  );
                                }
                                // final status = await Permission.storage.request();
                                // if (status.isGranted) {
                                //   Navigator.pop(context);
                                //
                                //   Navigator.pushNamed(context, DownloadScreen.id);
                                //
                                //   // Navigator.push(
                                //   //     context,
                                //   //     MaterialPageRoute(
                                //   //       builder: (context) => DownloadScreen(),
                                //   //     ));
                                // } else {
                                //   // ignore: deprecated_member_use
                                //   Scaffold.of(context).showSnackBar(
                                //     SnackBar(
                                //       content: Text(
                                //         getTranslated(
                                //             context: context,
                                //             key: "permission_note",
                                //             typeScreen: "general_content"),
                                //         textAlign: TextAlign.center,
                                //         style: TextStyle(
                                //           color: Colors.white,
                                //         ),
                                //       ),
                                //       backgroundColor: Color(0XFF25347b),
                                //     ),
                                //   );
                                //   Navigator.pop(context);
                                // }
                              },
                            ),
                            DrawerItem(
                              icon: Provider.of<ProviderData>(
                                context,
                              ).isNotified
                                  ? Icons.notifications_active_outlined
                                  : Icons.notifications_none_outlined,
                              text: getTranslated(
                                  context: context,
                                  key: "notification_item",
                                  typeScreen: "drawer_items"),
                              onPressed: () {
                                setState(() {
                                  bool state = Provider.of<ProviderData>(
                                    context,
                                    listen: false,
                                  ).isNotified;
                                  print(
                                      "Provider.of<TaskData>(context,listen: false,).isNotified =$state");
                                  Provider.of<ProviderData>(context,
                                          listen: false)
                                      .changeState(!state, "isNotified");
                                });
                              },
                            ),
                            DrawerItem(
                              icon: Icons.mark_chat_unread_sharp,
                              text: getTranslated(
                                  context: context,
                                  key: "connect_with_us_item",
                                  typeScreen: "drawer_items"),
                              onPressed: () {
                                Navigator.pop(context);
                                // ignore: deprecated_member_use
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      getTranslated(
                                          context: context,
                                          key: "unavailable_item",
                                          typeScreen: "general_content"),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    backgroundColor: Color(0XFF25347b),
                                  ),
                                );
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => ConnectWithUs(),
                                //     ));
                                //

                                // ignore: deprecated_member_use
                                // Scaffold.of(context).showSnackBar(SnackBar(
                                //   content: Text(
                                //     "This element not visible yet",
                                //     textAlign: TextAlign.center,
                                //     style: TextStyle(
                                //       color: Colors.blue,
                                //       fontSize: 20,
                                //       fontFamily: "HistoryFont",
                                //     ),
                                //   ),
                                //   backgroundColor: Colors.black,
                                // ));
                              },
                            ),
                            SizedBox(
                              height: size.height * 0.05641119,
                            ),
                            DrawerSubItem(
                              icon: Icons.contact_support_outlined,
                              text: getTranslated(
                                  context: context,
                                  key: "about_us_item",
                                  typeScreen: "drawer_items"),
                              onPressed: () {
                                Navigator.pop(context);

                                // ignore: deprecated_member_use
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      getTranslated(
                                          context: context,
                                          key: "unavailable_item",
                                          typeScreen: "general_content"),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    backgroundColor: Color(0XFF25347b),
                                  ),
                                );
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => AboutUS(),
                                //     ));
                              },
                            ),
                            DrawerSubItem(
                              icon: Icons.support_agent_outlined,
                              text: getTranslated(
                                  context: context,
                                  key: "support_item",
                                  typeScreen: "drawer_items"),
                              onPressed: () {
                                Navigator.pop(context);

                                Wiredash.of(context).show();
                              },
                            ),
                            DrawerSubItem(
                              icon: Icons.exit_to_app,
                              text: getTranslated(
                                  context: context,
                                  key: "sign_out_item",
                                  typeScreen: "drawer_items"),
                              onPressed: () async {
                                deletePref();
                                // Navigator.of(context).pushNamedAndRemoveUntil(
                                //     LoginScreen.id, ModalRoute.withName('/'));

                                Navigator.pushNamedAndRemoveUntil(context,
                                    LoginScreen.id, ModalRoute.withName('/'));
                                //Navigator.pop(context);
                                // Navigator.pop(context);
                                // Navigator.pop(context);
                                // Navigator.pushReplacementNamed(
                                //     context, LoginScreen.id);
                                // Navigator.popUntil(
                                //     context, ModalRoute.withName('/'));
                                // Navigator.pushNamedAndRemoveUntil(
                                //     context,
                                //     LoginScreen.id,
                                //     (Route<dynamic> route) => false);

                                // Navigator.popUntil(context,
                                //     ModalRoute.withName('/LoginScreen'));
                                // Navigator.pushAndRemoveUntil(
                                //     context, LoginScreen.id);
                                // Navigator.popUntil(
                                //     context, ModalRoute.withName('/'));
                                // Authentication authentication =
                                //     Authentication();
                                // await authentication.signOut().then(
                                //   (value) {
                                //     if (value) {
                                //       print("sing out secce");
                                //       Navigator.pop(context);
                                //       Navigator.pop(context);
                                //     }
                                //   },
                                // );
                              },
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TextUserInfo extends StatelessWidget {
  final String usernameOrEmai;
  final TextStyle style;
  TextUserInfo({this.usernameOrEmai, this.style});
  @override
  Widget build(BuildContext context) {
    return Text(
      usernameOrEmai,
      style: style,
    );
  }
}

class DrawerUserInfoClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.4);
    path.quadraticBezierTo(
        size.width, size.height, size.width / 2, size.height * 0.86);
    path.quadraticBezierTo(0, size.height * 0.70, 0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}

class _DrawerClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();

    path.lineTo(size.width * 0.85, 0);
    path.quadraticBezierTo(
        size.width, size.height / 2, size.width * 0.85, size.height);

    // path.lineTo(size.width, size.height / 2);
    // path.lineTo(size.width * 0.85, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.lineTo(size.width * 0.85, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}
