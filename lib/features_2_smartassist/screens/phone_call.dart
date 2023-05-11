import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

class Phone_Call extends StatefulWidget {
  const Phone_Call({super.key});
  static const String routeName = '/phone_Call';

  @override
  State<Phone_Call> createState() => _Phone_CallState();
}

class _Phone_CallState extends State<Phone_Call> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Contact List"),
      ),
      body: Container(
        height: double.infinity,
        child: FutureBuilder(
          future: getContacts(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: SizedBox(height: 50, child: CircularProgressIndicator()),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Contact contact = snapshot.data[index];
                  return Column(children: [
                    ListTile(
                      leading: const CircleAvatar(
                        radius: 20,
                        child: Icon(Icons.person),
                      ),
                      title: Text(contact.displayName,   style: TextStyle( fontSize: 50)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(contact.phones[0] ,  style: TextStyle( fontSize: 22)),
                          //Text(contact.emails[0]),
                        ],
                      ),
                    ),
                    const Divider()
                  ]);
                });
          },
        ),
      ),
    );
  }

  Future<List<Contact>> getContacts() async {
    bool isGranted = await Permission.contacts.status.isGranted;
    if (!isGranted) {
      isGranted = await Permission.contacts.request().isGranted;
    }
    if (isGranted) {
      return await FastContacts.allContacts;
    }
    return [];
  }
}
