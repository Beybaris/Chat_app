import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = '';
  final _firestore = FirebaseFirestore.instance;
  final _textController = TextEditingController();


  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();
    _firestore.collection('chat').add({
      'text' : _enteredMessage,
      'createdAt' : Timestamp.now(),
      'userId' : user?.uid,
      'username' : userData['username'],
      'userImage' : userData['image_url'],
    });
    _textController.clear();

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'Send a message...',
                ),
                onChanged: (value) {
                  setState(() {
                    _enteredMessage = value;
                  });
                },
              ),
            ),
            IconButton(
              icon: Icon(
                  Icons.send
              ),
              onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage
              ,
            )
          ],
        ),
      ),
    );
  }
}
