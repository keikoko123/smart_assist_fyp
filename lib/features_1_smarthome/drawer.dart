import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_assist_fyp/features_0_common/auth/repository/auth_repository.dart';
import 'package:smart_assist_fyp/features_1_smarthome/drawer_controller/1_profile/edit_profile.dart';
import 'package:smart_assist_fyp/features_1_smarthome/drawer_controller/2_relationship/group/screens/create_group_screen.dart';
import 'package:smart_assist_fyp/models_area3/user_model.dart';

import '../auth.dart';
import '../common/ui_constants.dart';
import '../common/widgets/error.dart';
import '../common/widgets/loader.dart';
import 'drawer_controller/3_InviteFamily/inivte_family.dart';

class App_Drawer extends ConsumerStatefulWidget {
  const App_Drawer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _App_DrawerState();
}

class _App_DrawerState extends ConsumerState<App_Drawer> {
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text('Sign Out'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pictureAysnc = ref.watch(currentUserAttributesProvider);
    //  ref.read(authControllerProvider).;

    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            height: 130,
            child: DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient_theme1,
              ),
              child: Center(
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: CircleAvatar(
                    radius: 50,
                    
                    backgroundImage: pictureAysnc.when(
                      data: (user) {
                        return NetworkImage(user.profilePic);
                      },
                      error: (err, trace) {
                        return NetworkImage("https://firebasestorage.googleapis.com/v0/b/smart-assist-fyp.appspot.com/o/systemPic%2Flogin_icon.png?alt=media&token=3368beaa-c0b4-434b-a539-5b680d997e44")
                        ;
                      },
                      loading: () {
                        return NetworkImage("https://firebasestorage.googleapis.com/v0/b/smart-assist-fyp.appspot.com/o/systemPic%2Flogin_icon.png?alt=media&token=3368beaa-c0b4-434b-a539-5b680d997e44");

                      }
                    ),

                    //Image.network(),
                  ),
                ),
              ),
            ),
          ),

//! 0
          SizedBox(
            height: 6,
          ),

          ListTile(
              title: Text(
                'Profile',
                style: TextStyle(
                  fontSize: 26.0,
                  color: Colors.orange[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
              leading:
                  Icon(Icons.person, color: Colors.orange[700], size: 34.0),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfile()),
                );
              }),

          SizedBox(
            height: 6,
          ),
//!

//! 1
          SizedBox(
            height: 6,
          ),

          ListTile(
              title: Text(
                'Relationship',
                style: TextStyle(
                  fontSize: 26.0,
                  color: Colors.orange[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
              leading:
                  Icon(Icons.groups, color: Colors.orange[700], size: 34.0),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateGroupScreen()),
                );
              }),

          SizedBox(
            height: 6,
          ),
//!

//! 2
          SizedBox(
            height: 6,
          ),

          ListTile(
              title: Text(
                'Invite Family',
                style: TextStyle(
                  fontSize: 26.0,
                  color: Colors.orange[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
              leading:
                  Icon(Icons.group_add, color: Colors.orange[700], size: 34.0),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Invite_Family()),
                );
              }),

          SizedBox(
            height: 6,
          ),
//!

//! 2
          SizedBox(
            height: 6,
          ),

          ListTile(
              title: Text(
                'Devices Setting',
                style: TextStyle(
                  fontSize: 26.0,
                  color: Colors.orange[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
              leading: Icon(Icons.construction,
                  color: Colors.orange[700], size: 34.0),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Invite_Family()),
                );
              }),

          SizedBox(
            height: 6,
          ),
//!

//! 2
          SizedBox(
            height: 6,
          ),

          ListTile(
              title: Text(
                'App Setting',
                style: TextStyle(
                  fontSize: 26.0,
                  color: Colors.orange[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
              leading:
                  Icon(Icons.settings, color: Colors.orange[700], size: 34.0),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Invite_Family()),
                );
              }),

          SizedBox(
            height: 6,
          ),
//!

//! 2
          SizedBox(
            height: 6,
          ),

          ListTile(
              title: Text(
                'Help',
                style: TextStyle(
                  fontSize: 26.0,
                  color: Colors.orange[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
              leading: Icon(Icons.help, color: Colors.orange[700], size: 34.0),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Invite_Family()),
                );
              }),

          SizedBox(
            height: 6,
          ),
//!

//! 2
          SizedBox(
            height: 6,
          ),

          ListTile(
              title: Text(
                'Log-Out',
                style: TextStyle(
                  fontSize: 26.0,
                  color: Colors.orange[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
              leading:
                  Icon(Icons.logout, color: Colors.orange[700], size: 34.0),
              onTap: () {
                ref.read(authRepositoryProvider).signOut(context);

              }),

          SizedBox(
            height: 6,
          ),
//!
        ],
      ),
    );
  }
}
