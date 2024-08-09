import '../exports/main_export.dart';

class CustomDropdown<T> extends FormField<DropDownItem<T>> {
  CustomDropdown({
    DropDownItem<T>? selectedItem,
    required List<DropDownItem<T>> items,
    double? borderRadius,
    double? titleSize,
    double? height,
    Color? borderColor,
    Color? dropDownColor,
    Color? titleColor,
    Color? hintColor,
    Color? bgColor,
    Color? iconColor,
    Color? selectedTextColor,
    Color? itemTextColor,
    BorderRadiusGeometry? borderRadiusShape,
    String? hintText,
    double? fontSize,
    bool isExpanded = true,
    void Function(DropDownItem<T>?)? onSave,
    required void Function(DropDownItem<T>?) onChanged,
    String? Function(DropDownItem<T>?)? validate,
    FocusNode? focusNode,
    Key? key,
  }) : super(
          key: key,
          validator: validate,
          onSaved: onSave,
          initialValue: selectedItem,
          builder: (FormFieldState<DropDownItem<T>> state) {
            return _CustomDropdownWidget(
              selectedItem: selectedItem,
              items: items,
              borderRadius: borderRadius,
              titleSize: titleSize,
              height: height,
              borderColor: borderColor,
              dropDownColor: dropDownColor,
              titleColor: titleColor,
              hintColor: hintColor,
              fontSize: fontSize,
              bgColor: bgColor,
              iconColor: iconColor,
              selectedTextColor: selectedTextColor,
              itemTextColor: itemTextColor,
              borderRadiusShape: borderRadiusShape,
              hintText: hintText,
              isExpanded: isExpanded,
              onChanged: (DropDownItem<T>? value) {
                state.didChange(value);
                onChanged(value);
              },
              focusNode: focusNode,
              state: state,
            );
          },
        );
}

class _CustomDropdownWidget<T> extends StatefulWidget {
  final DropDownItem<T>? selectedItem;
  final List<DropDownItem<T>> items;
  final double? borderRadius;
  final double? titleSize;
  final double? height;
  final Color? borderColor;
  final Color? dropDownColor;
  final Color? titleColor;
  final Color? hintColor;
  final Color? bgColor;
  final Color? iconColor;
  final Color? selectedTextColor;
  final Color? itemTextColor;
  final BorderRadiusGeometry? borderRadiusShape;
  final String? hintText;
  final double? fontSize;
  final bool isExpanded;
  final void Function(DropDownItem<T>?) onChanged;
  final FocusNode? focusNode;
  final FormFieldState<DropDownItem<T>> state;

  const _CustomDropdownWidget({
    this.selectedItem,
    required this.items,
    this.borderRadius,
    this.titleSize,
    this.borderColor,
    this.dropDownColor,
    this.titleColor,
    this.hintColor,
    this.bgColor,
    this.height,
    this.fontSize,
    this.iconColor,
    this.selectedTextColor,
    this.itemTextColor,
    this.borderRadiusShape,
    this.hintText,
    this.isExpanded = true,
    required this.onChanged,
    this.focusNode,
    required this.state,
    Key? key,
  }) : super(key: key);

  @override
  _CustomDropdownWidgetState<T> createState() =>
      _CustomDropdownWidgetState<T>();
}

class _CustomDropdownWidgetState<T> extends State<_CustomDropdownWidget<T>>
    with SingleTickerProviderStateMixin {
  DropDownItem<T>? _selectedItem;
  late AnimationController _controller;
  late Animation<double> _iconRotation;
  FocusNode? get focusNode => widget.focusNode;
  RxBool hasFocus = false.obs;

  @override
  void initState() {
    super.initState();
    initArgs();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void initArgs() {
    _selectedItem = widget.selectedItem;

    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _iconRotation = Tween<double>(begin: 0, end: 1).animate(_controller);

    focusNode?.addListener(() {
      if (focusNode?.hasFocus ?? false) {
        hasFocus.value = true;
      } else {
        hasFocus.value = false;
      }
    });
  }

  void _onDropdownMenuChanged(bool isOpen) {
    if (isOpen) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  Map<String, DropDownItem<T>> get itemsMap {
    return Map.fromIterable(widget.items, key: (e) => e.key, value: (e) => e);
  }

  List<DropDownItem<T>> get items => widget.items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Container(
            height: widget.height,
            key: widget.key,
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                color: widget.bgColor ?? Colors.white,
                border: Border.all(
                    color: widget.state.hasError
                        ? Colours.red
                        : hasFocus.value
                            ? Colours.primary
                            : widget.borderColor ?? Colours.border),
                borderRadius:
                    widget.borderRadiusShape ?? BorderRadius.circular(7)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                dropdownColor: widget.dropDownColor,
                isExpanded: true,
                value: _selectedItem?.key,
                style: TextStyle(
                    color: widget.selectedTextColor ?? Colors.black87,
                    fontSize: widget.fontSize),
                hint: widget.hintText == null
                    ? null
                    : Text(widget.hintText!,
                        style: TextStyle(
                            color: widget.hintColor ?? Colours.greyLight)),
                icon: Transform.rotate(
                  angle: 1.55,
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: widget.iconColor ??
                        (hasFocus.value ? Colors.blue : Colors.black),
                    size: 15,
                  ),
                ),
                iconSize: 24,
                elevation: 16,
                selectedItemBuilder: (context) {
                  return widget.items.map((item) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        item.title,
                        style: TextStyle(
                            fontSize: widget.fontSize,
                            color: widget.selectedTextColor ??
                                Colors.black.withOpacity(0.7)),
                      ),
                    );
                  }).toList();
                },
                focusNode: focusNode,
                onChanged: (String? newValue) {
                  hasFocus.value = false;
                  if (newValue != null) {
                    _selectedItem = itemsMap[newValue];
                    if (_selectedItem?.onTap != null) _selectedItem?.onTap!();
                    widget.onChanged(itemsMap[newValue]);
                    widget.state.didChange(itemsMap[newValue]);
                  } else {
                    _selectedItem = null;
                    widget.state.didChange(null);
                  }
                  setState(() {});
                },
                items: widget.items.map((DropDownItem<T> value) {
                  return DropdownMenuItem<String>(
                    value: value.key,
                    child: Text(
                      value.title,
                      style: TextStyle(
                          fontSize: widget.fontSize,
                          color: widget.itemTextColor ??
                              Colors.black.withOpacity(0.7)),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        if (widget.state.hasError)
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              widget.state.errorText ?? '',
              style: TextStyle(
                color: Colours.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}

Widget CustomDropDownWithLabel<T>({
  Key? key,
  DropDownItem<T>? selectedItem,
  required List<DropDownItem<T>> items,
  required void Function(DropDownItem<T>?) onChanged,
  double? borderRadius,
  double? titleSize,
  Color? borderColor,
  Color? titleColor,
  Color? hintColor,
  String? hintText,
  bool isExpanded = false,
  Function(DropDownItem<T>?)? onSave,
  String? Function(DropDownItem<T>?)? validate,
  FocusNode? focusNode,
  required String labelText,
  String? labelHintText,
  Color? labelHintTextColor,
  double? fontSize,
  int? maxLines,
  EdgeInsets padding = AppPadding.textFieldPadding,
  TextStyle? style,
  double? height,
}) {
  // widget
  return Column(
    key: key,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      RichText(
        maxLines: 1,
        text: TextSpan(
          style: appTextTheme.bodyMedium
              ?.copyWith(fontSize: fontSize, color: Colors.black),
          children: [
            TextSpan(
                text: labelText,
                style: appTextTheme.bodyMedium
                    ?.copyWith(fontSize: fontSize, color: Colors.black)),
            if (labelHintText != null)
              TextSpan(
                text: "  (${labelHintText})",
                style: textTheme.hintTextStyle
                    .copyWith(color: labelHintTextColor, fontSize: fontSize),
              ),
            if (validate != null)
              TextSpan(
                  text: "  *",
                  style: appTextTheme.bodyMedium
                      ?.copyWith(fontSize: 18, color: Colors.grey)),
          ],
        ),
      ),
      SizedBox(height: 10),
      CustomDropdown<T>(
        items: items,
        onChanged: onChanged,
        borderRadius: borderRadius,
        borderColor: borderColor,
        hintText: hintText,
        focusNode: focusNode,
        selectedItem: selectedItem,
        hintColor: hintColor,
        isExpanded: isExpanded,
        onSave: onSave,
        titleColor: titleColor,
        titleSize: titleSize,
        validate: validate,
      ),
    ],
  );
}
