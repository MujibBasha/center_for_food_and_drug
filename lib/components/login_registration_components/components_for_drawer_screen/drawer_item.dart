import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String text;
  final Function onPressed;
  final IconData icon;
  DrawerItem(
      {@required this.text, @required this.onPressed, @required this.icon});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: Icon(
        icon,
        color: Colors.lightBlue,
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class DrawerSubItem extends StatelessWidget {
  final String text;
  final Function onPressed;
  final IconData icon;
  DrawerSubItem({
    @required this.text,
    @required this.onPressed,
    @required this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onPressed,
          leading: Icon(
            icon,
            color: Colors.lightBlue,
          ),
          title: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 2),
          child: Divider(
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
