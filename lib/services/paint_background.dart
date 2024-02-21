
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class AuthBackground extends CustomPainter {
  AuthBackground({
    required this.image,
  });

  ui.Image image;

  @override
  void paint(Canvas canvas, Size size) {
    if(image!=null)
      canvas.drawImage(image, new Offset(0.0, 0.0), new Paint());
    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height), Paint()..color = Color.fromRGBO(253, 184, 70, 0.7));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}


class OrderStatus extends CustomPainter {
  double y2;
  OrderStatus({required this.y2});

  @override
  void paint(Canvas canvas, Size size) {
    // double height = size.height;
    // double width = size.width;

    canvas.drawLine(Offset(36,32),Offset(36,y2),
        Paint()..color = Colors.green
           ..strokeWidth=9.4
           ..strokeCap =StrokeCap.round
    );





  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
