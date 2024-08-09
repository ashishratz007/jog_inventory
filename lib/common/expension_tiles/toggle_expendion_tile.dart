
import 'package:jog_inventory/common/constant/padding.dart';
import 'package:jog_inventory/common/exports/common.dart';

class ToggleExpansionTile extends StatefulWidget {
  ///[onChange] indicates that the tile is opened or closed
  final void Function(bool) onChange;

  ///[initialValue] is tile expanded or closed
  final bool initialValue;

  final Color? bgColor;

  ///[] is tile expanded or closed
  final Color? childrenBgColor;

  ///[title] main elements of the widget
  final Widget? title;

  ///[title] main elements of the widget
  final String? titleText;

  ///[titlePadding] children body padding
  final EdgeInsets titlePadding;

  ///[children] main elements of the widget
  final List<Widget> children;

  ///[childrenPadding] children body padding
  final EdgeInsets childrenPadding;

  ///[childrenPadding] children margin from body
  final EdgeInsets childrenMargin;

  final double borderRadius;
  final bool showDivider;

  const ToggleExpansionTile(
      {required this.onChange,
      required this.children,
      this.bgColor,
      this.childrenBgColor,
      this.title,
      this.titleText,
      this.borderRadius = 7,
      this.childrenMargin =
          const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 0),
      this.titlePadding = AppPadding.inner,
      this.childrenPadding = AppPadding.inner,
      this.initialValue = false,
      this.showDivider = false,
      super.key});

  @override
  State<ToggleExpansionTile> createState() => _ToggleExpansionTileState();
}

class _ToggleExpansionTileState extends State<ToggleExpansionTile>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  late AnimationController _controller;

  /// objects
  List<Widget> get children => widget.children;
  String get title => widget.titleText ?? "Title";

  @override
  void initState() {
    isExpanded = widget.initialValue;
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    startAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleDropdown() {
    setState(() {
      isExpanded = !isExpanded;
    });
    startAnimation();
    widget.onChange(isExpanded);
  }

  startAnimation() {
    if (isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.bgColor ?? Colors.white,
        border: Border.all(color: Colours.border),
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          widget.title ??
              Container(
                padding: widget.titlePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(title, style: appTextTheme.bodyMedium),
                      ],
                    ),
                    gap(),
                    CustomToggleButton(
                        value: isExpanded,
                        onChange: (value) {
                          _toggleDropdown();
                        }),
                  ],
                ),
              ),
          if (widget.showDivider && isExpanded)
            Divider(
              height: 2,
            ),
          SizeTransition(
            sizeFactor: CurvedAnimation(
              parent: _controller,
              curve: Curves.easeInOut,
            ),
            axisAlignment: 1.0,
            child: Container(
              margin: widget.childrenMargin,
              padding: widget.childrenPadding,
              width: double.infinity,
              decoration: BoxDecoration(
                color: widget.childrenBgColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Visibility(
                visible: isExpanded,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget CustomToggleButton(
    {required Function(bool) onChange, required bool value}) {
  var padding = EdgeInsets.only(top: 3, bottom: 3, right: 10, left: 5);
  Widget displayItem(String title, bool value) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () {
        value = !value;
        onChange(value);
      },
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          border: Border.all(color: value ? Colours.blueDark : Colours.border),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          children: [
            Icon(
              value ? Icons.radio_button_checked : Icons.radio_button_off,
              color: value ? Colours.blueDark : Colours.border,
            ),
            gap(space: 10),
            Text(
              title,
              style: textTheme.bodyMedium
                  .copyWith(color: value ? Colours.blueDark : null),
            ),
          ],
        ),
      ),
    );
  }

  return Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      displayItem("Yes", value),
      gap(),
      displayItem("No", !value),
    ],
  );
}
