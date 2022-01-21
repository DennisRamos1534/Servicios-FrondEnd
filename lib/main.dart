import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:servicios/providers/ui_provider.dart';
import 'package:servicios/providers/auth_provider.dart';
import 'package:servicios/providers/socket_service.dart';

import 'package:servicios/pages/loading_page.dart';
import 'package:servicios/pages/login_page.dart';
import 'package:servicios/pages/registro_page.dart';
import 'package:servicios/pages/home_page.dart';
import 'package:servicios/pages/reporte_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => SocketService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Servicios App',
        initialRoute: 'loading',
        routes: {
          'home' : (_) => HomePage(),
          'login' : (_) => LoginPage(),
          'registro' : (_) => RegistroPage(),
          'reporte' : (_) => ReportePage(),
          'loading' : (_) => LoadingPage(),
        },
      ),
    );
  }
}