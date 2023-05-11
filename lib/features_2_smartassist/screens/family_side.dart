// import 'package:flutter/material.dart';
// import 'drawer.dart';

// class Family_Side extends StatefulWidget {
//   const Family_Side({super.key});

//   @override
//   State<Family_Side> createState() => _Family_SideState();
// }

// class _Family_SideState extends State<Family_Side> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,

//       appBar: AppBar(
//       automaticallyImplyLeading: false,
//       title: Row(
//         children: [
//           BackButton(),
//           CircleAvatar(
//             backgroundImage: AssetImage("assets/user_A.jpg"),
//           ),
//           SizedBox(width: 20 * 0.75),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Family Chat",
//                 style: TextStyle(fontSize: 16),
//               ),
//               Text(
//                 "3 people online",
//                 style: TextStyle(fontSize: 12),
//               )
//             ],
//           )
//         ],
//       ),
//       actions: [
//         IconButton(
//           icon: Icon(Icons.local_phone),
//           onPressed: () {},
//         ),
//         IconButton(
//           icon: Icon(Icons.videocam),
//           onPressed: () {},
//         ),
//         SizedBox(width: 10),
//       ],
//     ),
//       drawer: App_Drawer(),

//       body:  Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: 20,
//         vertical: 20 / 2,
//       ),
//       decoration: BoxDecoration(
//         color: Theme.of(context).scaffoldBackgroundColor,
//         boxShadow: [
//           BoxShadow(
//             offset: Offset(0, 4),
//             blurRadius: 32,
//             color: Color(0xFF087949).withOpacity(0.08),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: Row(
//           children: [
//             Icon(Icons.input, color: Colors.orange),
//             SizedBox(width: 20),
//             Expanded(
//               child: Container(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 20 * 0.75,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.orange.withOpacity(0.05),
//                   borderRadius: BorderRadius.circular(40),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(
//                       Icons.sentiment_satisfied_alt_outlined,
//                       color: Theme.of(context)
//                           .textTheme
//                           .bodyText1!
//                           .color!
//                           .withOpacity(0.64),
//                     ),
//                     SizedBox(width: 20 / 4),
//                     Expanded(
//                       child: TextField(
//                         decoration: InputDecoration(
//                           hintText: "Type message",
//                           border: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                     Icon(
//                       Icons.attach_file,
//                       color: Theme.of(context)
//                           .textTheme
//                           .bodyText1!
//                           .color!
//                           .withOpacity(0.64),
//                     ),
//                     SizedBox(width: 20 / 4),
//                     Icon(
//                       Icons.camera_alt_outlined,
//                       color: Theme.of(context)
//                           .textTheme
//                           .bodyText1!
//                           .color!
//                           .withOpacity(0.64),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//      ),
//     );
//     }
// }