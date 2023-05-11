// import 'dart:collection';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';




// //! Provider 1
// final number1_NormalProvider = Provider<int>((ref) {
//   return 17;
// });
// //! Provider 2
// final number2_State_Provider = StateProvider<int>((ref) {
//   return 27;
// });
// //! Provider 3
// //todo Notifer
// class Number3_Notifier extends StateNotifier<List<int>> {
//   Number3_Notifier(): super([]);
  
//   void add(){
//   }

//   void delete(){
//   }
// }

// final number3_State_NotiferProvider = StateNotifierProvider<Number3_Notifier, List<int>>((ref) {
//   return Number3_Notifier();
// });



// //! Provider 4
// class Number4_ChangeNotifier extends ChangeNotifier {
//   final List<int> _numbers = [];

//   UnmodifiableListView<int> get numbers => UnmodifiableListView(_numbers) ;

// }

// final number4_changeProvider = ChangeNotifierProvider<Number4_ChangeNotifier>((ref) {
//   return Number4_ChangeNotifier();
// });

// //! Provider 5
// final number5_futureProvider = FutureProvider<int>((ref) async {
//   return Future.value(52);
// });

// //! Provider 6
// final number6_streamProvider = StreamProvider.autoDispose<int>((ref) async* {
//   Stream.value(99);
// });




// class testProvdierXYZ extends ConsumerStatefulWidget {
//   const testProvdierXYZ({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _testProvdierXYZState();
// }

// class _testProvdierXYZState extends ConsumerState<testProvdierXYZ> {

//   @override
//   Widget build(BuildContext context) {

//     //todo Provider 1
//     final number1 = ref.watch(number1_NormalProvider);


//     //todo Provider 2
//     final number2 = ref.watch(number2_State_Provider.notifier).state;


//     //todo Provider 3
//     final number3 = ref.watch(number3_State_NotiferProvider.notifier).state  ;


//     //todo Provider 4
//     final number4 = ref.watch(number4_changeProvider)  ;


//     //todo Provider 5
//     final number5 = ref.watch(number5_futureProvider);


//     //todo Provider 6
//     final number6 = ref.watch(number6_streamProvider);
//     //todo Provider 7







//     return Scaffold();
//   }
// }