import 'dart:math';

import 'package:flutter/material.dart';

class DolDurmaClipper extends CustomClipper<Path> {
  const DolDurmaClipper({this.length = 6, this.radius = 20, this.angle = 1.5});

  final int length;
  final double radius;
  final double angle;

  @override
  Path getClip(Size size) {
    /// New code #2
    final path = Path()..moveTo(0, size.height / (2 * length));

    for (int i = 0; i < length; i++) {
      double centerHeight = ((2 * i + 1) * size.height) / (2 * length);
      path.arcTo(Rect.fromCircle(center: Offset(radius / 2, centerHeight), radius: radius), angle * pi, angle * pi, false);
    }

    path
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0);

    return path;

    /// New code #1
    /*  final path = Path()..moveTo(0, size.height / (2 * length));

    for (int i = 0; i < length; i++) {
      double centerHeight = ((2 * i + 1) * size.height) / (2 * length);
      path.arcTo(Rect.fromCircle(center: Offset(0, centerHeight), radius: radius), angle * pi, angle * pi, false);
    }

    path
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0);

    return path; */

    /// Old code
    ///
    /* final path = Path()
      ..moveTo(0, size.height / 8)
      ..arcTo(Rect.fromCircle(center: Offset(0, 0.8 * size.height / 8), radius: 20), 1.5 * pi, 1.5 * pi, false)
      ..arcTo(Rect.fromCircle(center: Offset(0, 2 * size.height / 8), radius: 20), 1.5 * pi, 1.5 * pi, false)
      ..arcTo(Rect.fromCircle(center: Offset(0, 3.2 * size.height / 8), radius: 20), 1.5 * pi, 1.5 * pi, false)
      ..arcTo(Rect.fromCircle(center: Offset(0, 4.4 * size.height / 8), radius: 20), 1.5 * pi, 1.5 * pi, false)
      ..arcTo(Rect.fromCircle(center: Offset(0, 5.6 * size.height / 8), radius: 20), 1.5 * pi, 1.5 * pi, false)
      ..arcTo(Rect.fromCircle(center: Offset(0, 6.8 * size.height / 8), radius: 20), 1.5 * pi, 1.5 * pi, false)
      ..arcTo(Rect.fromCircle(center: Offset(0, 8 * size.height / 8), radius: 20), 1.5 * pi, 1.5 * pi, false)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0);

    return path; */

    /*  final path = Path()
      ..moveTo(0, size.height / 6)
      ..lineTo(0, size.height / 3)
      ..arcToPoint(Offset(0, size.height / 2), radius: const Radius.circular(20), clockwise: false)
      ..lineTo(0, 2 * size.height / 3)
      ..arcToPoint(Offset(0, 5 * size.height / 6), radius: const Radius.circular(20), clockwise: false)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0);

    return path; */

    /*  final path = Path()
      ..moveTo(0, topLeftRadius)
      ..lineTo(0, size.height / 6 - topLeftRadius)
      ..arcToPoint(Offset(0, size.height / 6), radius: Radius.circular(topLeftRadius), clockwise: false)
      ..lineTo(0, 2 * size.height / 6 - secondRadius)
      ..arcToPoint(Offset(0, 2 * size.height / 6), radius: Radius.circular(secondRadius), clockwise: false)
      ..lineTo(0, 3 * size.height / 6 - thirdRadius)
      ..arcToPoint(Offset(0, 3 * size.height / 6), radius: Radius.circular(thirdRadius), clockwise: false)
      ..lineTo(0, 4 * size.height / 6 - fourthRadius)
      ..arcToPoint(Offset(0, 4 * size.height / 6), radius: Radius.circular(fourthRadius), clockwise: false)
      ..lineTo(0, 5 * size.height / 6 - fifthRadius)
      ..arcToPoint(Offset(0, 5 * size.height / 6), radius: Radius.circular(fifthRadius), clockwise: false)
      ..lineTo(0, size.height - bottomLeftRadius)
      ..arcToPoint(Offset(0, size.height), radius: Radius.circular(bottomLeftRadius), clockwise: false)
      ..lineTo(size.width - right, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0);

    return path; */

