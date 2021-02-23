import 'package:flutter/material.dart';

class ItemOfEntitiesList extends StatefulWidget {
  final Function onPressed;
  final String title;
  final String date;
  ItemOfEntitiesList({
    @required this.onPressed,
    @required this.title,
    @required this.date,
  });
  @override
  _ItemOfEntitiesListState createState() => _ItemOfEntitiesListState();
}

class _ItemOfEntitiesListState extends State<ItemOfEntitiesList> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.symmetric(horizontal: 0.01),
      onPressed: widget.onPressed,
      child: Card(
        color: Colors.lightBlue.shade900,
        shadowColor: Colors.blue,
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(4),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Image.asset("assets/images/entity.png",
                      width: 60, height: 60, fit: BoxFit.fill)
                  // clip.parent.startsWith("http")
                  //     ? Image.network(clip.thumbPath(), width: 70, height: 50, fit: BoxFit.fill)
                  //     : Image.asset(clip.thumbPath(), width: 70, height: 50, fit: BoxFit.fill),
                  ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Padding(
                      child: Text("last update: ${widget.date}",
                          style: TextStyle(color: Colors.grey[500])),
                      padding: EdgeInsets.only(top: 3),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_forward_ios),
                // playing
                //     ? Icon(Icons.play_arrow)
                //     : Icon(
                //         Icons.play_arrow,
                //         color: Colors.grey.shade300,
                //       ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemOfFoundationMembers extends StatefulWidget {
  final Function onPressed;
  final String memberJob;
  final String memberName;
  ItemOfFoundationMembers({this.onPressed, this.memberJob, this.memberName});
  @override
  _ItemOfFoundationMembersState createState() =>
      _ItemOfFoundationMembersState();
}

class _ItemOfFoundationMembersState extends State<ItemOfFoundationMembers> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.symmetric(horizontal: 0.01),
      onPressed: widget.onPressed,
      child: Card(
        child: Container(
          padding: EdgeInsets.all(4),
          child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Image.asset("assets/images/course.png",
                        width: 60, height: 60, fit: BoxFit.fill)
                    // clip.parent.startsWith("http")
                    //     ? Image.network(clip.thumbPath(), width: 70, height: 50, fit: BoxFit.fill)
                    //     : Image.asset(clip.thumbPath(), width: 70, height: 50, fit: BoxFit.fill),
                    ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("name ${widget.memberName}",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Padding(
                        child: Text("job title ${widget.memberJob}",
                            style: TextStyle(color: Colors.grey[500])),
                        padding: EdgeInsets.only(top: 3),
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}

class ItemOfReportList extends StatefulWidget {
  final Function onPressed;
  final String reportName;
  final String date;
  final String by;
  final String officeName;
  ItemOfReportList({
    @required this.onPressed,
    @required this.reportName,
    @required this.date,
    @required this.officeName,
    @required this.by,
  });

  @override
  _ItemOfReportListState createState() => _ItemOfReportListState();
}

class _ItemOfReportListState extends State<ItemOfReportList> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.symmetric(horizontal: 0.01),
      onPressed: widget.onPressed,
      child: Card(
        child: Container(
          padding: EdgeInsets.all(4),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Image.asset("assets/images/reportLogo.png",
                      width: 60, height: 60, fit: BoxFit.fill)
                  // clip.parent.startsWith("http")
                  //     ? Image.network(clip.thumbPath(), width: 70, height: 50, fit: BoxFit.fill)
                  //     : Image.asset(clip.thumbPath(), width: 70, height: 50, fit: BoxFit.fill),
                  ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.reportName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Padding(
                      child: Text("by: ${widget.by}",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey[700])),
                      padding: EdgeInsets.only(top: 3, bottom: 2),
                    ),
                    Row(children: [
                      Padding(
                        child: Text("${widget.date}",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey[500])),
                        padding: EdgeInsets.only(bottom: 3),
                      ),
                      Padding(
                        child: Text("office :${widget.officeName}",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey[500])),
                        padding: EdgeInsets.only(bottom: 3, left: 5),
                      ),
                    ])
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_forward_ios),
                // playing
                //     ? Icon(Icons.play_arrow)
                //     : Icon(
                //         Icons.play_arrow,
                //         color: Colors.grey.shade300,
                //       ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
