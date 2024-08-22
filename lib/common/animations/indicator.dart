
import '../exports/common.dart';

class CustomIndicatorWidget extends AnimatedWidget {
  final PageController controller;
  final int itemCount;
  final int currentIndex;

  CustomIndicatorWidget({
    required this.controller,
    required this.itemCount,
    required this.currentIndex,
  }) : super(listenable: controller);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          height: 3.0,
          width: 50.0,
          decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black : Colors.grey,
            borderRadius: BorderRadius.circular(5.0),
          ),
        );
      }),
    );
  }
}