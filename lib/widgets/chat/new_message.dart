import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = '';
  final _firestore = FirebaseFirestore.instance;
  final _textController = TextEditingController();


  void _sendMessage() {
    FocusScope.of(context).unfocus();
    _firestore.collection('chat').add({
      'text' : _enteredMessage,
      'createdAt' : Timestamp.now(),
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
