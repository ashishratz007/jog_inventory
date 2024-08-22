import '../exports/main_export.dart';

class OverlayAnimationWidget extends StatefulWidget {
  final Widget child;
  final Widget overlayWidget;
  final FocusNode focusNode;

  const OverlayAnimationWidget(
      {required this.child, required this.overlayWidget, required this.focusNode, super.key});

  @override
  State<OverlayAnimationWidget> createState() => _OverlayAnimationWidgetState();
}

class _OverlayAnimationWidgetState extends State<OverlayAnimationWidget> {
  OverlayEntry? entry;
  LayerLink layerLink = LayerLink();
  bool get hasOverLay => entry != null;

  @override
  void initState() {
    widget.focusNode.addListener((){
      if(!widget.focusNode.hasFocus){
        {

          if(mounted)hideOverLay();
        }
      }
    });
    super.initState();
  }

  toggleOverLay() {
    if (hasOverLay) {
      hideOverLay();
    } else {
      widget.focusNode.requestFocus();
      showOverLay();
    }
  }

  showOverLay() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    entry = OverlayEntry(
        builder: (context) => Positioned(
            // left: 0,
            // top: offset.dy + size.height + 5,
            width: Get.width,
            child: CompositedTransformFollower(
                key: widget.key,
                showWhenUnlinked: false,
                // targetAnchor: Alignment.bottomLeft,
                // followerAnchor: Alignment.bottomLeft,
                link: layerLink,
                offset: Offset(0, size.height + 5),
                child: Material(
                    type: MaterialType.transparency,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                            onTap: (){
                              toggleOverLay();
                            },
                            child: widget.overlayWidget),
                      ],
                    )))));
    overlay.insert(entry!);
  }

  hideOverLay() {
    entry?.remove();
    entry = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
        link: layerLink,
        key: widget.key,
        child: InkWell(
            onTap: () {
              toggleOverLay();
            },
            child: widget.child));
  }
}
