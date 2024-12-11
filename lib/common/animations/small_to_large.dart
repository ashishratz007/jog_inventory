import '../exports/main_export.dart';

class SmallToLargeAnimation extends StatefulWidget {
  final Widget child;
  final double? minSize;
  final double? maxWidth;
  final Duration? duration;
  const SmallToLargeAnimation({required this.child, this.minSize, this.maxWidth, this.duration});
  @override
  _SmallToLargeAnimationState createState() => _SmallToLargeAnimationState();
}

class _SmallToLargeAnimationState extends State<SmallToLargeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration??Duration(seconds: 1),
    );

    _sizeAnimation = Tween<double>(begin:  widget.minSize??0.0, end: widget.maxWidth??50.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Start the animation
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
      animation: _sizeAnimation,
      builder: (context, child) {
        return Container(
          width: _sizeAnimation.value,
          height: _sizeAnimation.value,
          decoration: BoxDecoration(
            // color: Colors.blue,
            // borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: widget.child,

          ),
        );
      },
    );
  }
}

