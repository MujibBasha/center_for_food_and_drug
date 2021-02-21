// import 'package:administrative_control/localization/localization_constants.dart';
import 'package:center_for_food_and_drug/constants.dart';
import 'package:center_for_food_and_drug/localization/localization_constants.dart';
import 'package:flutter/material.dart';
// import 'package:administrative_control/constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    this.login = true,
    this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login
              ? getTranslated(
                  context: context,
                  key: "do_not_have_account",
                  typeScreen: "login_screen")
              : getTranslated(
                  context: context,
                  key: "already_have_an_account_phrase",
                  typeScreen: "login_screen"),
          style: TextStyle(color: kPrimaryColor),
        ),
        MaterialButton(
          highlightColor: Colors.lightBlue.withOpacity(0.15),
          // highlightColor: Colors.pink.withOpacity(0.2),
          onPressed: press,
          child: Text(
            login
                ? getTranslated(
                    context: context,
                    key: "sign_up_button_bottom",
                    typeScreen: "login_screen")
                : getTranslated(
                    context: context,
                    key: "login_button_bottom",
                    typeScreen: "login_screen"),
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}

// class AlreadyHaveAnAccountCheck extends StatelessWidget {
//   final bool login;
//   final Function press;
//   const AlreadyHaveAnAccountCheck({
//     this.login = true,
//     this.press,
//   }) ;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Text(
//           login ? "Don’t have an Account ? " : "Already have an Account ? ",
//           style: TextStyle(color: kPrimaryColor),
//         ),
//         GestureDetector(
//           onTap: press,
//           child: Text(
//             login ? "Sign Up" : "Sign In",
//             style: TextStyle(
//               color: kPrimaryColor,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
