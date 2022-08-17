import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;

class ChatScreen extends StatelessWidget {
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
      body: StreamBuilder(
        stream: _firestore.collection('chats/Ar6IoFwJG0FXoWqjt4OR/messages').snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = snapshot.data?.docs;
          return ListView.builder(
            itemCount: documents?.length ,
            itemBuilder: (context, index) => Container(
                child: Text(documents![0]['text']),
            ) ,

          );
        },

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
