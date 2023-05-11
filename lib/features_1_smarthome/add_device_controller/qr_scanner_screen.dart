import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:smart_assist_fyp/app_home.dart';
import 'package:smart_assist_fyp/features_0_common/auth/controller/auth_controller.dart';
import 'package:smart_assist_fyp/features_0_common/auth/repository/auth_repository.dart';
import 'package:smart_assist_fyp/features_1_smarthome/drawer_controller/2_relationship/group/controller/group_controller.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/chat/screens/mobile_chat_screen%20copy.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/chat/widgets/chat_list.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/gallery/controller/gallery_controller.dart';
import 'package:smart_assist_fyp/models_area3/photo_model.dart';
import 'package:smart_assist_fyp/models_area3/user_model.dart';

import '../../../../../models_area3/group.dart';

class QrCode_Notifier extends Notifier<String> {
  @override
  build() {
    return "No QR CODE NOW!";
  }

  void scanned(BuildContext context, String scannedGroupID) {
    debugPrint("state is :" + state);

    if (state != scannedGroupID) {
      state = scannedGroupID;
      fillFormAuto(context, state);
    }
  }

  Future<void> fillFormAuto(BuildContext context, String scannedGroupID) async {
    

      Navigator.push(context, MaterialPageRoute(builder: (context) => Home())
      
      );

  }

}

final qr_provider2 = NotifierProvider<QrCode_Notifier, String>(() {
  return QrCode_Notifier();
});


class QrScanner_Screen2 extends ConsumerStatefulWidget {
  static const String routeName = '/qr_screen2';

  const QrScanner_Screen2({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QrScanner_Screen2State();
}

class _QrScanner_Screen2State extends ConsumerState<QrScanner_Screen2> {
  late MobileScannerController controller = MobileScannerController();
  Barcode? barcode;
  BarcodeCapture? capture;

  //! ---------------
  Future<void> onDetect(BarcodeCapture barcode) async {
    capture = barcode;
    setState(() => this.barcode = barcode.barcodes.first);
    String test1 = "asd ";
    test1 = barcode.barcodes[0].rawValue!;

    ref.read(qr_provider2.notifier).scanned(context, test1);

  }

  MobileScannerArguments? arguments;

  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.of(context).size.center(Offset.zero),
      width: 280,
      height: 280,
    );
    return Scaffold(
      backgroundColor: Colors.black,
      body: Builder(
        builder: (context) {
          return Stack(
            fit: StackFit.expand,
            children: [
              MobileScanner(
                fit: BoxFit.contain,
                scanWindow: scanWindow,
                controller: controller,
                onScannerStarted: (arguments) {
                  setState(() {
                    this.arguments = arguments;
                  });
                },
                onDetect: onDetect,
              ),
              if (barcode != null &&
                  barcode?.corners != null &&
                  arguments != null)
                CustomPaint(
                  painter: BarcodeOverlay(
                    barcode: barcode!,
                    arguments: arguments!,
                    boxFit: BoxFit.contain,
                    capture: capture!,
                  ),
                ),
              CustomPaint(
                painter: ScannerOverlay(scanWindow),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: 100,
                  color: Colors.black.withOpacity(0.4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 120,
                          height: 50,
                          child: FittedBox(
                            child: Text(
                              barcode?.displayValue ?? 'Scan something!',
                              overflow: TextOverflow.fade,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 286,
                  height: 286,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.orange,
                      width: 4,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ScannerOverlay extends CustomPainter {
  ScannerOverlay(this.scanWindow);

  final Rect scanWindow;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPath = Path()..addRect(Rect.largest);
    final cutoutPath = Path()..addRect(scanWindow);

    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );
    canvas.drawPath(backgroundWithCutout, backgroundPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class BarcodeOverlay extends CustomPainter {
  BarcodeOverlay({
    required this.barcode,
    required this.arguments,
    required this.boxFit,
    required this.capture,
  });

  final BarcodeCapture capture;
  final Barcode barcode;
  final MobileScannerArguments arguments;
  final BoxFit boxFit;

  @override
  void paint(Canvas canvas, Size size) {
    if (barcode.corners == null) return;
    final adjustedSize = applyBoxFit(boxFit, arguments.size, size);

    double verticalPadding = size.height - adjustedSize.destination.height;
    double horizontalPadding = size.width - adjustedSize.destination.width;
    if (verticalPadding > 0) {
      verticalPadding = verticalPadding / 2;
    } else {
      verticalPadding = 0;
    }

    if (horizontalPadding > 0) {
      horizontalPadding = horizontalPadding / 2;
    } else {
      horizontalPadding = 0;
    }

    final ratioWidth =
        (Platform.isIOS ? capture.width! : arguments.size.width) /
            adjustedSize.destination.width;
    final ratioHeight =
        (Platform.isIOS ? capture.height! : arguments.size.height) /
            adjustedSize.destination.height;

    final List<Offset> adjustedOffset = [];
    for (final offset in barcode.corners!) {
      adjustedOffset.add(
        Offset(
          offset.dx / ratioWidth + horizontalPadding,
          offset.dy / ratioHeight + verticalPadding,
        ),
      );
    }
    final cutoutPath = Path()..addPolygon(adjustedOffset, true);

    final backgroundPaint = Paint()
      ..color = Colors.red.withOpacity(0.3)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    canvas.drawPath(cutoutPath, backgroundPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
