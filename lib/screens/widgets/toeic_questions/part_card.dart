import 'package:flutter/material.dart';
import 'package:toeic_learning_app/models/toeic_part_model.dart';
import 'dart:ui' as ui;

import '../../../config/theme.dart';

class PartCard extends StatelessWidget {
  final ToeicPart part;
  const PartCard({
    Key? key,
    required this.part,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double _borderRadius = 24;
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          // height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_borderRadius),
            gradient: const LinearGradient(
              colors: [
                Color(0xff42E695),
                Color(0xff3BB2B8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          top: 0,
          child: CustomPaint(
            size: const Size(100, 150),
            painter: CustomCardShapePainter(
              _borderRadius,
              const Color(0xff42E695),
              const Color(0xff3BB2B8),
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 55,
                      height: 55,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: whiteColor,
                      ),
                      child: Image.asset(
                        part.img!,
                      ),
                    ),
                    SizedBox(
                      width: size.width / 50,
                    ),
                    Text(
                      'Part ${part.part}',
                      style: TextStyle(
                          fontSize: 17,
                          color: whiteColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  part.title!,
                  style: TextStyle(
                      fontSize: 16,
                      color: whiteColor,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        const Offset(0, 0),
        Offset(
          size.width,
          size.height,
        ),
        [
          HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
          endColor
        ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
