import 'dart:io';

import 'package:center_for_food_and_drug/tasks_provider/provider_data.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:flutter/services.dart';

class ViewPdfScreen extends StatefulWidget {
  final String pdfURL;
  final String bookName;
  ViewPdfScreen({@required this.pdfURL, this.bookName});
  @override
  _ViewPdfScreenState createState() => _ViewPdfScreenState();
}

class _ViewPdfScreenState extends State<ViewPdfScreen> {
  int _pageNumber = 1;
  bool fullScreen = false;

  bool isLoading = true;
  int totalPageCount = 1;
  File pdfFile;

  bool downloadButtonAnimation = false;

  bool showDownloadButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  void _createFolder() async {
    var dir = await getApplicationDocumentsDirectory();
    final Directory path = Directory("${dir.path}/download/localPDF/");
    if ((await path.exists())) {
      // TODO:
      print("exist");
    } else {
      // TODO:
      print("not exist");
      path.create(recursive: true);
    }
  }

  void _pickPage() {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return NumberPickerDialog.integer(
            minValue: 1,
            maxValue: totalPageCount,
            title: Text("Pick a page"),
            initialIntegerValue: _pageNumber,
          );
        }).then((int value) {
      if (value != null) {
        _pageNumber = value;
        _pdfViewerController.jumpToPage(value);
      }
    });
  }

  void showSnackBar() {
    // ignore: deprecated_member_use
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Download is completed.",
                style: TextStyle(color: Colors.black)),
            IconButton(
              padding: EdgeInsets.only(right: 2),
              icon: Icon(
                Icons.open_in_new,
                color: Colors.black45,
              ),
              // tooltip: widget.tooltip.last,
              onPressed: () async {
                final status = await Permission.storage.request();
                if (status.isGranted) {
                  // Navigator.pushNamed(context, DownloadScreen.id);

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => DownloadScreen(),
                  //     ));
                } else {
                  // ignore: deprecated_member_use
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Please allow,to access to download screen",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Colors.blueAccent,
                    ),
                  );
                }
              },
            ),
          ],
        ),
        backgroundColor: Colors.lightBlueAccent.shade400,
      ),
    );
  }

  PdfViewerController _pdfViewerController;
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  @override
  void initState() {
    //_createFolder();
    _pdfViewerController = PdfViewerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: fullScreen
          ? null
          : AppBar(
              //backgroundColor: Colors.lightBlueAccent,
              backgroundColor: Colors.pinkAccent.shade700,
              title: Text(
                "Book Store",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontFamily: 'Dancing',
                ),
              ),
            ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: SfPdfViewer.network(
                widget
                    .pdfURL, //"https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf",
                controller: _pdfViewerController,
                enableTextSelection: true,
                onDocumentLoaded: (PdfDocumentLoadedDetails value) {
                  //isLoading = false;
                  print(" count=${value.document.pages.count}");
                  totalPageCount = value.document.pages.count;
//TODO show Download Button
                  setState(() {
                    showDownloadButton = true;
                  });

                  //]PdfDocumentLoadedDetails  doc = value.document;
                },
                // onDocumentLoadedGetPath: (String pdfPath) {
                //   print("Path ====>$pdfPath");
                //   // pdfFile = File(pdfPath);
                // },
                onPageChanged: (PdfPageChangedDetails value) {
                  print("value =${value.newPageNumber}");
                  _pageNumber = value.newPageNumber;
                  // SfPdfViewer.
                  // _pdfViewerController.
                },
                onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
                  setState(() {
                    showDownloadButton = false;
                  });

                  AlertDialog(
                    title: Text(details.error),
                    content: Text(details.description),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
// key: _pdfViewerKey,
                // onDocumentLoadFailed: ,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: MaterialButton(
                shape: CircleBorder(),
                onPressed: () {
                  setState(() {
                    fullScreen = !fullScreen;
                    // SystemChrome.setPreferredOrientations(
                    //     [DeviceOrientation.portraitUp]);
                  });
                },
                child: Icon(
                  fullScreen
                      ? Icons.fullscreen_exit_outlined
                      : Icons.fullscreen_outlined,
                  color: Colors.black45,
                  size: 25,
                ),
              ),
            ),

            Visibility(
              visible: showDownloadButton,
              child: Positioned(
                bottom: 0,
                left: 0,
                child: IconButton(
                  icon: Icon(
                    Icons.download_outlined,
                    color: downloadButtonAnimation
                        ? Colors.lightBlueAccent
                        : Colors.black45,
                  ),
                  // tooltip: widget.tooltip.last,
                  onPressed: () async {
                    final status = await Permission.storage.request();

                    if (status.isGranted) {
                      // Download PDF inside specific folder
                      // setState(() {
                      //   downloadButtonAnimation = true;
                      // });
                      // var dir = await getApplicationDocumentsDirectory();
                      // String pdfName = widget.bookName;
                      // pdfName = pdfName.replaceAll(" ", "_");
                      //
                      // // print("dir=$dir");
                      // // print("dirPAth=${dir.path}");
                      // print("${dir.path}/download/localPDF/$pdfName.pdf");
                      // pdfFile =
                      //     File("${dir.path}/download/localPDF/$pdfName.pdf");
                      //
                      // pdfFile = await pdfFile.writeAsBytes(
                      //     Provider.of<ProviderData>(context, listen: false)
                      //         .pdfFileByte,
                      //     flush: true);
                      //
                      // setState(() {
                      //   downloadButtonAnimation = false;
                      // });
                      // showSnackBar();
                      // ignore: deprecated_member_use
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "this item not available yet",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: Colors.blueAccent,
                        ),
                      );
                    } else {
                      // ignore: deprecated_member_use
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Please allow,to download this pdf",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: Colors.blueAccent,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            // Positioned(
            //               top: 0,
            //               left: 0,
            //               child: MaterialButton(
            //                 shape: CircleBorder(),
            //                 onPressed: () {
            //                   setState(() {
            //                     Navigator.push(
            //                         context,
            //                         MaterialPageRoute(
            //                           builder: (context) => DownloaderPDFScreen(),
            //                         ));
            //                   });
            //                 },
            //                 child: Icon(
            //                   Icons.slideshow,
            //                   color: Colors.black45,
            //                   size: 25,
            //                 ),
            //               ),
            //             ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: IconButton(
              icon: Icon(Icons.first_page),
              // tooltip: widget.tooltip.first,
              onPressed: () {
                _pdfViewerController.firstPage();
                // _pageNumber = 1;
                // _loadPage();
              },
            ),
          ),
          Expanded(
            child: IconButton(
              icon: Icon(Icons.chevron_left),
              // tooltip: widget.tooltip.previous,
              onPressed: () {
                _pdfViewerController.previousPage();
                // _pageNumber--;
                // if (1 > _pageNumber) {
                //   _pageNumber = 1;
                // }
                // _loadPage();
              },
            ),
          ),
          // widget.showPicker ? Expanded(child: Text('')) : SizedBox(width: 1),
          Expanded(
            child: IconButton(
              icon: Icon(Icons.chevron_right),
              // tooltip: widget.tooltip.next,
              onPressed: () {
                _pdfViewerController.nextPage();
                // _pageNumber++;
                // if (widget.document.count < _pageNumber) {
                //   _pageNumber = widget.document.count;
                // }
                // _loadPage();
              },
            ),
          ),
          Expanded(
            child: IconButton(
              icon: Icon(Icons.last_page),
              // tooltip: widget.tooltip.last,
              onPressed: () {
                _pdfViewerController.lastPage();
                // _pageNumber = widget.document.count;
                // _loadPage();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        //backgroundColor: Colors.lightBlueAccent,
        backgroundColor: Colors.pinkAccent.shade700,
        elevation: 4.0,
        // tooltip: widget.tooltip.jump,
        child: Icon(Icons.view_carousel),
        onPressed: () {
          _pickPage();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

// const PDF().fromUrl(
// "http://africau.edu/images/default/sample.pdf",
// placeholder: (double progress) => Center(child: Text('$progress %')),
// errorWidget: (dynamic error) => Center(child: Text(error.toString())),
// ),
//class ViewPdfScreen extends StatefulWidget {
//
//   @override
//   _ViewPdfScreenState createState() => _ViewPdfScreenState();
// }
//
// class _ViewPdfScreenState extends State<ViewPdfScreen> {
//   // _pickPage() {
//   //   showDialog<int>(
//   //       context: context,
//   //       builder: (BuildContext context) {
//   //         return NumberPickerDialog.integer(
//   //           title: Text(widget.tooltip.pick),
//   //           minValue: 1,
//   //           cancelWidget: Container(),
//   //           maxValue: widget.document.count,
//   //           initialIntegerValue: _pageNumber,
//   //         );
//   //       }).then((int value) {
//   //     if (value != null) {
//   //       _pageNumber = value;
//   //       _loadPage();
//   //     }
//   //   });
//   // }
//
//   String pdfPath;
//   Future loadPDF({@required String pdfName, @required String pdfURL}) async {
//     http.Response response = await http.get(pdfURL);
//     var dir = await getApplicationDocumentsDirectory();
//     print("jjjjjjjjjjjjjjjjjjjjjj$dir");
//     File file = File('${dir.path}/$pdfName.pdf');
//
//     await file.writeAsBytes(response.bodyBytes, flush: true);
//     return file.path;
//   }
//
//   @override
//   void initState() {
//     loadPDF(
//       pdfName: "first",
//       pdfURL:
//           "https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf",
//     ).then((path) {
//       setState(() {
//         print("KKKKKKKKKKKKK$path");
//         this.pdfPath = path;
//       });
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.lightBlueAccent,
//         title: Text(
//           "Book Store",
//           style: TextStyle(
//             fontSize: 30,
//             color: Colors.white,
//             fontFamily: 'Dancing',
//           ),
//         ),
//       ),
//       body: pdfPath == null
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : PDFView(
//               enableSwipe: true,
//               filePath: pdfPath,
//             ),
//       bottomNavigationBar: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Expanded(
//             child: IconButton(
//               icon: Icon(Icons.first_page),
//               // tooltip: widget.tooltip.first,
//               onPressed: () {
//                 // _pageNumber = 1;
//                 // _loadPage();
//               },
//             ),
//           ),
//           Expanded(
//             child: IconButton(
//               icon: Icon(Icons.chevron_left),
//               // tooltip: widget.tooltip.previous,
//               onPressed: () {
//                 // _pageNumber--;
//                 // if (1 > _pageNumber) {
//                 //   _pageNumber = 1;
//                 // }
//                 // _loadPage();
//               },
//             ),
//           ),
//           // widget.showPicker ? Expanded(child: Text('')) : SizedBox(width: 1),
//           Expanded(
//             child: IconButton(
//               icon: Icon(Icons.chevron_right),
//               // tooltip: widget.tooltip.next,
//               onPressed: () {
//                 // _pageNumber++;
//                 // if (widget.document.count < _pageNumber) {
//                 //   _pageNumber = widget.document.count;
//                 // }
//                 // _loadPage();
//               },
//             ),
//           ),
//           Expanded(
//             child: IconButton(
//                 icon: Icon(Icons.last_page),
//                 // tooltip: widget.tooltip.last,
//                 onPressed: () {}
//                 //   _pageNumber = widget.document.count;
//                 //   _loadPage();
//                 // },
//                 ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         elevation: 4.0,
//         // tooltip: widget.tooltip.jump,
//         child: Icon(Icons.view_carousel),
//         onPressed: () {
//           // _pickPage();
//         },
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }
// }
