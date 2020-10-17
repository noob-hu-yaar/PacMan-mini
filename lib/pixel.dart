import 'package:flutter/material.dart';

class MyPixel extends StatelessWidget {
  final innerColor;
  final outerColor;
  final child;

  MyPixel({this.innerColor, this.outerColor, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
              child: Container(
                padding: EdgeInsets.all(4.0),
          color: outerColor,
          child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
              child: Container(
                padding: EdgeInsets.all(4.0),
          color: innerColor,
          child: Center(child: child),
        ),
      ),
        ),
      ),
    );
  }
}
