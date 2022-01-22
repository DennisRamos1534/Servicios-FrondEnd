import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicios/providers/ui_provider.dart';

class ImagenReporte extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final uiProvider = Provider.of<UiProvider>(context); 

    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 50),
      child: Container(
        decoration: _imagenDecoration(),
        width: double.infinity,
        height: size.height * 0.4,
        child: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(45)),
          child: BounceInDown(
            delay: Duration(seconds: 1),
            child: getImage(uiProvider.imagePath),
          ),
        ),    
      ),
    );
  }

  Widget getImage(String url) {

    if(url == '')
      return Image(
        image: AssetImage('assets/no-image.png'),
        fit: BoxFit.cover,
      );
    
    return Image.file(
      File(url),
      fit: BoxFit.cover,
    );
      // return FadeInImage(
      //   placeholder: AssetImage('assets/jar-loading.gif'), 
      //   image: NetworkImage('https://icons.iconarchive.com/icons/bokehlicia/captiva/256/multimedia-photo-manager-icon.png'),
      //   fit: BoxFit.cover,
      // );
  }

  BoxDecoration _imagenDecoration() => BoxDecoration(
    // color: Colors.black12,
    borderRadius: BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(45)),
    boxShadow: [
      BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, 5), spreadRadius: 5)
    ]
  );
}