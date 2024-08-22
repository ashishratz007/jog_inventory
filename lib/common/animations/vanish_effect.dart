import 'package:flutter/material.dart';

class VanishedEffect extends StatefulWidget {
  final Widget child;
  final VanishedEffectController controller;

  const VanishedEffect({
    Key? key,
    required this.child,
    required this.controller,
  }) : super(key: key);

  @override
  _VanishedEffectState createState() => _VanishedEffectState();
}

class _VanishedEffectState extends State<VanishedEffect> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    widget.controller._setAnimationController(_animationController);
  }

  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    return super == other;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Stack(
            children: [
              ..._buildShatteredPieces(),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _buildShatteredPieces() {
    int numPieces = 5;
    List<Widget> pieces = [];
    for (int i = 0; i < numPieces; i++) {
      double animationValue = _animation.value;
      double opacity = 1.0 - animationValue * (i + 1) / numPieces;
      pieces.add(
        Opacity(
          opacity: opacity,
          child: FractionalTranslation(
            translation: Offset(animationValue * (i - numPieces / 2), animationValue * (i % 2 == 0 ? 1 : -1)),
            child: widget.child,
          ),
        ),
      );
    }
    return pieces;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class VanishedEffectController {
  late AnimationController _animationController;

  void _setAnimationController(AnimationController controller) {
    _animationController = controller;
  }

  void forward() {
    _animationController.forward();
  }

  void reverse() {
    _animationController.reverse();
  }
}
