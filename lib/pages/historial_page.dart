import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicios/providers/socket_service.dart';

import 'package:servicios/widgets/item_lista_historial.dart';


class HistorialPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.on('enviarmovil', (payload) => print(payload));

    return Stack(
      children: [
        _FondoHistorial(),
        _ListaHistorial(),
        Positioned(
          top: 80,
          right: 60,
          child: FadeInDown(
            delay: Duration(seconds: 1),
            duration: Duration(seconds: 1),
            child: Image(
              image: AssetImage('assets/logo.png'),
              height: 80,
            ),
          ),
        ),
      ],
    );
  }
}

class _ListaHistorial extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final lista = ['Alumbrado Publico', 'Agua potable', 'Agua potable', 'Baches', 'Alumbrado Publico', 'Baches'];

    return Container(
      padding: EdgeInsets.only(top: size.height * 0.17),
      margin: EdgeInsets.only(left: 25, right: 25),
      child: ListView.builder(
        itemCount: lista.length,
        itemBuilder: (context, i) => ItemListaHistorial(lista[i]),
      ),
    );
  }
}

class _FondoHistorial extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(238, 231, 178, 1),
            Colors.white
          ]
        )
      ),
      child: CustomPaint(
        painter: _FondoHistortialPainert(),
      ),
    );
  }
}

class _FondoHistortialPainert extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint();

    paint.color = Color.fromRGBO(55, 56, 79, 1);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 1;

    final path = new Path();
    path.lineTo( 0, size.height * 0.23 );
    path.quadraticBezierTo( size.width * 0.15 , size.height *  0.22, size.width * 0.26 , size.height * 0.17 );
    path.quadraticBezierTo( size.width * 0.32 , size.height *  0.14, size.width * 0.38 , size.height * 0.16 );
    path.quadraticBezierTo( size.width * 0.63 , size.height *  0.27, size.width * 0.6 , size.height * 0.14 );
    path.quadraticBezierTo( size.width * 0.6 , size.height *  0.08, size.width * 0.72 , size.height * 0.08 );
    path.quadraticBezierTo( size.width * 0.89 , size.height *  0.07, size.width * 0.9 , 0);

    canvas.drawPath(path, paint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}