    /* final path = Path()
      ..moveTo(0, topLeftRadius)
      ..arcTo(Rect.fromCircle(center: Offset(0, topLeftRadius), radius: topLeftRadius), pi, pi / 2, false)
      ..lineTo(0, size.height / 3 - midTopLeftRadius)
      ..arcTo(Rect.fromCircle(center: Offset(0, size.height / 3), radius: midTopLeftRadius), pi, pi / 2, false)
      ..lineTo(0, 2 * size.height / 3 - midBotLeftRadius)
      ..arcTo(Rect.fromCircle(center: Offset(0, 2 * size.height / 3), radius: midBotLeftRadius), pi, pi / 2, false)
      ..lineTo(0, size.height - bottomLeftRadius)
      ..arcTo(Rect.fromCircle(center: Offset(0, size.height), radius: bottomLeftRadius), pi, pi / 2, false)
      ..lineTo(size.width - right, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0);

    return path; */

    /* final path = Path()
      ..moveTo(0, topLeftRadius)
      ..quadraticBezierTo(0, 0, topLeftRadius, 0)
      ..lineTo(size.width - right, 0)
      ..lineTo(size.width - right, size.height / 3 - midTopLeftRadius)
      ..quadraticBezierTo(size.width - right, size.height / 3, size.width - right - midTopLeftRadius, size.height / 3)
      ..lineTo(0, 2 * size.height / 3 - midBotLeftRadius)
      ..quadraticBezierTo(0, 2 * size.height / 3, midBotLeftRadius, 2 * size.height / 3)
      ..lineTo(0, size.height - bottomLeftRadius)
      ..quadraticBezierTo(0, size.height, bottomLeftRadius, size.height)
      ..lineTo(size.width - right, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0);

    return path; */

    /* final path = Path()
      ..moveTo(0, topLeftRadius) // Start from top left corner
      ..arcToPoint(
        const Offset(0, 0),
        clockwise: false,
        radius: Radius.circular(topLeftRadius),
      )
      ..lineTo(0, size.height / 3 - midTopLeftRadius)
      ..arcToPoint(
        Offset(0, size.height / 3),
        clockwise: false,
        radius: Radius.circular(midTopLeftRadius),
      )
      ..lineTo(0, 2 * size.height / 3 - midBotLeftRadius)
      ..arcToPoint(
        Offset(0, 2 * size.height / 3),
        clockwise: false,
        radius: Radius.circular(midBotLeftRadius),
      )
      ..lineTo(0, size.height - bottomLeftRadius)
      ..arcToPoint(
        Offset(0, size.height),
        clockwise: false,
        radius: Radius.circular(bottomLeftRadius),
      )
      ..lineTo(size.width - right, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0.0)
      ..lineTo(0, 0.0);

    path.close();
    return path; */

    /* final path = Path()
      ..moveTo(0, topLeftRadius) // Start from top left corner
      ..arcToPoint(
        Offset(0, 0),
        clockwise: false,
        radius: Radius.circular(topLeftRadius),
      )
      ..lineTo(size.width - right - topRightRadius, 0.0)
      ..arcToPoint(
        Offset(size.width - right, 0),
        clockwise: false,
        radius: Radius.circular(topRightRadius),
      )
      ..lineTo(size.width, 0.0)
      ..lineTo(size.width, size.height - bottomRightRadius)
      ..arcToPoint(
        Offset(size.width - right, size.height),
        clockwise: false,
        radius: Radius.circular(bottomRightRadius),
      )
      ..lineTo(0, size.height)
      ..arcToPoint(
        Offset(0, size.height - bottomLeftRadius),
        clockwise: false,
        radius: Radius.circular(bottomLeftRadius),
      );

    path.close();
    return path; */

    /* final path = Path()
      ..moveTo(0, topLeftRadius) // Start from top left corner
      ..arcToPoint(
        const Offset(0, 0),
        clockwise: false,
        radius: Radius.circular(topLeftRadius),
      )
      ..lineTo(size.width - right, 0.0)
      ..lineTo(size.width, 0.0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..arcToPoint(
        Offset(0, size.height - bottomLeftRadius),
        clockwise: false,
        radius: Radius.circular(bottomLeftRadius),
      );

    path.close();
    return path; */

    /* final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width - right - holeRadius, 0.0)
      ..arcToPoint(
        Offset(size.width - right, 0),
        clockwise: false,
        radius: const Radius.circular(1),
      )
      ..lineTo(size.width, 0.0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width - right, size.height)
      ..arcToPoint(
        Offset(size.width - right - holeRadius, size.height),
        clockwise: false,
        radius: const Radius.circular(1),
      );

    path.lineTo(0.0, size.height);

    path.close();
    return path; */
  }

  @override
  bool shouldReclip(DolDurmaClipper oldClipper) => true;
}
