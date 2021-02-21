import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({@required this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/images/images_for_signup_signin_screen/login_bottom.png",
              color: Colors.white54,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/images_for_signup_signin_screen/main_top.png",
              color: Color(0xffEB1555).withOpacity(0.85),
            ),
          ),
          // Positioned(
          //   top: 0,
          //   left: 0,
          //   child: Image.asset(
          //     "assets/images/main_screen_1.png",
          //     width: size.width,
          //   ),
          // ),
          child,
        ],
      ),
    );
  }
}

// class Background extends StatelessWidget {
//   final Widget child;
//   const Background({@required this.child});
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       width: double.infinity,
//       height: size.height,
//       child: Stack(
//         alignment: Alignment.center,
//         children: <Widget>[
//           Positioned(
//             top: -110,
//             left: 80,
//             child: Image.asset(
//               "assets/images/main_screen.png",
//               width: size.width,
//             ),
//           ),
//           Positioned(
//             top: 0,
//             left: 0,
//             child: Image.asset(
//               "assets/images/images_for_signup_signin_screen/main_top.png",
//               color: Colors.lightBlue,
//               width: size.width * 0.4,
//             ),
//           ),
//           child,
//         ],
//       ),
//     );
//   }
// }
