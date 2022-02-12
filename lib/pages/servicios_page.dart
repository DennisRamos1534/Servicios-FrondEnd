import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:servicios/models/arguments.dart';

import 'package:servicios/widgets/header_home.dart';
import 'package:servicios/widgets/item_menu.dart';


class ServiciosPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        HeaderHome(),
        _MenuHome(),
      ],
    );
  }
}


class _MenuHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.42),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'reporte', arguments: Arguments(Icons.lightbulb, 'Alumbrado Publico')),
                  child: FadeIn(
                    delay: Duration(milliseconds: 400),
                    duration: Duration(milliseconds: 600),
                    child: ItemMenu(icon: Icons.lightbulb, nombre: 'Alumbrado Publico',)
                  )
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'reporte', arguments: Arguments(Icons.edit_road_rounded, 'Baches')),
                  child: FadeIn(
                    delay: Duration(milliseconds: 500),
                    duration: Duration(milliseconds: 600),
                    child: ItemMenu(icon: Icons.edit_road_rounded, nombre: 'Baches',)
                  )
                )
              ], 
            ),
      
            SizedBox(height: 20),
      
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'reporte', arguments: Arguments(Icons.water, 'Agua Potable')),
                  child: FadeIn(
                    delay: Duration(milliseconds: 600),
                    duration: Duration(milliseconds: 600),
                    child: ItemMenu(icon: Icons.water, nombre: 'Agua Potable',)
                  )
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'reporte', arguments: Arguments(Icons.manage_accounts_rounded, 'Otros')),
                  child: FadeIn(
                    delay: Duration(milliseconds: 700),
                    duration: Duration(milliseconds: 600),
                    child: ItemMenu(icon: Icons.manage_accounts_rounded, nombre: 'Otros',)
                  )
                )
              ], 
            ),
            SizedBox(height: size.height * 0.05),
          ],
        ),
      ),
    );
  }
}