// import 'package:flutter/material.dart';
// import 'package:dsc_hackathon_pp/constants.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// import 'package:flutter_svg/svg.dart';
//
// class SocalIcon extends StatelessWidget {
//   final String iconSrc;
//   final Function press;
//   const SocalIcon({
//     Key key,
//     this.iconSrc,
//     this.press,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialButton(
//       shape: CircleBorder(),
//       highlightColor: Colors.pink,
//       padding: null,
//       onPressed: press,
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 10),
//         padding: EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           border: Border.all(
//             width: 2,
//             color: kPrimaryLightColor,
//           ),
//           shape: BoxShape.circle,
//         ),
//         child: SvgPicture.asset(
//           iconSrc,
//           height: 20,
//           width: 20,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }
