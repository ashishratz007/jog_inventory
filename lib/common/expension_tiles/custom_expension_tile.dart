import 'package:jog_inventory/common/constant/colors.dart';
import 'package:jog_inventory/common/constant/padding.dart';
import 'package:jog_inventory/common/constant/text_theme.dart';
import 'package:jog_inventory/common/exports/common.dart';
import 'package:jog_inventory/common/utils/utils.dart';

import '../exports/main_export.dart';

class CustomExpansionTile extends StatefulWidget {
  ///[onChange] indicates that the tile is opened or closed
  final void Function(bool)? onChange;

  /// toggle dropDown
  final ExpansionTileNotifier? notifier;

  ///[initialValue] is tile expanded or closed
  final bool initialValue;

  final BoxDecoration? iconDecoration;

  final Color? bgColor;
  final Color? borderColor;

  ///[] is tile expanded or closed
  final Color? childrenBgColor;

  ///[title] main elements of the widget
  final Widget? title;

  ///[title] main elements of the widget
  final String? titleText;

  ///[title] main elements of the widget
  final TextStyle? titleTextStyle;

  ///[titlePadding] children body padding
  final EdgeInsets titlePadding;

  ///[children] children when te tile is expanded
  final List<Widget> children;

  ///[childrenPadding] children body padding
  final EdgeInsets childrenPadding;

  ///[childrenPadding] children margin from body
  final EdgeInsets childrenMargin;

  final double borderRadius;
  final bool showDivider;
  final bool hideTrailing;
  final bool cancelExpand;
  final Widget? subTitle;
  final Widget? trailing;
  final Color? iconColor;
  final Widget? icon;

  const CustomExpansionTile(
      {required this.children,
      this.onChange,
      this.notifier,
      this.bgColor,
      this.borderColor,
      this.childrenBgColor,
      this.title,
      this.titleText,
      this.borderRadius = 7,
      this.childrenMargin =
          const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 0),
      this.titlePadding = AppPadding.inner,
      this.childrenPadding = AppPadding.inner,
      this.initialValue = false,
      this.hideTrailing = false,
      this.showDivider = false,
      this.cancelExpand = false,
      this.titleTextStyle,
      this.subTitle,
      this.iconDecoration,
      this.iconColor,
      this.trailing,
      this.icon,
      super.key});

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile>
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
    addListerToNotifier();
  }

  addListerToNotifier() {
    // widget.notifier?.isExpanded = isExpanded;
    widget.notifier?.addListener(() {
      var newState = widget.notifier!.isExpanded;
      if (newState != isExpanded) {
        if (mounted) _toggleDropdown();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleDropdown() {
    if(widget.cancelExpand) return;
    setState(() {
      isExpanded = !isExpanded;
      if (widget.onChange != null) widget.onChange!(isExpanded);
    });
    startAnimation();
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
        border: Border.all(color: widget.borderColor ?? Colours.border),
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// Title
          InkWell(
            onTap: _toggleDropdown,
            child: Container(
              padding: widget.titlePadding,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      widget.title ??
                          Text(
                            title,
                            style: widget.titleTextStyle ??
                                appTextTheme.labelMedium,
                          ),
                      if (!widget.hideTrailing && widget.trailing == null)
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: _controller.value == 0
                                  ? 4.7
                                  : (_controller.value * 1.6),
                              child: widget.icon ??
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: widget.iconColor,
                                    size: 20,
                                  ),
                            );
                          },
                        ),
                      if (widget.trailing != null) widget.trailing!,
                    ],
                  ),
                  if (widget.subTitle != null) ...[
                    gap(),
                    widget.subTitle!,
                  ],
                ],
              ),
            ),
          ),
          if (widget.showDivider && isExpanded) Divider(height: 2),

          /// children
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExpansionTileNotifier extends ChangeNotifier {
  bool _isExpanded;
  ExpansionTileNotifier(this._isExpanded);

  bool get isExpanded => _isExpanded;

  set isExpanded(bool value) {
    _isExpanded = value;
    notifyListeners();
  }
}
