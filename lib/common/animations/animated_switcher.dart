import 'package:flutter/material.dart';

class AnimatedSwitcherWidget extends StatefulWidget {
  final Widget firstWidget;
  final Widget secondWidget;
  final Duration duration;
  final Curve curve;
  final ValueChanged<bool>? onChange;

  const AnimatedSwitcherWidget({
    Key? key,
    required this.firstWidget,
    required this.secondWidget,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.onChange,
  }) : super(key: key);

  @override
  _AnimatedSwitcherWidgetState createState() => _AnimatedSwitcherWidgetState();
}

class _AnimatedSwitcherWidgetState extends State<AnimatedSwitcherWidget> {
  bool _isFirst = true;

  void toggle() {
    setState(() {
      _isFirst = !_isFirst;
      widget.onChange?.call(_isFirst);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedSwitcher(
          duration: widget.duration,
          switchInCurve: widget.curve,
          switchOutCurve: widget.curve,
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(scale: animation, child: child),
            );
          },
          child: _isFirst ? widget.firstWidget : widget.secondWidget,
        ),
      ],
    );
  }

  void triggerToggle() => toggle();
}
