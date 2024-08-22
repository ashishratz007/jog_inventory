
import '../exports/main_export.dart';

class EaseOutAnimation extends StatefulWidget {
  final Widget child;
  final Duration? duration;
  const EaseOutAnimation({required this.child, this.duration, super.key});

  @override
  State<EaseOutAnimation> createState() => _EaseOutAnimationState();
}

class _EaseOutAnimationState extends State<EaseOutAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration??Duration(seconds: 1),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
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
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }
}
