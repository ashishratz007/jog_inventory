import 'dart:ui';
import 'package:flutter/material.dart';

class DottedBorderContainer extends StatelessWidget {
  final double gap;
  final Widget child;
  final Color borderColor;
  final double borderWidth;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Decoration? decoration;
  final BoxDecoration? boxDecoration;
  final BorderRadius? borderRadius;

  const DottedBorderContainer({
    Key? key,
    this.gap = 4.0,
    required this.child,
    this.borderColor = Colors.black,
    this.borderWidth = 2.0,
    this.padding,
    this.margin,
    this.decoration,
    this.boxDecoration,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: margin,
      child: CustomPaint(
        painter: _DottedBorderPainter(
          gap: gap,
          color: borderColor,
          borderWidth: borderWidth,
          borderRadius: borderRadius ?? BorderRadius.circular(0),
        ),
        child: Container(
          padding: padding,
          decoration: decoration ?? boxDecoration,
          child: child,
        ),
      ),
    );
  }
}

class _DottedBorderPainter extends CustomPainter {
  final double gap;
  final Color color;
  final double borderWidth;
  final BorderRadius borderRadius;

  _DottedBorderPainter({
    required this.gap,
    required this.color,
    required this.borderWidth,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke;

    final path = Path();
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = borderRadius.toRRect(rect);

    // Draw the dotted border
    Path dashPath = _createDashedPath(Path()..addRRect(rrect), gap);
    canvas.drawPath(dashPath, paint);
  }

  Path _createDashedPath(Path originalPath, double gap) {
    Path path = Path();
    double distance = 0.0;

    for (PathMetric measurePath in originalPath.computeMetrics()) {
      while (distance < measurePath.length) {
        path.addPath(
          measurePath.extractPath(distance, distance + gap),
          Offset.zero,
        );
        distance += gap * 2;
      }
      distance = 0.0;
    }

    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}


class DottedLineDivider extends StatelessWidget {
  final double dotSpace;
  final Color color;
  final double width;

  const DottedLineDivider({
    Key? key,
    this.dotSpace = 4.0,
    this.color = Colors.black,
    this.width = 2.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = width;
        final dashHeight = width;
        final dashCount = (boxWidth / (2 * dotSpace)).floor();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (index) {
            return SizedBox(
              width: dotSpace,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
