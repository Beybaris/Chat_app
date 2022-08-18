import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageBubble extends StatelessWidget {
  final String username;
  final String message;
  final bool isMe;

  const MessageBubble({required this.message, required this.isMe, required this.username});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
                topLeft: isMe ? Radius.circular(0) : Radius.circular(12),
                topRight: isMe ? Radius.circular(12) : Radius.circular(0),
              ),
              color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
            ),

            width: 150,
            padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15
            ),
            child: Column(
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(username, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  message,
                  style: TextStyle(
                  fontSize: 16,
                  color: isMe ? Colors.black : Theme.of(context).accentTextTheme.titleMedium?.color,
                ),
                textAlign: isMe ? TextAlign.end : TextAlign.start,
                ),
              ],
            )
          ),
        ),
      ],
    );
  }
}
