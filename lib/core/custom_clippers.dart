import 'package:flutter/material.dart';

class WavyHeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final path = Path();

    path.lineTo(0, size.height * 0.75);

    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.7,
      size.width * 0.5,
      size.height * 0.75,
    );

    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.8,
      size.width,
      size.height * 0.75,
    );

    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
