import 'package:flutter/widgets.dart';

class CurveAppBar extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    
    path.moveTo(0, 0);
    
    path.lineTo(0, size.height - 30);

    path.quadraticBezierTo(
      size.width / 4,
      size.height - 10,
      size.width / 2,
      size.height - 40,
    );

    path.quadraticBezierTo(
      size.width * 3 / 4,
      size.height - 70,
      size.width,
      size.height - 30,
    );

    path.lineTo(size.width, 0);

    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
