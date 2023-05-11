import 'package:flutter/material.dart';
import '../../features_1_smarthome/drawer.dart';

class Community_Side extends StatefulWidget {
  const Community_Side({super.key});

  @override
  State<Community_Side> createState() => _Community_SideState();
}

class _Community_SideState extends State<Community_Side> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,

      appBar: AppBar(title: Text('Community'),),
      drawer: App_Drawer(),
      body: const Center(
        child: Text('Community', style:TextStyle(fontSize: 40)),
      )
    );  }
}