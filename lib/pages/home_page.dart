import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:servicios/providers/ui_provider.dart';

import 'package:servicios/pages/servicios_page.dart';
import 'package:servicios/pages/historial_page.dart';
import 'package:servicios/pages/usuario_page.dart';


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      
      body: _HomePageBody(),
      bottomNavigationBar: _BarraNavegacion(),
    );
  }
}

class _BarraNavegacion extends StatefulWidget {

  @override
  __BarraNavegacionState createState() => __BarraNavegacionState();
}

class __BarraNavegacionState extends State<_BarraNavegacion> {

  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UiProvider>(context);
    int currentIndex = uiProvider.selectedMenuOpt;

    return CurvedNavigationBar(
      
      index: currentIndex,
      height: 70.0,
      items: [
        Icon(Icons.data_usage_rounded, size: 30, color: Colors.white),
        Icon(Icons.home, size: 30, color: Colors.white),
        Icon(Icons.person, size: 30, color: Colors.white),
      ],
      color: Color.fromRGBO(56, 56, 78, 1),
      buttonBackgroundColor: Color.fromRGBO(222, 113, 82, 1),
      backgroundColor: Colors.white,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 600),
      onTap: (index) {
        setState(() {
          uiProvider.selectedMenuOpt = index;
        });
      },
      letIndexChange: (index) => true,
    );
  }
}

class _HomePageBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;

    switch(currentIndex) {

      case 0: 
        return HistorialPage();
      
      case 1: 
        return ServiciosPage();

      case 2:
        return UsuarioPage();

      default:
        return ServiciosPage();
    }
  }
}
