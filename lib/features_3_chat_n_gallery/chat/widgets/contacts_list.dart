import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/chat/controller/chat_controller.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/colors.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/chat/screens/mobile_chat_screen.dart';
import 'package:smart_assist_fyp/models_area3/chat_contact.dart';
import 'package:smart_assist_fyp/models_area3/group.dart';

import '../../../common/widgets/loader.dart';






class test_model_Notifier extends Notifier<Group> {
  @override
   build() async{
    
  }
}






class ContactsList extends ConsumerWidget {
  const ContactsList({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          StreamBuilder<List<Group>>(
              stream: ref.watch(chatControllerProvider).chatGroups(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loader();
                }

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var groupData = snapshot.data![index];
                    //groupData.membersUid.add
                    return (groupData.membersUid.length <= 1) 
                      ? const SizedBox()
                    : Card(
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          height: 135,
                          padding: const EdgeInsets.all(0),
                          child: Row(children: [
                            Expanded(
                              flex: 8,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black54, width: 0),
                                    borderRadius: BorderRadius.circular(130),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            groupData.groupPic),
                                        fit: BoxFit.fitHeight)),
                              ),
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            Expanded(
                              flex: 15,
                              child: Container(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            MobileChatScreen.routeName,
                                            arguments: {
                                              'name': groupData.name,
                                              'uid': groupData.groupId,
                                              'isGroupChat': true,
                                              'profilePic':
                                                  groupData.groupPic,
                                            },
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: SizedBox(
                                            height: 100,
                                            child: ListTile(
                                              title: Text(
                                                maxLines: 1,
                                                groupData.name,
                                                style: const TextStyle(
                                                  fontSize: 25,
                                                ),
                                              ),
                                              subtitle: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6.0),
                                                child: Text(
                                                  maxLines: 3,
                                                  groupData.lastMessage,
                                                  style: const TextStyle(
                                                      fontSize: 20),
                                                ),
                                              ),
                                              trailing: Text(
                                                DateFormat.Hm().format(
                                                    groupData.timeSent),
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // const Divider(
                                      //     color: dividerColor, indent: 85),
                                    ],
                                  )),
                            ),
                          ]),
                        ),
                      );
                  },
                );
              }),

              //!!!!!!
          StreamBuilder<List<ChatContact>>(
              stream: ref.watch(chatControllerProvider).chatContacts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loader();
                }
                return ConstrainedBox(
                  constraints: new BoxConstraints(
                    minHeight: 35.0,
                    maxHeight: 3000.0,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length, //?info.length,

                    itemBuilder: (context, index) {
                      var chatContactData = snapshot.data![index];
                      return Card(
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          height: 130,
                          padding: const EdgeInsets.all(0),
                          child: Row(children: [
                            Expanded(
                              flex: 8,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black54, width: 0),
                                    borderRadius: BorderRadius.circular(130),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            chatContactData.profilePic),
                                        fit: BoxFit.fitHeight)),
                              ),
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            Expanded(
                              flex: 15,
                              child: Container(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            MobileChatScreen.routeName,
                                            arguments: {
                                              'name': chatContactData.name,
                                              'uid': chatContactData.contactId,
                                              'isGroupChat': false,
                                              'profilePic':
                                                  chatContactData.profilePic,
                                            },
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: SizedBox(
                                            height: 100,
                                            child: ListTile(
                                              title: Text(
                                                maxLines: 1,
                                                chatContactData.name,
                                                style: const TextStyle(
                                                  fontSize: 25,
                                                ),
                                              ),
                                              subtitle: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6.0),
                                                child: Text(
                                                  maxLines: 3,
                                                  chatContactData.lastMessage,
                                                  style: const TextStyle(
                                                      fontSize: 20),
                                                ),
                                              ),
                                              trailing: Text(
                                                DateFormat.Hm().format(
                                                    chatContactData.timeSent),
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // const Divider(
                                      //     color: dividerColor, indent: 85),
                                    ],
                                  )),
                            ),
                          ]),
                        ),
                      );
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }
}
