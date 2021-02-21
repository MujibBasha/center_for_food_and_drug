import 'package:flutter/material.dart';

class LocalNotificationWidget extends StatefulWidget {
  final bool visible;
  final Function closeNotificationWidget;
  final Size size;
  final String message;
  LocalNotificationWidget(
      {@required this.visible,
      @required this.size,
      @required this.message,
      @required this.closeNotificationWidget});
  @override
  _LocalNotificationWidgetState createState() =>
      _LocalNotificationWidgetState();
}

class _LocalNotificationWidgetState extends State<LocalNotificationWidget> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.visible,
      child: Padding(
        padding: EdgeInsets.only(top: widget.size.height * 0.10),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
          width: widget.size.width,
          color: Colors.orangeAccent.shade400,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Icon(
                  Icons.info_outline,
                  size: 40,
                  color: Colors.pink,
                ),
              ),
              //widget.message
              Expanded(
                child: Text(
                  widget.message,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              MaterialButton(
                highlightColor: Colors.black45,
                shape: CircleBorder(),
                onPressed: widget.closeNotificationWidget,
                child: Icon(
                  Icons.clear,
                  size: 40,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
