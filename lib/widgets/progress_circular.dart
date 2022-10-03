
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressCircular extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        shape: BoxShape.circle
      ),  
      child: Platform.isAndroid ? CircularProgressIndicator() : CupertinoActivityIndicator(radius: 30.0),     
    );
  }
}