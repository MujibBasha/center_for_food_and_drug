import 'dart:io';

// import 'package:dsc_hackathon_pp/screens/download_screen/download_screen.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ItemOfLocalContent extends StatefulWidget {
  final File currentFile;

  ItemOfLocalContent({@required this.currentFile});
  @override
  _ItemOfLocalContentState createState() => _ItemOfLocalContentState();
}

class _ItemOfLocalContentState extends State<ItemOfLocalContent> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            title: Text(widget.currentFile.path.split('/').last),
            leading: Icon(
              Icons.picture_as_pdf,
              color: Colors.lightBlueAccent,
            ),
            trailing: Icon(
              Icons.arrow_forward,
              color: Colors.lightBlueAccent,
            ),
            onTap: () {
              // File f=File("dsd/sd/sd/sdds.pdf");
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ViewPDF(filePDF: widget.currentFile);
                //open viewPDF page on click
              }));
            }));
  }
}

class ViewPDF extends StatefulWidget {
  final File filePDF;
  ViewPDF({@required this.filePDF});
  @override
  _ViewPDFState createState() => _ViewPDFState();
}

class _ViewPDFState extends State<ViewPDF> {
  int _pageNumber = 1;

  bool fullScreen = false;

  int totalPageCount = 1;

  File pdfFile;
  PdfViewerController _pdfViewerController;

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

  @override
  void initState() {
    print("the pdf File Path is =${widget.filePDF.path}");
    _pdfViewerController = PdfViewerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fullScreen
          ? null
          : AppBar(
              backgroundColor: Colors.lightBlueAccent,
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
                child: SfPdfViewer.file(
              widget.filePDF,
              controller: _pdfViewerController,
              onDocumentLoaded: (PdfDocumentLoadedDetails value) {
                print(" count=${value.document.pages.count}");
                totalPageCount = value.document.pages.count;
              },
              onPageChanged: (PdfPageChangedDetails value) {
                print("value =${value.newPageNumber}");
                _pageNumber = value.newPageNumber;
                // SfPdfViewer.
                // _pdfViewerController.
              },
              onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
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
            )),
            Positioned(
              bottom: 0,
              right: 0,
              child: MaterialButton(
                shape: CircleBorder(),
                onPressed: () {
                  setState(() {
                    fullScreen = !fullScreen;
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

            // Positioned(
            //   bottom: 0,
            //   left: 0,
            //   child: IconButton(
            //     icon: Icon(
            //       Icons.download_outlined,
            //       color: downloadButtonAnimation
            //           ? Colors.lightBlueAccent
            //           : Colors.black45,
            //     ),
            //     // tooltip: widget.tooltip.last,
            //     onPressed: () async {
            //       // Download PDF inside specific folder
            //       setState(() {
            //         downloadButtonAnimation = true;
            //       });
            //       var dir = await getApplicationDocumentsDirectory();
            //       String pdfName = widget.bookName;
            //       pdfName = pdfName.replaceAll(" ", "_");
            //
            //       // print("dir=$dir");
            //       // print("dirPAth=${dir.path}");
            //       print("${dir.path}/download/localPDF/$pdfName.pdf");
            //       pdfFile = File("${dir.path}/download/localPDF/$pdfName.pdf");
            //
            //       pdfFile = await pdfFile.writeAsBytes(
            //           Provider.of<ProviderData>(context, listen: false)
            //               .pdfFileByte,
            //           flush: true);
            //
            //       setState(() {
            //         downloadButtonAnimation = false;
            //       });
            //     },
            //   ),
            // ),
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
        backgroundColor: Colors.lightBlueAccent,
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
