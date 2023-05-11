import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:collection/collection.dart';
import 'package:zoom_widget/zoom_widget.dart';
import 'dart:math' as math;

class Orc_Tech extends StatefulWidget {
  const Orc_Tech({super.key});
  static const String routeName = '/Orc_Tech';

  @override
  State<Orc_Tech> createState() => _Orc_TechState();
}

class _Orc_TechState extends State<Orc_Tech> {
  bool textScanning = false;

  XFile? imageFile;

  String scannedText = "";
  bool loadedImage = false;

  List<TextLine> globalList = <TextLine>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Label Recognition"),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.only(top: 10),
                        child: SizedBox(
                          width: 145.0,
                          height: 75.0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Colors.grey,
                              shadowColor: Colors.grey[400],
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                            ),
                            onPressed: () {
                              getImage(ImageSource.gallery);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.image,
                                    size: 30,
                                  ),
                                  Text(
                                    "Gallery",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey[600]),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.only(top: 10),
                        child: SizedBox(
                          width: 145.0,
                          height: 75.0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Colors.grey,
                              shadowColor: Colors.grey[400],
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                            ),
                            onPressed: () {
                              getImage(ImageSource.camera);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    size: 30,
                                  ),
                                  Text(
                                    "Camera",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey[600]),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                if (textScanning) const CircularProgressIndicator(),
                if (!textScanning && imageFile == null)
                  Container(
                    width: 300,
                    height: 300,
                    color: Colors.grey[300]!,
                  ),
                if (imageFile != null) Image.file(File(imageFile!.path)),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    scannedText,
                    style: TextStyle(fontSize: 20),
                  ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: loadedImage
                      ? InteractiveViewer(
                          boundaryMargin: const EdgeInsets.all(20.0),
                          minScale: 0.9,
                          maxScale: 2.5,
                          child: CustomPaint(
                            painter: MyPaintForText(globalList),
                          ),
                        )
                      : Text(''),
                ),
              ],
            )),
      )),
    );
  }

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {});
        getRecognisedText(pickedImage);
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      scannedText = "Error occured while scanning";
      setState(() {});
    }
  }

  void getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision
        .textRecognizer(script: TextRecognitionScript.chinese);
    RecognizedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();

//!  test v3
    final blocks = recognisedText.blocks;
    final List<TextLine> allLines_list = <TextLine>[];
    globalList = allLines_list;
    for (TextBlock block in blocks) {
      allLines_list.addAll(block.lines);
    }
    //allLines_list.
    //final filtered_List = allLines_list[0] ;
    allLines_list.sort(mySortComparison);
    //  scannedText = "";

// //! result
//     for (TextLine line in allLines_list) {
//       scannedText = scannedText + line.text + "\n\n";
//       //debugPrint(scannedText);
//     }
    textScanning = false;

    setState(() {
      loadedImage = true;
    });
  }

  @override
  void initState() {
    super.initState();
  }
}

int mySortComparison(TextLine a, TextLine b) {
  final propertyA = a.boundingBox.center.dy;
  final propertyB = b.boundingBox.center.dy;
  if (propertyA < propertyB) {
    return -1;
  } else if (propertyA > propertyB) {
    return 1;
  } else {
    return 0;
  }
}

class MyPaintForText extends CustomPainter {
  final List<TextLine> implementLines;

  MyPaintForText(this.implementLines);

  final Paint _paint = Paint()..color = const Color(0xFF000000);

  @override
  void paint(Canvas canvas, Size size) {
    // final radius = size.shortestSide / 3;
    // final center = Offset(size.width / 2, size.height / 2);

    // canvas.drawCircle(center, radius, _paint);

    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 20,
    );

    //  textPainter.paint(canvas, offset);
    // canvas.drawRect(Offset(100, 100) & const Size(200, 150), Paint());
    final textSpan = TextSpan(
      text: implementLines[0].text,
      style: textStyle,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );

    textPainter.paint(
        canvas,
        Offset((implementLines[0].boundingBox.topLeft.dx / 3),
            implementLines[0].boundingBox.topLeft.dy / 3));

    for (int i = 1; i < implementLines.length; i++) {
      final textStyle = TextStyle(
          color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500);
      if (implementLines[i].text.length <= 40) {
        final textSpan = TextSpan(
          text: implementLines[i].text,
          style: textStyle,
        );

        final textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout(
          minWidth: 0,
          maxWidth: size.width,
        );

        if (implementLines[i].boundingBox.topCenter.dx * 1.2 <
            size.width / 0.6) {
          textPainter.paint(canvas,
              Offset(0, implementLines[i].boundingBox.center.dy / 3 + 10));
        } else {
          textPainter.paint(
              canvas,
              Offset(size.width - 110,
                  implementLines[i].boundingBox.center.dy / 3 + 10));

          canvas.drawLine(
              Offset(0, implementLines[i].boundingBox.bottom / 3 + 30),
              Offset(1000, implementLines[i].boundingBox.bottom / 3 + 30),
              Paint());
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
