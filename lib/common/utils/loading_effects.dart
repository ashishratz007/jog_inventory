import 'package:shimmer/shimmer.dart';
import '../exports/main_export.dart';

Widget shimmerEffects(
    {required Widget child,
    Color? loadingColor,
    Color? bgColor,
    bool isLoading = false}) {
  return isLoading
      ? Shimmer.fromColors(
          baseColor: bgColor ?? Colours.primaryLite,
          highlightColor: loadingColor ?? Colours.blueAccent.withOpacity(0.3),
          direction: ShimmerDirection.ltr,
          child: child)
      : child;
}

Widget listLoadingEffect({int count =5}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ...List.generate(
          count,
          (index) => Container(
                margin: EdgeInsets.only(top: 20),
                child: shimmerEffects(
                  isLoading: true,
                  child: Container(
                    height: 45,
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7)),
                  ),
                ),
              ))
    ],
  );
}

class LinkedInReactionWidget extends StatefulWidget {
  const LinkedInReactionWidget({Key? key}) : super(key: key);

  @override
  State<LinkedInReactionWidget> createState() => _LinkedInReactionWidgetState();
}

class _LinkedInReactionWidgetState extends State<LinkedInReactionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isOpened = false;
  void _onTap() {
    if (isOpened) {
      isOpened = false;
      _controller.animateBack(0);
    } else
      setState(() {
        _controller.forward();
        isOpened = true;
      });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Row(
        children: [
          Icon(Icons.save),
          ScaleTransition(
            scale: _scaleAnimation,
            child: Visibility(
              visible: isOpened,
              child: GestureDetector(
                onTap: _onTap,
                child: Row(
                  children: [
                    ...List.generate(
                        5,
                        (index) => Container(
                              margin: EdgeInsets.only(left: 10),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.thumb_up,
                                color: Colors.grey,
                                size: 20,
                              ),
                            )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
