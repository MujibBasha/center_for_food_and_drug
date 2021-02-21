// import 'package:dsc_hackathon_pp/components/components.login_registration_components/text_field_container.dart';

import 'package:center_for_food_and_drug/components/login_registration_components/text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:center_for_food_and_drug/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final Function validatorFunction;
  final TextEditingController controller;
  final typeOfTextField;
  // final ValueChanged<String> onChanged;
  const RoundedInputField({
    this.typeOfTextField,
    this.controller,
    this.hintText,
    this.icon = Icons.person,
    // this.onChanged,
    @required this.validatorFunction,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        keyboardType: typeOfTextField == "Email"
            ? TextInputType.emailAddress
            : TextInputType.text,
        style: TextStyle(
          color: Colors.black45,
        ),
        validator: validatorFunction,
        // onChanged: onChanged,
        controller: controller,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(icon,
              // color: kPrimaryColor,
              color: Colors.blue //Colors.pink.shade700,
              ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.black38,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
// class RoundedInputField extends StatelessWidget {
//   final String hintText;
//   final IconData icon;
//   final Function validatorFunction;
//   final TextEditingController emailController;
//   // final ValueChanged<String> onChanged;
//   const RoundedInputField({
//     this.emailController,
//     this.hintText,
//     this.icon = Icons.person,
//     // this.onChanged,
//     @required this.validatorFunction,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFieldContainer(
//       child: TextFormField(
//         keyboardType: TextInputType.emailAddress,
//         style: TextStyle(
//           color: Colors.black45,
//         ),
//         validator: validatorFunction,
//         // onChanged: onChanged,
//         controller: emailController,
//         cursorColor: kPrimaryColor,
//         decoration: InputDecoration(
//           icon: Icon(
//             icon,
//             color: kPrimaryColor,
//           ),
//           hintText: hintText,
//           hintStyle: TextStyle(
//             color: Colors.black38,
//           ),
//           border: InputBorder.none,
//         ),
//       ),
//     );
//   }
// }
