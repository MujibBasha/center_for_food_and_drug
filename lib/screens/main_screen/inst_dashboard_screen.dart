import 'dart:io';
import 'dart:ui';

import 'package:center_for_food_and_drug/components/login_registration_components/item_of_list.dart';
import 'package:center_for_food_and_drug/constants.dart';
import 'package:center_for_food_and_drug/localization/localization_constants.dart';
import 'package:center_for_food_and_drug/screens/main_screen/archive_screen.dart';
import 'package:center_for_food_and_drug/screens/main_screen/check_list_screen.dart';
import 'package:center_for_food_and_drug/screens/main_screen/global_archive_list_screen.dart';
import 'package:center_for_food_and_drug/screens/main_screen/main_component_screen/drawer_screen.dart';
import 'package:center_for_food_and_drug/screens/main_screen/scanner_screen.dart';

import 'package:center_for_food_and_drug/service/database.dart';
import 'package:center_for_food_and_drug/tasks_provider/provider_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';
import 'package:wiredash/wiredash.dart';

class InstDashboardScreen extends StatefulWidget {
  static String id = "InstDashboardScreen";
  @override
  _InstDashboardScreenState createState() => _InstDashboardScreenState();
}

class _InstDashboardScreenState extends State<InstDashboardScreen> {
  DocumentSnapshot userInfo;

