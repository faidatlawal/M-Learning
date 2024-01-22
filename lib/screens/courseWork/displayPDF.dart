import 'package:flutter/material.dart';
import 'package:mobile_quiz/constants/decoration.dart';
import 'package:mobile_quiz/widgets/loadingGeneral.dart';
import 'package:pdf_flutter/pdf_flutter.dart';

class DisplayPdf extends StatefulWidget {
  final String fileUrl;
  final String courseCode;
  DisplayPdf({@required this.fileUrl, @required this.courseCode});
  @override
  _DisplayPdfState createState() => _DisplayPdfState();
}

class _DisplayPdfState extends State<DisplayPdf> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: backgroundColor2,
      appBar: AppBar(
        title: Text("${widget.courseCode} PDF", style: TextStyle(color: buttonColor1),),
        backgroundColor: backgroundColor2,
        elevation: 0.0,
        iconTheme: IconThemeData(color: buttonColor1),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: PDF.network(
          widget.fileUrl, width: MediaQuery.of(context).size.width, height:  MediaQuery.of(context).size.height, placeHolder: LoadingGeneral(),),
      ),
    );
  }
}