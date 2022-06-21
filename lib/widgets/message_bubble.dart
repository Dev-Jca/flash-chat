import 'package:flutter/material.dart';

class MessagesBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMe;
  const MessagesBubble(
      {required this.isMe, required this.sender, required this.text, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Text(
            sender,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Material(
              borderRadius: BorderRadius.only(
                topLeft:
                    isMe ? const Radius.circular(0) : const Radius.circular(30),
                bottomLeft: const Radius.circular(30),
                bottomRight: const Radius.circular(30),
                topRight:
                    isMe ? const Radius.circular(30) : const Radius.circular(0),
              ),
              elevation: 5.0,
              color: isMe ? Colors.white : Colors.lightBlueAccent,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10,
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    color: isMe ? Colors.black54 : Colors.white,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
