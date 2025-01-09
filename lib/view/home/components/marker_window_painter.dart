import 'dart:ui' as ui;

import 'package:flutter/material.dart';

//Copy this CustomPainter code to the Bottom of the File
class MarkerWindowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(12, 0);
    path_0.cubicTo(5.37305, 0, 0, 5.37256, 0, 12);
    path_0.lineTo(0, 322);
    path_0.cubicTo(0, 328.627, 5.37305, 334, 12, 334);
    path_0.lineTo(120.686, 334);
    path_0.lineTo(127.036, 345);
    path_0.cubicTo(128.575, 347.667, 132.425, 347.667, 133.964, 345);
    path_0.lineTo(140.314, 334);
    path_0.lineTo(248, 334);
    path_0.cubicTo(254.627, 334, 260, 328.627, 260, 322);
    path_0.lineTo(260, 12);
    path_0.cubicTo(260, 5.37256, 254.627, 0, 248, 0);
    path_0.lineTo(12, 0);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
