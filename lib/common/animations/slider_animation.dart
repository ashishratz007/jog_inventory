import 'package:flutter/material.dart';

class SlidingImageSwitcher extends StatefulWidget {
  final Widget image;
  final AnimationController controller;

  const SlidingImageSwitcher({
    Key? key,
    required this.image,
    required this.controller,
  }) : super(key: key);

  @override
  _SlidingImageSwitcherState createState() => _SlidingImageSwitcherState();
}

class _SlidingImageSwitcherState extends State<SlidingImageSwitcher> {
  Widget? _currentImage;

  @override
  void initState() {
    super.initState();
    _currentImage = widget.image;
    widget.controller.addListener(_onImageChange);
  }

  @override
  void didUpdateWidget(covariant SlidingImageSwitcher oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.image != oldWidget.image) {
      _updateImage();
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onImageChange);
    super.dispose();
  }

  void _onImageChange() {
    if (widget.controller.isCompleted) {
      setState(() {
        _currentImage = widget.image;
        widget.controller.reset();
      });
    }
  }

  void _updateImage() {
    widget.controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: Container(
        key: ValueKey<Widget>(_currentImage!),
        child: _currentImage,
      ),
    );
  }
}
