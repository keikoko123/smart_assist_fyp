import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/services.dart';
import 'package:beacons_plugin/beacons_plugin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class Riss_Ble extends ConsumerStatefulWidget {
  const Riss_Ble({super.key});
  static const String routeName = '/Rssi_Ble';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Riss_BleState();
}

class _Riss_BleState extends ConsumerState<Riss_Ble> {


    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // void _showNotification(String subtitle) {
  //   var rng = new Random();
  //   Future.delayed(Duration(seconds: 2)).then((result) async {
  //     var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
  //         'your channel id', 'your channel name',
  //         importance: Importance.high,
  //         priority: Priority.high,
  //         ticker: 'ticker');
  //     var platformChannelSpecifics =
  //         NotificationDetails(android: androidPlatformChannelSpecifics);
  //     await flutterLocalNotificationsPlugin
  //         .show(rng.nextInt(100000), _tag, subtitle, platformChannelSpecifics,
  //             payload: 'item x')
  //         .onError((error, stackTrace) {
  //       print("Notification error is $error");
  //     });
  //   });
  // }


  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  List<ScanResult> scanResultList = [];
  bool _isScanning = false;
  String _isForgetBring = 'Forgotten Bring Key!!!';

  @override
  initState() {
    super.initState();
    initBle();
  }

  void initBle() {
    flutterBlue.isScanning.listen((isScanning) {
      _isScanning = isScanning;

      if (mounted) {
        setState(() {
        });
      }
    });
  }

  scan() async {
    if (!_isScanning) {
      scanResultList.clear();
      flutterBlue.startScan(timeout: Duration(seconds: 4));
      flutterBlue.scanResults.listen((results) {
        scanResultList = results;

        for (int i = 0; i < scanResultList.length; i++) {
          if (scanResultList[i].device.id.id.compareTo('FF:FF:10:88:D8:B2') ==
              0) {
            if (scanResultList[i].rssi >= 90) {
              _isForgetBring = 'Forgotten Bring Key!!!';
              print(_isForgetBring);
            } else {
              _isForgetBring = 'Nothing Forgot';
              print(_isForgetBring);
            }
          }
        }
        if (mounted) {
          setState(() {
            //! 
          });
        }
      });
    } else {
      flutterBlue.stopScan();
    }
  }


  Widget deviceSignal(ScanResult r) {
    return Text(r.rssi.toString());
  }

  Widget deviceMacAddress(ScanResult r) {
    return Text(r.device.id.id);
  }

  Widget deviceName(ScanResult r) {
    String name = '';

    if (r.device.name.isNotEmpty) {
      name = r.device.name;
    } else if (r.advertisementData.localName.isNotEmpty) {
      name = r.advertisementData.localName;
    } else {
      name = 'N/A';
    }

    return Text(name);
  }

  /* BLE 아이콘 위젯 */
  Widget leading(ScanResult r) {
    return CircleAvatar(
      child: Icon(
        Icons.bluetooth,
        color: Colors.white,
      ),
      backgroundColor: Colors.orange,
    );
  }

  /* 장치 아이템 위젯 */
  Widget listItem(ScanResult r) {
    return ListTile(
      leading: leading(r),
      title: deviceName(r),
      subtitle: deviceMacAddress(r),
      trailing: deviceSignal(r),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isForgetBring),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.orange, //here give the text color
        elevation: 0,
      ),
      body: Center(
        child: ListView.separated(
          itemCount: scanResultList.length,
          itemBuilder: (context, index) {
            return listItem(scanResultList[index]);
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: scan,
        child: Icon(_isScanning ? Icons.stop : Icons.search),
      ),
    );
  }
}
