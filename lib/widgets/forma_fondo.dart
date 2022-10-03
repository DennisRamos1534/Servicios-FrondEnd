import 'package:flutter/material.dart';

class FormasFondo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          child: CustomPaint(
            painter: _HeaderHomePainert(),
          ),
        ),

        Container(
          height: double.infinity,
          width: double.infinity,
          child: CustomPaint(
            painter: _BottomHomePainert(),
          ),
        ),
      ],
    );
  }
}

class _HeaderHomePainert extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint();

    paint.color = Color.fromRGBO(55, 56, 79, 1);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 5;

    final path = new Path();
    path.lineTo( 0, size.height * 0.3 );
    path.quadraticBezierTo( size.width * 0.01 , size.height *  0.1, size.width * 0.55 , size.height * 0.07 );
    path.quadraticBezierTo( size.width * 0.82, size.height * 0.05 , size.width * 0.85 , 0 );

    canvas.drawPath(path, paint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}


class _BottomHomePainert extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint();

    paint.color = Color.fromRGBO(55, 56, 79, 1);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 1;

    final path = new Path();
    path.moveTo( 0, size.height );
    path.lineTo(0, size.height * 0.88);
    path.quadraticBezierTo( size.width * 0.2 , size.height *  0.92, size.width * 0.3 , size.height * 0.9 );
    path.quadraticBezierTo( size.width * 0.48 , size.height *  0.87, size.width * 0.6 , size.height * 0.9 );
    path.quadraticBezierTo( size.width * 0.85 , size.height *  0.94, size.width * 0.85 , size.height * 0.9 );
    path.quadraticBezierTo( size.width * 0.88 , size.height *  0.87, size.width, size.height * 0.91 );
    path.lineTo(size.width, size.height);

    canvas.drawPath(path, paint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}