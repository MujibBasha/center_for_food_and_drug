import 'package:flutter/material.dart';

const kPrimaryColor = Colors.lightBlueAccent;
const kPrimaryLightColor = Color(0xFFF1E6FF);

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const KTextFieldDecoration = InputDecoration(
  hintText: '',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const KTextFieldDecorationSearch = InputDecoration(
  hintText: '',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const KTextFieldDecorationSearchSection = InputDecoration(
  hintText: '',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const usernameTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

const emailTextStyle = TextStyle(
  color: Colors.white60,
  fontSize: 18,
  fontWeight: FontWeight.w300,
);

///this Section for General Content Screen

///this section for Log in screen
// MyHomePage(title: 'Flutter Demo Home Page');
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0XFF3F51b5),
//
//       // persist create account link at the bottom of screen
//       bottomNavigationBar: _createAccountLink(),
//
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           SizedBox(
//             height: 70,
//           ),
//           _topheader(),
//           Expanded(
//               child: Container(
//                 width: double.infinity,
//                 margin: EdgeInsets.only(top: 32),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(40),
//                     topRight: Radius.circular(40),
//                   ),
//                   color: Colors.grey[50],
//                 ),
//                 padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       SizedBox(height: 40),
//                       _labelText('Email:'),
//                       _inputTextField('example@email.com', false),
//                       SizedBox(height: 16),
//                       _labelText('Password:'),
//                       _inputTextField('******', true),
//                       SizedBox(height: 12),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: InkWell(
//                           onTap: () {
//                             //TODO
//                           },
//                           child: Text(
//                             'Forgot Password ?',
//                             style: TextStyle(
//                               color: Colors.blue[900],
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       Align(
//                         alignment: Alignment.center,
//                         child: Container(
//                           height: 46,
//                           width: 160,
//                           child: RaisedButton(
//                             onPressed: () {
//                               //TODO
//                             },
//                             child: Text(
//                               'Login',
//                               style: TextStyle(
//                                 fontSize: 18,
//                               ),
//                             ),
//                             color: Color(0XFF303f9f),
//                             textColor: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30.0),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 12),
//                       Align(
//                         alignment: Alignment.center,
//                         child: Text(
//                           'OR',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.black54,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 18),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: <Widget>[
//                           _loginSocialMediaBtn(
//                               FontAwesomeIcons.facebookF, facebookColor),
//                           SizedBox(width: 16),
//                           _loginSocialMediaBtn(
//                               FontAwesomeIcons.google, googleColor),
//                           SizedBox(width: 16),
//                           _loginSocialMediaBtn(
//                               FontAwesomeIcons.twitter, twitterColor),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               )),
//         ],
//       ),
//     );
//   }
//
//   _createAccountLink() {
//     return Container(
//       color: Colors.grey[50],
//       padding: EdgeInsets.only(bottom: 16),
//       height: 60,
//       child: Center(
//         child: Text(
//           'Don\'t have account ? Sign Up Now',
//           style: TextStyle(
//             fontWeight: FontWeight.w700,
//             color: facebookColor,
//             fontSize: 16,
//           ),
//         ),
//       ),
//     );
//   }
//
//   //button to login in using scial media,
//   _loginSocialMediaBtn(IconData icon, Color bgColor) {
//     return SizedBox.fromSize(
//       size: Size(54, 54), //button width and height
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(16),
//         child: Material(
//           elevation: 16,
//           shadowColor: Colors.black,
//           color: bgColor,
//           child: InkWell(
//             splashColor: Colors.white12,
//             onTap: () {},
//             child: Center(
//               child: Icon(
//                 icon,
//                 color: Colors.white,
//                 size: 24,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   _inputTextField(hintText, bool obscuretext) {
//     return Container(
//       height: 56,
//       padding: EdgeInsets.fromLTRB(16, 3, 16, 6),
//       margin: EdgeInsets.all(8),
//       decoration: raisedDecoration,
//       child: Center(
//         child: TextField(
//           obscureText: obscuretext,
//           decoration: InputDecoration(
//               border: InputBorder.none,
//               hintText: hintText,
//               hintStyle: TextStyle(
//                 color: Colors.black38,
//               )),
//         ),
//       ),
//     );
//   }
//
//   _labelText(title) {
//     return Padding(
//       padding: EdgeInsets.only(left: 24),
//       child: Text(
//         title,
//         style: TextStyle(
//           fontWeight: FontWeight.w500,
//           color: Colors.black,
//           fontSize: 16,
//         ),
//       ),
//     );
//   }
//
//   _topheader() {
//     return Padding(
//       padding: EdgeInsets.only(left: 32),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Text(
//             'Create\nYour\nAccount',
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.w600,
//               fontSize: 28,
//             ),
//           ),
//           Image.asset(
//             'assets/gbimage.png',
//             height: 170,
//             fit: BoxFit.fitHeight,
//           )
//         ],
//       ),
//     );
//   }
// }

// var raisedDecoration = BoxDecoration(
//     color: Colors.white,
//     borderRadius: BorderRadius.circular(16),
//     border: Border.all(
//       color: Colors.grey[50],
//     ),
//     boxShadow: [
//       BoxShadow(
//         color: Colors.black26,
//         offset: Offset(5, 2),
//         blurRadius: 3.0,
//         spreadRadius: 0.0,
//       ),
//       BoxShadow(
//         color: Colors.white,
//         offset: Offset(-5, -2),
//         blurRadius: 3.0,
//         spreadRadius: 0.0,
//       ),
//     ]);
//
// Color facebookColor = Color(0xFF416BC1);
// Color googleColor = Color(0xFFCF4333);
// Color twitterColor = Color(0xFF08A0E9);
