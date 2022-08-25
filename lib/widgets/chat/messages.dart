import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Message extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection('chat').where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid).get(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
          stream: FirebaseFirestore.instance.collection('chat').orderBy('createdAt', descending: true).snapshots(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          final chatDocs = snapshot.data?.docs;
          return ListView.builder(
                    reverse: true,
                    itemCount: chatDocs?.length,
                    itemBuilder: (context, index) {
                      return MessageBubble(
                        message: chatDocs![index]['text'],
                        isMe: chatDocs[index]['userId'] == snapshot.data?.docs[0].get('userId'),
                        username: chatDocs[index]['username'],
                        userImage: chatDocs[index]['userImage'],
                      );
                    }
                );
              });
        }
    );
  }
}
