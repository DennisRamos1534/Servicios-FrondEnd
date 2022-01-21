import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';

import 'package:servicios/providers/auth_provider.dart';

class HeaderHome extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        HeaderHomeBlanco(Colors.white),
        HeaderHomePainert(Color(0xff373851)),
        HeaderHomeNaranja(),
        HeaderHomeMorado(),
        Positioned(top: 50, left: 30, child: _AvatarHome()),
        _TituloHeader(),
      ],
    );
  }
}

class _TituloHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: size.height * 0.2, left: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInLeft(
            delay: Duration(milliseconds: 500),
            duration: Duration(milliseconds: 500),
            child: Text('Bienvenidos a', style: TextStyle(color: Colors.white, fontSize: 30, fontFamily: 'Pacifico', fontWeight: FontWeight.bold))
          ),
          // SizedBox(height: 5),
          FadeInLeft(
            delay: Duration(milliseconds: 650),
            duration: Duration(milliseconds: 500),
            child: Text('Servicos del Ayuntamiento', style: TextStyle(color: Colors.white, fontFamily: 'LobsterTwo', fontSize: 25))
          )
        ],
      ),
    );
  }
}

class _AvatarHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);
    final usuario = authProvider.usuario;

    return FadeInDown(
      delay: Duration(milliseconds: 750),
      duration: Duration(milliseconds: 500),
      child: CircleAvatar(
        // backgroundColor: Color.fromRGBO(228, 224, 230, 1),
        // backgroundColor: Color.fromRGBO(228, 213, 170, 1),
        backgroundColor: Color.fromRGBO(222, 113, 82, 1),
        radius: 30.0,
        child: Text(usuario.nombre.substring(0,2), style: TextStyle(fontSize: 20)),
      ),
    );
  }
}


class HeaderHomePainert extends StatelessWidget {

  final Color color;

  HeaderHomePainert(this.color);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 590,
      width: double.infinity,
      child: CustomPaint(
        painter: _HeaderHomePainert(this.color),
      ),
    );
  }
}


class _HeaderHomePainert extends CustomPainter {

  final Color color;

  _HeaderHomePainert(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint();

    paint.color = this.color;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 5;

    final path = new Path();
    path.lineTo( 0, size.height * 0.48 );
    // path.addArc(oval, startAngle, sweepAngle)
    path.quadraticBezierTo( size.width * 0.07 , size.height *  0.58, size.width * 0.25 , size.height * 0.58 );
    path.quadraticBezierTo( size.width * 0.3 , size.height * 0.58 , size.width * 0.7 , size.height * 0.57 );
    path.quadraticBezierTo( size.width * 0.95 , size.height * 0.57 , size.width , size.height * 0.66 );
    path.lineTo( size.width , 0.7);

    canvas.drawPath(path, paint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}


class HeaderHomeBlanco extends StatelessWidget {

  final Color color;

  HeaderHomeBlanco(this.color);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 590,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: <BoxShadow> [
          BoxShadow(blurRadius: 50, spreadRadius: 2, color: Colors.black12, offset: Offset(0, -180))
        ]
      ),
      child: CustomPaint(
        painter: _HeaderHomeBlanco(this.color),
      ),
    );
  }
}


class _HeaderHomeBlanco extends CustomPainter {

  final Color color;

  _HeaderHomeBlanco(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint();

    paint.color = this.color;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 5;

    final path = new Path();
    path.lineTo( 0, size.height * 0.51 );
    path.quadraticBezierTo( size.width * 0.07 , size.height *  0.6, size.width * 0.3 , size.height * 0.6 );
    path.quadraticBezierTo( size.width * 0.75 , size.height * 0.58 , size.width * 0.75 , size.height * 0.59 );
    path.quadraticBezierTo( size.width * 0.99 , size.height * 0.6 , size.width , size.height * 0.73 );
    path.lineTo( size.width , 0 );

    canvas.drawPath(path, paint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class HeaderHomeNaranja extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      child: CustomPaint(
        painter: _HeaderPainterNaranja(),
      ),
    );
  }
  
}

class _HeaderPainterNaranja extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint();

    paint.color = Color(0xffED6948);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 5;

    final path = new Path();
    path.moveTo( size.width * 0.7 , 0);
    path.quadraticBezierTo( size.width * 0.7 , size.height * 1.0 , size.width  , size.height * 1.0 );
    path.lineTo( size.width , 0);

    canvas.drawPath(path, paint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;   
}

class HeaderHomeMorado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      width: double.infinity,
      child: CustomPaint(
        painter: _HeaderPainterMorado(),
      ),
    );
  }
}

class _HeaderPainterMorado extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint();

    // paint.color = Color(0xff6C4DDC);
    paint.color = Color.fromRGBO(231, 213, 172, 1);
    // paint.color = Color.fromRGBO(121, 189, 160, 1);
    // paint.color = Color.fromRGBO(69, 104, 127, 1);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 5;

    final path = new Path();
    path.moveTo( size.width * 0.3 , 0);
    path.quadraticBezierTo( size.width * 0.3 , size.height * 0.8 , size.width * 0.6 , size.height * 0.7 );
    path.quadraticBezierTo( size.width * 0.9 , size.height * 0.6 , size.width , size.height * 1 );
    path.lineTo( size.width , 0);

    canvas.drawPath(path, paint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;   
}