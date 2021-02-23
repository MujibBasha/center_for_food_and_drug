import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';

enum SlidableAction {
  downloadVideo,
  delete,
  more,
}

class SlidableWidget extends StatefulWidget {
  final Widget child;
  final Function slidableOnPressed;
  final bool isLocalContent;
  SlidableWidget({
    @required this.child,
    @required this.slidableOnPressed,
    @required this.isLocalContent,
  });
  @override
  _SlidableWidgetState createState() => _SlidableWidgetState();
}

class _SlidableWidgetState extends State<SlidableWidget> {
  List<Widget> actionsButton;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    actionsButton = widget.isLocalContent == false
        ? [
            IconSlideAction(
              icon: Icons.download_outlined,
              color: Colors.green,
              caption: "Download",
              onTap: () {
                widget.slidableOnPressed(SlidableAction.downloadVideo);
              },
            ),
            IconSlideAction(
              icon: Icons.more_vert,
              color: Colors.lightBlue,
              caption: "More",
              onTap: () {
                widget.slidableOnPressed(SlidableAction.more);
              },
            ),
          ]
        : [
            IconSlideAction(
              icon: Icons.delete_outline_outlined,
              color: Colors.red,
              caption: "Delete",
              onTap: () {
                widget.slidableOnPressed(SlidableAction.delete);
              },
            ),
            IconSlideAction(
              icon: Icons.more_vert,
              color: Colors.lightBlue,
              caption: "More",
              onTap: () {
                widget.slidableOnPressed(SlidableAction.more);
              },
            ),
          ];
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionExtentRatio: 0.25,
      actionPane: SlidableDrawerActionPane(),
      child: widget.child,
      actions: actionsButton,
      secondaryActions: actionsButton,
    );
  }
}
