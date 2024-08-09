import 'package:flutter/material.dart';

class WavingIcon extends StatefulWidget {
  final Widget icon;
  final Duration duration;

  const WavingIcon({
    Key? key,
    required this.icon,
    this.duration = const Duration(seconds: 1),
  }) : super(key: key);

  @override
  _WavingIconState createState() => _WavingIconState();
}

class _WavingIconState extends State<WavingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween(begin: -0.1, end: 0.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticIn,
      ),
    );
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
      child: widget.icon,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animation.value ,
          child: child,
        );
      },
    );
  }
}