  final scaffoldDashboardKey = GlobalKey<ScaffoldState>();
  void showSnackBar({String text}) {
    // ignore: deprecated_member_use
    scaffoldDashboardKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0XFF25347b),
      ),
    );
  }

  enablesPermisionFromUser() async {
    final storageStatus = await Permission.storage.request();
    //final cameraStatus = await Permission.camera.request();
    final notificationStatus = await Permission.notification.request();
    // if (storageStatus.isGranted && notificationStatus.isGranted) {
  }

  Future getUserInfo() async {
    // TODO: implement initState
    userInfo = await DataBase().getUserByUserID(
        userId: Provider.of<ProviderData>(context, listen: false).userID);
    var fullName = await userInfo.get("full_name");
    var username = await userInfo.get("username");
    var email = await userInfo.get("email");
    var officeName = await userInfo.get("office_name");
    var phoneNumber = await userInfo.get("phone_number");
    var idNumber = await userInfo.get("id_number");
    Provider.of<ProviderData>(context, listen: false)
        .changeUserData(data: username, dataType: "username");
    Provider.of<ProviderData>(context, listen: false)
        .changeUserData(data: fullName, dataType: "fullName");
    Provider.of<ProviderData>(context, listen: false)
        .changeUserData(data: email, dataType: "email");
    Provider.of<ProviderData>(context, listen: false)
        .changeUserData(data: officeName, dataType: "officeName");
    Provider.of<ProviderData>(context, listen: false)
        .changeUserData(data: phoneNumber, dataType: "phoneNumber");
    Provider.of<ProviderData>(context, listen: false)
        .changeUserData(data: idNumber, dataType: "idNumber");
  }

  ScrollController scrollController;
  bool scrollVisible = true;

  void setDialVisible(bool value) {
    setState(() {
      scrollVisible = value;
    });
  }

  void _createDownloadReportFolder() async {
    // var dir = await getApplicationDocumentsDirectory();
    final Directory path =
        Directory("storage/emulated/0/LYFDA/download/local_archive");

    if ((await path.exists())) {
      // TODO:
      print("exist PDF Dir");
    } else {
      // TODO:
      print("not exist PDF Dir");
      path.create(recursive: true);
    }
  }

  @override
  void initState() {
    _createDownloadReportFolder();
    getUserInfo();
    super.initState();

    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: scaffoldDashboardKey,
        drawer: DrawerScreen(),
        body: Column(children: [
          Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/do_more_2.jpg"),
                  colorFilter: ColorFilter.mode(
                      Colors.blueAccent.withOpacity(0.35), BlendMode.dstIn),
                  fit: BoxFit.cover,
                ),
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
              ),
              // height: size.height * 0.25,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 64,
                    // margin: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        // Container(
                        //   height: 90,
                        //   width: 90,
                        //   // alignment: Alignment.center,
                        //   child: BoomMenu(
                        //     fabAlignment: Alignment.centerLeft,
                        //     animatedIcon: AnimatedIcons.menu_close,
                        //     animatedIconTheme: IconThemeData(size: 22.0),
                        //     //child: Icon(Icons.add),
                        //     marginBottom: 10,
                        //     // child: Container(
                        //     //   width: 70,
                        //     //   height: 70,
                        //     // ),
                        //     onOpen: () => print('OPENING DIAL'),
                        //     onClose: () => print('DIAL CLOSED'),
                        //     scrollVisible: scrollVisible,
                        //     overlayColor: Colors.black,
                        //     overlayOpacity: 0.7,
                        //     children: [
                        //       MenuItem(
                        //         child: Icon(Icons.person_rounded,
                        //             color: Colors.black),
                        //         title: "Profiles",
                        //         titleColor: Colors.white,
                        //         subtitle: "go to your profile page",
                        //         subTitleColor: Colors.white,
                        //         backgroundColor: Colors.blue,
                        //         onTap: () => print('FIRST CHILD'),
                        //       ),
                        //       MenuItem(
                        //         child: Icon(Icons.contact_support_outlined,
                        //             color: Colors.black),
                        //         title: "support",
                        //         titleColor: Colors.white,
                        //         subtitle: "connect with us",
                        //         subTitleColor: Colors.white,
                        //         backgroundColor: Colors.green,
                        //         onTap: () => print('SECOND CHILD'),
                        //       ),
                        //       MenuItem(
                        //         child: Icon(Icons.logout, color: Colors.black),
                        //         title: "Log out",
                        //         titleColor: Colors.white,
                        //         subtitle: "connect with us",
                        //         subTitleColor: Colors.white,
                        //         backgroundColor: Colors.redAccent,
                        //         onTap: () => print('SECOND CHILD'),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Container(
                          height: 70,
                          width: 70,
                          child: FlatButton(
                            onPressed: () =>
                                scaffoldDashboardKey.currentState.openDrawer(),
                            child: Image.asset(
                              "assets/images/menu.png",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                            color: Colors.blue, // Colors.black45,
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
                  SizedBox(
                    height: 4,
                  ),
                  TextUserInfo(
                    usernameOrEmai:
                        Provider.of<ProviderData>(context).username ??
                            "Mujib Basha",
                    style: usernameTextStyle,
                  ),
                  TextUserInfo(
                    usernameOrEmai: (Provider.of<ProviderData>(context).email)
                            .replaceAll("gmail.com", "") ??
                        "mjub451@",
                    style: emailTextStyle,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              )),
          Expanded(
            child: Container(
                width: size.width,
                // color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Row(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                                child: MaterialButton(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 0.0),
                                  onPressed: () async {
                                    final storageStatus =
                                        await Permission.storage.request();

                                    if (storageStatus.isGranted) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CheckListScreen(),
                                        ),
                                      );
                                    } else {
                                      showSnackBar(
                                        text: getTranslated(
                                            context: context,
                                            key: "permission_note",
                                            typeScreen: "general_content"),
                                      );
                                    }
                                  },
                                  child: Container(
                                    height: 200,
                                    width: 180,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color:
                                            Color(0xff8E8FC9).withOpacity(0.3)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                          "assets/images/T_S_2.png",
                                          height: 120,
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          "New Report",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff289FF3)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                                child: MaterialButton(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 0.0),
                                  onPressed: () {
                                    print("Clicked on Course Booking");
                                    // ignore: deprecated_member_use
                                    showSnackBar(
                                      text: getTranslated(
                                          context: context,
                                          key: "unavailable_item",
                                          typeScreen: "general_content"),
                                    );

                                    // Navigator.pushNamed(context, SearchBookScreen.id);
                                  },
                                  child: Container(
                                    height: 200,
                                    width: 180,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color:
                                            Color(0xff8E8FC9).withOpacity(0.3)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                          "assets/images/compliant _2.png",
                                          height: 120,
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          "Create Report",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff289FF3)),
                                        ),
                                        // Image.asset(icon_courseBookingPage),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                                child: MaterialButton(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 0.0),
                                  onPressed: () async {
                                    final storageStatus =
                                        await Permission.storage.request();

                                    if (storageStatus.isGranted) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ArchivesScreen(),
                                        ),
                                      );
                                    } else {
                                      showSnackBar(
                                        text: getTranslated(
                                            context: context,
                                            key: "permission_note",
                                            typeScreen: "general_content"),
                                      );
                                    }

                                    // showSnackBar(
                                    //   text: getTranslated(
                                    //       context: context,
                                    //       key: "unavailable_item",
                                    //       typeScreen: "general_content"),
                                    // );
                                  },
                                  child: Container(
                                    height: 200,
                                    width: 180,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color:
                                            Color(0xff8E8FC9).withOpacity(0.3)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                          "assets/images/compliant _1.png",
                                          // height: size.height * 0.12,
                                          height: 120,
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          "Archives",
                                          //"All Check",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff289FF3)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                                child: MaterialButton(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 0.0),
                                  onPressed: () async {
                                    final storageStatus =
                                        await Permission.storage.request();
                                    final cameraStatus =
                                        await Permission.camera.request();
                                    if (storageStatus.isGranted &&
                                        cameraStatus.isGranted) {
                                      Navigator.pushNamed(
                                          context, ScannerScreen.id);
                                    } else {
                                      showSnackBar(
                                        text: getTranslated(
                                            context: context,
                                            key: "permission_note",
                                            typeScreen: "general_content"),
                                      );
                                    }
                                    print("Clicked on Course Booking");
                                  },
                                  child: Container(
                                    height: 200,
                                    width: 180,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color:
                                            Color(0xff8E8FC9).withOpacity(0.3)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                          "assets/images/insurance.png",
                                          // height: size.height * 0.12,
                                          height: 120,
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          "Scanner", //Prohibited Goods
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff289FF3)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )

                // ListView(
                //   children: [
                //     ItemOfAbilityInstitutionList(
                //       onPressed: () {
                //         print("1");
                //       },
                //       sectionName: "Research and studies",
                //       by: "",
                //     ),
                //     ItemOfAbilityInstitutionList(
                //         onPressed: () {}, sectionName: "Reports", by: ""),
                //     ItemOfAbilityInstitutionList(
                //         onPressed: () {
                //           //TODO send to
                //         },
                //         sectionName: "Foundation members",
                //         by: ""),
                //     ItemOfAbilityInstitutionList(
                //         onPressed: () {}, sectionName: "Chat room", by: ""),
                //   ],
                // ),
                ),
          ),
        ]),
        floatingActionButton: BoomMenu(
          fabAlignment: Alignment.topLeft,
          animatedIcon: AnimatedIcons.view_list,
          // animatedIconTheme: IconThemeData(size: 22.0),
          //child: Icon(Icons.add),
          // marginBottom: 10,
          // child: Container(
          //   width: 70,
          //   height: 70,
          // ),
          backgroundColor: Colors.lightBlueAccent.withOpacity(0.6),
          onOpen: () => print('OPENING DIAL'),
          onClose: () => print('DIAL CLOSED'),
          scrollVisible: scrollVisible,
          overlayColor: Colors.black,
          overlayOpacity: 0.7,
          children: [
            MenuItem(
              child: Icon(Icons.person_rounded, color: Colors.black),
              title: "Profiles",
              titleColor: Colors.white,
              subtitle: "go to your profile page",
              subTitleColor: Colors.white,
              backgroundColor: Colors.blue,
              onTap: () {
                print('FIRST CHILD');
                showSnackBar(
                  text: getTranslated(
                      context: context,
                      key: "unavailable_item",
                      typeScreen: "general_content"),
                );
              },
            ),
            MenuItem(
              child: Icon(Icons.contact_support_outlined, color: Colors.black),
              title: "support",
              titleColor: Colors.white,
              subtitle: "connect with us",
              subTitleColor: Colors.white,
              backgroundColor: Colors.green,
              onTap: () {
                Wiredash.of(context).show();
                print('SECOND CHILD');
                // showSnackBar(
                //     text: getTranslated(
                //         context: context,
                //         key: "unavailable_item",
                //         typeScreen: "general_content"));
              },
            ),
            MenuItem(
              child: Icon(Icons.logout, color: Colors.black),
              title: "Log out",
              titleColor: Colors.white,
              subtitle: "connect with us",
              subTitleColor: Colors.white,
              backgroundColor: Colors.redAccent,
              onTap: () {
                print('SECOND CHILD');
                showSnackBar(
                  text: getTranslated(
                      context: context,
                      key: "unavailable_item",
                      typeScreen: "general_content"),
                );
              },
            ),
          ],
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
      textAlign: TextAlign.center,
      style: style,
    );
  }
}
