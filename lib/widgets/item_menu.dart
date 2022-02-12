import 'package:flutter/material.dart';

class ItemMenu extends StatelessWidget {

  final IconData icon;
  final String nombre;

  const ItemMenu({required this.icon, required this.nombre});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        gradient: RadialGradient(
          colors: [
            Color.fromRGBO(234, 234, 236, 1),
            Color(0xFFe5dde6)
          ]
        ),
        boxShadow: <BoxShadow> [
          BoxShadow(spreadRadius: 2, blurRadius: 70, color: Colors.black12)
        ]
      ),
    
      child: _Item(this.icon, this.nombre),
    );
  }
}

class _Item extends StatelessWidget {

  final IconData icon;
  final String nombre;

  const _Item(this.icon, this.nombre);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          
          Icon(this.icon, color: Color.fromRGBO(222, 113, 82, 1), size: 80),
      
        SizedBox(height: 10),
        Text(this.nombre, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
      ],
    );
  }
}