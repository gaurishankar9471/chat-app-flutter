import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String messgae;
  final bool isCurrentUser;
  ChatBubble({super.key, required this.messgae, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 5.5, horizontal: 25),
      decoration: BoxDecoration(
          color: isCurrentUser ? Colors.green : Colors.grey.shade500,
          borderRadius: BorderRadius.circular(12)),
      child: Text(messgae),
    );
  }
}
