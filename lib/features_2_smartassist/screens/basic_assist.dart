import 'calendar_manage.dart';
import 'package:flutter/material.dart';
import '../../common/ui_constants.dart';
import '../../features_1_smarthome/drawer.dart';

class Basic_Assist extends StatefulWidget {
  const Basic_Assist({super.key});

  @override
  State<Basic_Assist> createState() => _Basic_AssistState();
}

class _Basic_AssistState extends State<Basic_Assist> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double squareHeight = height*0.13;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Smart Assist'),
        ),
        drawer: App_Drawer(),
        
        body: Center(
          child: Container(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        width: 330,
                        height: squareHeight,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(187, 255, 86, 34),
                              width: 0.25),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12)),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 173, 88, 62)
                                  .withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset:
                                  Offset(4.5, 5), // changes position of shadow
                            ),
                          ],
                          gradient: LinearGradient_theme1,
                        ), //

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.date_range,
                              color: Colors.black,
                              size: 40.0,
                            ),
                            TextButton(
                              child: Text(" Calendar",
                                  style: TextStyle(
                                      fontSize: 35,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              onPressed: () {
                                //                                  Navigator.pushNamed(context, '/Canlendar');
                                Navigator.pushNamed(context, '/calendar');
                              },
                            ),
                          ],
                        ),
                      ), //Container
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                  ],
                ),
                SizedBox(
                  height: height*0.05,
                ),

                // //!2
                // Flex(
                //   direction: Axis.horizontal,
                //   children: <Widget>[
                //     Expanded(
                //       flex: 1,
                //       child: Container(),
                //     ),
                //     Expanded(
                //       flex: 10,
                //       child: Container(
                //         width: 330,
                //         height: squareHeight,
                //         decoration: BoxDecoration(
                //           border: Border.all(
                //               color: Color.fromARGB(187, 255, 86, 34),
                //               width: 0.25),
                //           borderRadius: BorderRadius.only(
                //               topLeft: Radius.circular(12),
                //               topRight: Radius.circular(12),
                //               bottomLeft: Radius.circular(12),
                //               bottomRight: Radius.circular(12)),
                //           boxShadow: [
                //             BoxShadow(
                //               color: Color.fromARGB(255, 173, 88, 62)
                //                   .withOpacity(0.5),
                //               spreadRadius: 1,
                //               blurRadius: 7,
                //               offset:
                //                   Offset(4.5, 5), // changes position of shadow
                //             ),
                //           ],
                //           gradient: LinearGradient_theme1,
                //         ), //

                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Icon(
                //               Icons.phone,
                //               color: Colors.black,
                //               size: 40.0,
                //             ),
                //             TextButton(
                //               child: Text(" Phone Call",
                //                   style: TextStyle(
                //                       fontSize: 35,
                //                       color: Colors.black,
                //                       fontWeight: FontWeight.bold)),
                //               onPressed: () {
                //                 //                                  Navigator.pushNamed(context, '/Canlendar');
                //                 Navigator.pushNamed(context, '/phone_Call');
                //               },
                //             ),
                //           ],
                //         ),
                //       ), //Container
                //     ),
                //     Expanded(
                //       flex: 1,
                //       child: Container(),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: height*0.04,
                // ),

                //3
                Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        width: 330,
                        height: squareHeight,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(187, 255, 86, 34),
                              width: 0.25),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12)),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 173, 88, 62)
                                  .withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset:
                                  Offset(4.5, 5), // changes position of shadow
                            ),
                          ],
                          gradient: LinearGradient_theme1,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.zoom_in,
                              color: Colors.black,
                              size: 40.0,
                            ),
                            TextButton(
                              child: Text("Item Seeker",
                                  style: TextStyle(
                                      fontSize: 35,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              onPressed: () {
                                //                                  Navigator.pushNamed(context, '/Canlendar');
                                Navigator.pushNamed(context, '/Rssi_Ble');
                              },
                            ),
                          ],
                        ),
                      ), //Container
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                  ],
                ),
                SizedBox(
                  height: height*0.05,
                ),

                //4
                Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        width: 330,
                        height: squareHeight,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(187, 255, 86, 34),
                              width: 0.25),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12)),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 173, 88, 62)
                                  .withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset:
                                  Offset(4.5, 5), // changes position of shadow
                            ),
                          ],
                          gradient: LinearGradient_theme1,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.visibility,
                              color: Colors.black,
                              size: 40.0,
                            ),
                            TextButton(
                              child: Text("Label Reader",
                                  style: TextStyle(
                                      fontSize: 35,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              onPressed: () {
                                //                                  Navigator.pushNamed(context, '/Canlendar');
                                Navigator.pushNamed(context, '/Orc_Tech');
                              },
                            ),
                          ],
                        ),
                      ), //Container
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                  ],
                ),
                SizedBox(
                  height: height*0.05,
                ),

                //4
                Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        width: 330,
                        height: squareHeight,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(187, 255, 86, 34),
                              width: 0.25),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12)),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 173, 88, 62)
                                  .withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset:
                                  Offset(4.5, 5), // changes position of shadow
                            ),
                          ],
                          gradient: LinearGradient_theme1,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_a_photo,
                              color: Colors.black,
                              size: 40.0,
                            ),
                            TextButton(
                              child: Text(" Spare Cam",
                                  style: TextStyle(
                                      fontSize: 35,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              onPressed: () {
                                //                                  Navigator.pushNamed(context, '/Canlendar');
                                Navigator.pushNamed(context, '/Orc');
                              },
                            ),
                          ],
                        ),
                      ), //Container
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                  ],
                ),
               // SizedBox(),
              ], //<widget>[]
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.center,
            ), //Column
          ) //Padding
              ), //Container
        ));
  }
}
