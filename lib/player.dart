import 'package:flutter/material.dart';

class MyPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.6),
      child: Image.asset(
        'assets/images/pacman0.png'
      ),
    );
  }
}