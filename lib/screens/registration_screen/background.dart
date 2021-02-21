import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      // Here i can use size.width but use double.infinity because both work as a same
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // Positioned(
          //   top: 0,
          //   left: 0,
          //   child: Image.asset(
          //     "assets/images/images_for_signup_signin_screen/signup_top.png",
          //     // color: Colors.lightBlueAccent,
          //     color: Color(0xffEB1555).withOpacity(0.85),
          //     // width: size.width * 0.35,
          //   ),
          // ),
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   child: Image.asset(
          //       "assets/images/images_for_signup_signin_screen/main_bottom.png",
          //       color: Colors.white54),
          // ),
          child,
        ],
      ),
    );
  }
}

// class Background extends StatelessWidget {
//   final Widget child;
//   const Background({
//     Key key,
//     @required this.child,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       height: size.height,
//       width: double.infinity,
//       // Here i can use size.width but use double.infinity because both work as a same
//       child: Stack(
//         alignment: Alignment.center,
//         children: <Widget>[
//           Positioned(
//             top: 0,
//             left: 0,
//             child: Image.asset(
//               "assets/images/images_for_signup_signin_screen/signup_top.png",
//               color: Colors.lightBlueAccent,
//               width: size.width * 0.35,
//             ),
//           ),
//           Positioned(
//             bottom: 0,
//             left: 0,
//             child: Image.asset(
//               "assets/images/images_for_signup_signin_screen/main_bottom.png",
//               width: size.width * 0.25,
//             ),
//           ),
//           child,
//         ],
//       ),
//     );
//   }
// }
