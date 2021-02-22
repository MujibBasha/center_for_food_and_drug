import 'package:center_for_food_and_drug/components/login_registration_components/text_field_container.dart';
// import 'package:administrative_control/localization/localization_constants.dart';
import 'package:flutter/material.dart';

import 'package:center_for_food_and_drug/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  // final ValueChanged<String> onChanged;
  final Function validatorFunction;
  final TextEditingController passwordEditingController;

  const RoundedPasswordField({
    @required this.validatorFunction,
    // this.onChanged,
    @required this.passwordEditingController,
  });

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        autocorrect: false,
        style: TextStyle(
          color: Colors.black45,
        ),
        controller: widget.passwordEditingController,
        validator: widget.validatorFunction,
        obscureText: isVisible ? false : true,
        // onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "password",
          // getTranslated(
          //     context: context, key: "password", typeScreen: "login_screen"),
          hintStyle: TextStyle(
            color: Colors.black38,
          ),
          icon: Icon(Icons.lock,
              // color: kPrimaryColor,
              color: Colors.blue //Colors.pink.shade700,
              ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                isVisible = !isVisible;
              });
            },
            icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off,
                //color: kPrimaryColor,
                color: Colors.blue // Colors.pink.shade700,
                ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

// class RoundedPasswordField extends StatelessWidget {
//   // final ValueChanged<String> onChanged;
//   final Function validatorFunction;
//   final TextEditingController passwordEditingController;
//   const RoundedPasswordField({
//     @required this.validatorFunction,
//     // this.onChanged,
//     @required this.passwordEditingController,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFieldContainer(
//       child: TextFormField(
//         style: TextStyle(
//           color: Colors.black45,
//         ),
//         controller: passwordEditingController,
//         validator: validatorFunction,
//         obscureText: true,
//         // onChanged: onChanged,
//         cursorColor: kPrimaryColor,
//         decoration: InputDecoration(
//           hintText: "Password",
//           hintStyle: TextStyle(
//             color: Colors.black38,
//           ),
//           icon: Icon(
//             Icons.lock,
//             color: kPrimaryColor,
//           ),
//           suffixIcon: Icon(
//             Icons.visibility_off,
//             color: kPrimaryColor,
//           ),
//           border: InputBorder.none,
//         ),
//       ),
//     );
//   }
// }
