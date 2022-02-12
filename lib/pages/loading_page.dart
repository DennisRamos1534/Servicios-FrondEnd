import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:servicios/providers/auth_provider.dart';
import 'package:servicios/providers/socket_service.dart';


class LoadingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: ( context, snapshot) {

          return Center(
            child: Platform.isAndroid ? CircularProgressIndicator() : CupertinoActivityIndicator(radius: 50),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context ) async {

    final authProvier = Provider.of<AuthProvider>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);
    
    final autenticado = await authProvier.isLoggedIn();

    if(autenticado) {
      // conectar al socket server
      socketService.connect();
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}