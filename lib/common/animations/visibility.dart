import 'package:flutter/material.dart';

class AnimatedVisibility extends StatelessWidget {
  final bool isVisible;
  final Widget child;
  final Duration duration;

  const AnimatedVisibility({
    Key? key,
    required this.isVisible,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0,
      duration: duration,
      curve: Curves.easeIn,
      child: isVisible ? child : SizedBox(),
    );
  }
}

