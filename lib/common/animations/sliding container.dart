import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jog_inventory/common/constant/colors.dart';
import 'package:jog_inventory/common/utils/utils.dart';
import 'package:jog_inventory/common/widgets/imageview.dart';

import '../constant/images.dart';

class FixedPositionAnimatedWidthContainer extends StatefulWidget {
  final Widget? child;
  final Duration duration; // Custom animation duration
  final double minWidth; // Minimum width for animation
  final double maxWidth; // Maximum width for animation
  final bool reverseAnimation; // From max to min if true
  final double height; // Custom height
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double angle; // Angle in degrees
  final Alignment alignment; // Alignment to fix position

  const FixedPositionAnimatedWidthContainer({
    Key? key,
    this.child,
    this.duration = const Duration(milliseconds: 500), // Default duration
    this.minWidth = 100, // Default min width
    this.maxWidth = 200, // Default max width
    this.reverseAnimation = false,
    this.height = 100, // Default height
    this.decoration,
    this.padding,
    this.margin,
    this.angle = 0.0, // Default angle (no rotation)
    this.alignment = Alignment.centerLeft, // Alignment to fix the position
  }) : super(key: key);

  @override
  _FixedPositionAnimatedWidthContainerState createState() =>
      _FixedPositionAnimatedWidthContainerState();
}

class _FixedPositionAnimatedWidthContainerState
    extends State<FixedPositionAnimatedWidthContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);

    // Define animation for width only
    _widthAnimation = Tween<double>(
            begin: widget.minWidth, end: widget.maxWidth)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Start the animation
    if (widget.reverseAnimation) {
      _controller.reverse(from: 1.0);
    } else {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _widthAnimation,
      builder: (context, child) {
        return Align(
          alignment: widget.alignment, // Keep the container in a fixed position
          child: Transform.rotate(
            angle: widget.angle *
                pi /
                180, // Convert degree to radians for rotation
            child: Container(
              width: _widthAnimation.value, // Animated width
              height: widget.height, // Custom height passed by the user
              decoration: widget.decoration,
              padding: widget.padding,
              margin: widget.margin,
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}

class CustomRowAnimation extends StatefulWidget {
  final double start; // Start position within the Row
  final double end; // End position within the Row
  final Duration duration; // Duration of the animation
  final Widget child; // The widget to animate

  const CustomRowAnimation({
    Key? key,
    required this.start,
    required this.end,
    required this.duration,
    required this.child,
  }) : super(key: key);

  @override
  _CustomRowAnimationState createState() => _CustomRowAnimationState();
}

class _CustomRowAnimationState extends State<CustomRowAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(begin: widget.start, end: widget.end).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          // Translate the child widget in a horizontal (row) direction
          margin: EdgeInsets.only(left: _animation.value),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class FadeAnimation extends StatefulWidget {
  final Widget child;

  const FadeAnimation({super.key, required this.child});
  @override
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Animation that changes opacity from 0 (invisible) to 1 (fully visible)
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    // Start the fade-in animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: _animation, // Link the animation to the opacity
        child: widget.child);
  }
}

class OpacityFadeAnimation extends StatefulWidget {
  @override
  _OpacityFadeAnimationState createState() => _OpacityFadeAnimationState();
}

class _OpacityFadeAnimationState extends State<OpacityFadeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // Start the fade-in animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Opacity Fade Example'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Opacity(
              opacity: _animation.value, // Animate opacity from 0 to 1
              child: Container(
                width: 200,
                height: 200,
                color: Colors.red,
                child: Center(
                  child: Text(
                    'Fade Box',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

