import 'package:flutter/material.dart';

class Emojis extends StatelessWidget {

  final String emojiface;

  const Emojis({super.key, required this.emojiface});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue[400],
          borderRadius: BorderRadius.circular(16)),
      padding: EdgeInsets.all(12),
      child: Center(
        child: Text(
          emojiface, style: TextStyle(fontSize: 28),
        ),
      )
    );
  }
}
