import 'package:flutter/material.dart';

class FondoUsuario extends StatelessWidget {

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
            Color.fromRGBO(192, 191, 192, 1),
            Colors.white,
          ]
        ),
      ),  
      child: CustomPaint(
        painter: _FondoUsuarioPainert(),
      ),   
    );
  }
}

class _FondoUsuarioPainert extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {

    final Rect rect = Rect.fromCircle(center: Offset(0, 55.0), radius: 360);

    final Gradient gradiente = LinearGradient(
      colors: [
        // Color(0xffFF9460),
        Color(0xffFFB894),

        Color(0xffFF9460),
        Color(0xffFF6D2A),
      ]
    );

    final paint = new Paint()..shader = gradiente.createShader(rect);

    paint.color = Color.fromRGBO(55, 56, 79, 1);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2;

    final path = new Path();
    path.lineTo( 0, size.height * 0.25);
    path.quadraticBezierTo( size.width * 0.15 , size.height *  0.27, size.width * 0.2, size.height * 0.32 );
    path.quadraticBezierTo( size.width * 0.3 , size.height *  0.2, size.width * 0.65, size.height * 0.2 );
    path.quadraticBezierTo( size.width * 0.95 , size.height *  0.2, size.width, size.height * 0.13 );
    path.lineTo( size.width, 0);

    canvas.drawPath(path, paint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}