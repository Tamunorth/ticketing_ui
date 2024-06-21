import 'package:flutter/material.dart';

class TicketPainter extends CustomPainter {
  final Color color;

  TicketPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [Colors.red, Colors.black],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final path = Path();
    double notchSize = 20;
    double cornerSize = 30;
    double heightRatio = size.height / 1.5;
    double widthMinusConer = size.width - cornerSize;
    double heightMinusConer = size.height - cornerSize;

    path.moveTo(0, 0);

    path.lineTo(widthMinusConer, 0);

    path.arcToPoint(Offset(size.width, cornerSize),
        radius: Radius.circular(cornerSize));

    // Right notch
    path.lineTo(size.width, heightRatio - notchSize);

    path.arcToPoint(
      Offset(size.width, heightRatio + notchSize),
      radius: Radius.circular(notchSize),
      clockwise: false,
    );
    path.lineTo(size.width, heightMinusConer);

    path.arcToPoint(
      Offset(widthMinusConer, size.height),
      radius: Radius.circular(cornerSize),
    );

    // Bottom edge
    path.lineTo(notchSize, size.height);

    path.arcToPoint(
      Offset(0, heightMinusConer),
      radius: Radius.circular(cornerSize),
    );

    // Left notch
    path.lineTo(0, heightRatio + notchSize);
    path.arcToPoint(
      Offset(0, heightRatio - notchSize),
      radius: Radius.circular(notchSize),
      clockwise: false,
    );
    path.lineTo(0, notchSize);

    path.arcToPoint(
      Offset(cornerSize, 0),
      radius: Radius.circular(cornerSize),
    );
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
