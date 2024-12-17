import '../exports/common.dart';

class CustomExpandedTileController extends ChangeNotifier {
  bool _isExpanded;
  Function()? onDone;

  CustomExpandedTileController({bool initialState = false})
      : _isExpanded = initialState;

  bool get isExpanded => _isExpanded;

  void toggle() {
    _isExpanded = !_isExpanded;
    notifyListeners();
    onDone?.call();
  }

  void expand() {
    _isExpanded = true;
    notifyListeners();
    onDone?.call();
  }

  void collapse() {
    _isExpanded = false;
    notifyListeners();
    onDone?.call();
  }
}

class CustomExpandedTile extends StatefulWidget {
  final Widget head;
  final List<Widget> children;
  final Widget? bottom;
  final Color bgColor;
  final Color? childrenBg;
  final Function(bool)? onChange;
  final CustomExpandedTileController? controller;
  final Duration animationDuration;

  const CustomExpandedTile({
    Key? key,
    required this.head,
    required this.children,
    this.onChange,
    this.bottom,
    this.controller,
    this.bgColor = Colors.white,
    this.childrenBg,
    this.animationDuration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  State<CustomExpandedTile> createState() => _CustomExpandedTileState();
}

class _CustomExpandedTileState extends State<CustomExpandedTile>
    with SingleTickerProviderStateMixin {
  late CustomExpandedTileController _controller;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? CustomExpandedTileController();
    _controller.onDone = onDone;
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _expandAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _controller.addListener(() {
      if(mounted) {
        if (_controller.isExpanded) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
      }
    });

    if (_controller.isExpanded) {
      _animationController.value = 1.0;
    }
  }

  void onDone() {
    widget.onChange?.call(_controller.isExpanded);
    Future.delayed(widget.animationDuration);
    if (!_controller.isExpanded)
      selectedIndex.value = 0;
    else
      selectedIndex.value = 1;
    // _animationController.value = 1.0;
    // _animationController.forward();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    _animationController.dispose();
    super.dispose();
  }

  RxInt selectedIndex = 0.obs;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colours.border)),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: _controller.toggle,
            child: widget.head,
          ),
          gap(space: 10),
          divider(),
          gap(space: 10),
          Obx(
            () => Container(
              decoration: BoxDecoration(
                  color: widget.childrenBg ?? Colours.bgColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colours.border)),
              child: Column(
                children: [
                  Stack(
                    children: [
                      IndexedStack(
                        index: selectedIndex.value,
                        children: [
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: Visibility(
                              visible: !_controller.isExpanded,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width: double.infinity,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(child: widget.children.first),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizeTransition(
                            sizeFactor: _expandAnimation,
                            axisAlignment: 0,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ...widget.children,
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      /// arrow icon
                      Align(
                        alignment: Alignment.topRight,
                        child: Obx(
                          () => Container(
                            margin: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10, top: 10),
                            child: RotatedBox(
                                quarterTurns: selectedIndex.value == 1 ? 1 : 3,
                                child: Container(
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      color: Colours.white,
                                      border: Border.all(color: Colours.border),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 18,
                                      color: Colours.black,
                                    ))),
                          ),
                        ),
                      )
                    ],
                  ),
                  if (widget.bottom != null)
                    SizeTransition(
                      sizeFactor: _expandAnimation,
                      axisAlignment: 0,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [gap(), widget.bottom!],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
