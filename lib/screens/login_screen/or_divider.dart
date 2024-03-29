// import 'package:dsc_hackathon_pp/localization/localization_constants.dart';
import 'package:flutter/material.dart';
// import 'package:dsc_hackathon_pp/constants.dart';

class OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
      width: size.width * 0.8,
      child: Row(
        children: <Widget>[
          buildDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "OR",
              // getTranslated(
              //     context: context, key: "OR", typeScreen: "sign_up_screen"),
              style: TextStyle(
                // color: kPrimaryColor,
                color: Colors.pink.shade900,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          buildDivider(),
        ],
      ),
    );
  }

  Expanded buildDivider() {
    return Expanded(
      child: Divider(
        color: Color(0xFFD9D9D9),
        height: 1.5,
      ),
    );
  }
}
