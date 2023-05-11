import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//! flutter pub run build_runner build --delete-conflicting-outputs
//* STATE  + NOTIFIER     +      PROVIDER
//?  Notifier in RIVERPOD 1 
//? 簡單的狀態管理  
//todo    StateController(provider系統自帶的notifer 不需要自己額外coding) +       StateProvider

//? 複雜的狀態管理  
//todo   StateNotifier(如果需要用到複雜的操作method去處理數據 則需要自定義notifer)   +       StateNotifierProvider

//? Future的狀態管理  
//todo                     +  FuturePROVIDER

//? Streaming的狀態管理  
//todo                     + StreamPorivder

//* ——————————————————————————————————————————————————————————————
//!　final s1NotifierProvider =  AutoDisposeNotifierProvider<S1Notifier, int>.internal()

//! Notifier in RIVERPOD 2
//! 簡單的狀態管理  s1
//! 複雜的狀態管理  s2
//todo  Notifier          +     NotifierProvider

//! Future的狀態管理  s3
//! Streaming的狀態管理  s4
//todo  AsyncNotifier      +   AsyncNotifierProvider

//* can be use for riverpod generator 

//! state會透過notifer去發動provider去改變state的data