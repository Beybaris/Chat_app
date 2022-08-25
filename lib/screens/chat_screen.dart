import 'package:chat_app/widgets/chat/messages.dart';
import 'package:chat_app/widgets/chat/new_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final _firestore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  void initState() {
    final fbm = FirebaseMessaging.instance;
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    // });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage data: ${message.data}");
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onMessageOpenedApp data: ${message.data}');
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlutterChat'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: DropdownButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).primaryIconTheme.color,
                ),
                items: [
                  DropdownMenuItem(
                      child:
                      Container(
                        child:
                        Row(
                          children: [
                            Icon(Icons.exit_to_app, color: Colors.pink),
                            SizedBox(width: 8),
                            Text('Logout'),
                          ],
                        ),
                      ),
                  value: 'logout',
                  )
                ],
                onChanged: (itemIdentifier) {
                  if(itemIdentifier == 'logout') {
                    FirebaseAuth.instance.signOut();
                  }
                },
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: Message()
            ),
            NewMessage(),
          ]
        ),
      ),

    );
  }
}
