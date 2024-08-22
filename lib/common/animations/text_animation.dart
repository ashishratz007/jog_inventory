import '../exports/main_export.dart';

class AnimatedCharacters extends StatefulWidget {
  final String text;

  const AnimatedCharacters({required this.text});

  @override
  _AnimatedCharactersState createState() => _AnimatedCharactersState();
}

class _AnimatedCharactersState extends State<AnimatedCharacters>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;
  final int milliseconds = 500;

  @override
  void initState() {
    super.initState();

    int length = widget.text.length;
    double durationPerCharacter =
        double.parse("0.${milliseconds}".trim()) / length;

    _controller = AnimationController(
      duration: Duration(milliseconds: milliseconds),
      vsync: this,
    );

    _animations = List.generate(length, (index) {
      final start = index * durationPerCharacter;
      final end = start + durationPerCharacter;

      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: Curves.easeIn),
        ),
      );
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildCharacter(String character, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Opacity(
          opacity: animation.value,
          child: child,
        );
      },
      child: Text(
        character + "  ",
        style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.text.length, (index) {
        final character = widget.text[index];
        return _buildCharacter(character, _animations[index]);
      }),
    );
  }
}
