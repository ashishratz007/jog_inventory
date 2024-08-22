import 'dart:math';
import '../exports/main_export.dart';


///  transferring
class TransferringDots extends AnimatedWidget {
  final ListenableItem controller;
  final int itemCount;
  final int currentPage;
  final double dotHeight;
  final double dotWidth;
  final Color dotColor;
  final Color activeDotColor;

  TransferringDots({
    required this.controller,
    required this.itemCount,
    required this.currentPage,
    required this.dotHeight,
    required this.dotWidth,
    required this.dotColor,
    required this.activeDotColor,
  }) : super(listenable: controller);

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(0.0, 1.0 - ((controller.newIndex ) - index).abs()),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return Container(
      width: dotWidth * zoom,
      height: dotHeight,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        color: index == currentPage ? activeDotColor : dotColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount, _buildDot),
    );
  }
}

class ListenableItem extends Listenable{
  int newIndex;
  ListenableItem(this.newIndex);

  @override
  void addListener(VoidCallback listener) {
    // TODO: implement addListener
  }

  @override
  void removeListener(VoidCallback listener) {
    // TODO: implement removeListener
  }

}