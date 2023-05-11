import 'package:flutter/material.dart';
import 'package:smart_assist_fyp/features_0_common/auth/controller/auth_controller.dart';
import 'package:smart_assist_fyp/features_1_smarthome/add_device_controller/add_device_main_screen.dart';
import 'package:smart_assist_fyp/features_1_smarthome/add_device_controller/qr_scanner_screen.dart';
import 'package:smart_assist_fyp/features_1_smarthome/drawer.dart';
import 'package:smart_assist_fyp/models_area3/user_model.dart';
import '../common/ui_constants.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:http/http.dart' as http;

final vlc_NotiferProvider =
    NotifierProvider<UrlNotifier, String>(UrlNotifier.new);

class UrlNotifier extends Notifier<String> {
  @override
  build() {
    return "";
  }

  edit(String url) {
    state = url;
  }
}

final userNameProvider =
    NotifierProvider<UrlNotifier2, String>(UrlNotifier2.new);

class UrlNotifier2 extends Notifier<String> {
  @override
  build() {
    return "";
  }

  edit(String url) {
    state = url;
  }

  edit2() async {
    UserModel? user = await ref.read(authControllerProvider).getUserData();
    state = user!.name;
  }
}

class MyHome extends ConsumerStatefulWidget {
  const MyHome({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHomeState();
}

class _MyHomeState extends ConsumerState<MyHome> {
  @override
  bool status = true;
  bool status2 = false;
  bool status3 = false;
  bool status4 = false;
  late final VlcPlayerController _vlcPlayerController;

  @override
  void initState() {
    super.initState();
    ref.read(userNameProvider.notifier).edit2();

    _vlcPlayerController = VlcPlayerController.network(
      'rtsp://192.168.1.167:5540/ch0',

      //! 你連錯IP啦, 應該是要連Router's WAN IP address,
      //!　而且要先把Router的Port Forwarding打開,
      //? OR The new tech : webrtc api flutter
      // ref.watch(vlc_NotiferProvider.notifier).state
      // 'rtsp://192.168.207.182:5540/ch0',

      //todo input and save the rtsp address / something streaming address

      hwAcc: HwAcc.disabled,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );
    setState(() {});
  }

  LinearGradient dynamicGradient = LinearGradient_theme1;
  LinearGradient fans_graident = LinearGradient_theme2;
  LinearGradient sos_graident = LinearGradient_theme2;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: App_Drawer(),
      body: SafeArea(
          minimum: const EdgeInsets.only(
            top: 18,
            left: 25,
            right: 25,
            bottom: 27,
          ),
          //多數是vertical 除非有特殊需要先用horizontal
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //if( device is success connected , show this one widget)

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Wellcome Back',
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.orange,
                                fontWeight: FontWeight.w800)),
                        Text(ref.read(userNameProvider),
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.orange,
                                fontWeight: FontWeight.w300)),
                      ],
                    ),
                    SizedBox(
                      width: 25,
                    ),

                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient_theme1,
                      ), //BoxDecoration
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              print('add device');
                              Navigator.pushNamed(context, QrScanner_Screen2.routeName);
                            },
                            child: Text('Add Device',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Icon(
                            Icons.add_sharp,
                            size: 30.0,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(),
                //BoxDecoration

                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      ClipRRect(
                        //
                        borderRadius: BorderRadius.circular(15),

                        child: VlcPlayer(
                          controller: _vlcPlayerController,
                          aspectRatio: 14 / 6.5,
                          placeholder:
                              const Center(child: CircularProgressIndicator()),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),

//! 下面係完全dynamic --------------------------------------------------------------------

                Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: 165,
                        height: 165,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient_theme1,
                        ), //BoxDecoration
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.light,
                              size: 50.0,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: Container(
                                child: TextButton(
                                  onPressed: () async {
                                    String url =
                                        'http://192.168.1.75:5000/api/isTimeTurnOff_1';
                                    final response =
                                        await http.get(Uri.parse(url));
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.black,
                                  ),
                                  child: Text(
                                    "Blub1",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: 165,
                        height: 165,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient_theme1,
                        ), //BoxDecoration
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.light,
                              size: 50.0,
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Center(
                              child: Container(
                                child: TextButton(
                                  onPressed: () async {
                                    String url =
                                        'http://192.168.1.75:5000/api/isTimeTurnOff_2';
                                    final response =
                                        await http.get(Uri.parse(url));
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.black,
                                  ),
                                  child: Text(
                                    "Blub2",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 25,
                ),

                Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: 165,
                        height: 165,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient_theme1,
                        ), //BoxDecoration
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.light,
                              size: 50.0,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: Container(
                                child: TextButton(
                                  onPressed: () async {
                                    String url =
                                        'http://192.168.1.75:5000/api/isTimeTurnOff_3';
                                    final response =
                                        await http.get(Uri.parse(url));
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.black,
                                  ),
                                  child: Text(
                                    "Blub3",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: 165,
                        height: 165,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient_theme1,
                        ), //BoxDecoration
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.light,
                              size: 50.0,
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Center(
                              child: Container(
                                child: FlutterSwitch(
                                  width: 80.0,
                                  height: 35.0,
                                  valueFontSize: 15.0,
                                  toggleSize: 45.0,
                                  value: status,
                                  borderRadius: 30.0,
                                  padding: 4.0,
                                  showOnOff: true,
                                  onToggle: (val) {
                                    setState(() {
                                      status = val;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 25,
                ),



                Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: 165,
                        height: 165,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient_theme1,
                        ), //BoxDecoration
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.light,
                              size: 50.0,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: Container(
                                child: TextButton(
                                  onPressed: () async {
                                    String url =
                                        'http://192.168.1.75:5000/api/isTimeTurnOff_1';
                                    final response =
                                        await http.get(Uri.parse(url));
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.black,
                                  ),
                                  child: Text(
                                    "Blub1",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: 165,
                        height: 165,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient_theme1,
                        ), //BoxDecoration
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.light,
                              size: 50.0,
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Center(
                              child: Container(
                                child: TextButton(
                                  onPressed: () async {
                                    String url =
                                        'http://192.168.1.75:5000/api/isTimeTurnOff_2';
                                    final response =
                                        await http.get(Uri.parse(url));
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.black,
                                  ),
                                  child: Text(
                                    "Blub2",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 25,
                ),



                Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: 165,
                        height: 165,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient_theme1,
                        ), //BoxDecoration
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.light,
                              size: 50.0,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: Container(
                                child: TextButton(
                                  onPressed: () async {
                                    String url =
                                        'http://192.168.1.75:5000/api/isTimeTurnOff_1';
                                    final response =
                                        await http.get(Uri.parse(url));
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.black,
                                  ),
                                  child: Text(
                                    "Blub1",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: 165,
                        height: 165,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient_theme1,
                        ), //BoxDecoration
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.light,
                              size: 50.0,
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Center(
                              child: Container(
                                child: TextButton(
                                  onPressed: () async {
                                    String url =
                                        'http://192.168.1.75:5000/api/isTimeTurnOff_2';
                                    final response =
                                        await http.get(Uri.parse(url));
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.black,
                                  ),
                                  child: Text(
                                    "Blub2",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 25,
                ),
 
                Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: 165,
                        height: 165,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: fans_graident,
                        ), //BoxDecoration
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.wind_power,
                              size: 50.0,
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Center(
                              child: Container(
                                child: FlutterSwitch(
                                  width: 80.0,
                                  height: 35.0,
                                  valueFontSize: 15.0,
                                  toggleSize: 45.0,
                                  value: status2,
                                  borderRadius: 30.0,
                                  padding: 4.0,
                                  showOnOff: true,
                                  onToggle: (val) {
                                    setState(() {
                                      status2 = val;
                                      fans_graident = LinearGradient_theme1;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: 165,
                        height: 165,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: sos_graident,
                        ), //BoxDecoration
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {},
                              iconSize: 100,
                              icon: const Icon(
                                Icons.add,
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 25,
                ),

                Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: 165,
                        height: 165,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: fans_graident,
                        ), //BoxDecoration
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.wind_power,
                              size: 50.0,
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Center(
                              child: Container(
                                child: FlutterSwitch(
                                  width: 80.0,
                                  height: 35.0,
                                  valueFontSize: 15.0,
                                  toggleSize: 45.0,
                                  value: status2,
                                  borderRadius: 30.0,
                                  padding: 4.0,
                                  showOnOff: true,
                                  onToggle: (val) {
                                    setState(() {
                                      status2 = val;
                                      fans_graident = LinearGradient_theme1;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: 165,
                        height: 165,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: sos_graident,
                        ), //BoxDecoration
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {},
                              iconSize: 100,
                              icon: const Icon(
                                Icons.add,
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                                SizedBox(
                  height: 25,
                ),

                Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: 165,
                        height: 165,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: fans_graident,
                        ), //BoxDecoration
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.wind_power,
                              size: 50.0,
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Center(
                              child: Container(
                                child: FlutterSwitch(
                                  width: 80.0,
                                  height: 35.0,
                                  valueFontSize: 15.0,
                                  toggleSize: 45.0,
                                  value: status2,
                                  borderRadius: 30.0,
                                  padding: 4.0,
                                  showOnOff: true,
                                  onToggle: (val) {
                                    setState(() {
                                      status2 = val;
                                      fans_graident = LinearGradient_theme1;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: 165,
                        height: 165,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: sos_graident,
                        ), //BoxDecoration
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {},
                              iconSize: 100,
                              icon: const Icon(
                                Icons.add,
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 25,
                ),

                Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: 165,
                        height: 165,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient_theme2,
                        ), //BoxDecoration
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.light,
                              size: 50.0,
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Center(
                              child: Container(
                                child: FlutterSwitch(
                                  width: 80.0,
                                  height: 35.0,
                                  valueFontSize: 15.0,
                                  toggleSize: 45.0,
                                  value: status3,
                                  borderRadius: 30.0,
                                  padding: 4.0,
                                  showOnOff: true,
                                  onToggle: (val2) {
                                    setState(() {
                                      status3 = val2;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: 165,
                        height: 165,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient_theme2,
                        ), //BoxDecoration
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.light,
                              size: 50.0,
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Center(
                              child: Container(
                                child: FlutterSwitch(
                                  width: 80.0,
                                  height: 35.0,
                                  valueFontSize: 15.0,
                                  toggleSize: 45.0,
                                  value: status4,
                                  borderRadius: 30.0,
                                  padding: 4.0,
                                  showOnOff: true,
                                  onToggle: (val) {
                                    setState(() {
                                      status4 = val;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 25,
                ),
              ],
            ),
          )),
    );
  }
}
