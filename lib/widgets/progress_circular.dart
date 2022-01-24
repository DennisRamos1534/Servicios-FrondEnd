import 'package:flutter/material.dart';

class ProgressCircular extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        shape: BoxShape.circle
      ),
      child: CircularProgressIndicator(),     
    );
  }
}