//! 一塊EESP32-型號A  集成於data collecti的modules
//? 專用於收集data 運送到server處理

//! 編號 XXXXXXX-A

//! 轉成 QR CODE

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddDevice extends ConsumerStatefulWidget {
  static const String routeName = '/add_Device';

  const AddDevice({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddDeviceState();
}

class _AddDeviceState extends ConsumerState<AddDevice> {

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("data"),);
  }
}

