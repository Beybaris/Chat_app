import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                return Text(chatDocs![index]['text']);
              }
          );
        }
    );
  }
}