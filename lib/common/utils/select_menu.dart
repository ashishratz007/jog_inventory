import '../../../common/exports/main_export.dart';

class BottomSheetItemMenuController<T> {
  void Function()? clearItems;
  void Function()? resetItems;
  Function({String? query})? getItems;
}

class bottomSheetItemMenu<T> extends FormField<DropDownItem<T>> {
  final Future<List<DropDownItem<T>>> Function()? fromApi;
  final Future<List<DropDownItem<T>>> Function(String)? searchApi;
  final BottomSheetItemMenuController? controller; /// controller to change states like reset clear items and all
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
  final String? title;
  final double? fontSize;
  final bool isExpanded;
  final bool allowSearch;
  final void Function(DropDownItem<T>?) onChanged;
  final void Function(DropDownItem<T>?)? onSave;
  final String? Function(DropDownItem<T>?)? validate;
  final FocusNode? focusNode;

  bottomSheetItemMenu({
    DropDownItem<T>? selectedItem,
    required List<DropDownItem<T>> items,
    this.fromApi,
    this.searchApi,
    this.borderRadius,
    this.titleSize,
    this.height,
    this.borderColor,
    this.dropDownColor,
    this.titleColor,
    this.hintColor,
    this.bgColor,
    this.iconColor,
    this.selectedTextColor,
    this.itemTextColor,
    this.borderRadiusShape,
    this.hintText,
    this.fontSize,
    this.title,
    this.isExpanded = true,
    this.allowSearch = false,
    required this.onChanged,
    this.onSave,
    this.validate,
    this.focusNode,
    this.controller,

    Key? key,
  }) : super(
          key: key,
          initialValue: selectedItem,
          validator: null,
          onSaved: null,
          builder: (FormFieldState<DropDownItem<T>> state) {
            return _SelectItemMenuWidget<T>(
              selectedItem: selectedItem,
              items: items,
              fromApi: fromApi,
              searchApi: searchApi,
              borderRadius: borderRadius,
              titleSize: titleSize,
              height: height,
              borderColor: borderColor,
              dropDownColor: dropDownColor,
              titleColor: titleColor,
              hintColor: hintColor,
              bgColor: bgColor,
              iconColor: iconColor,
              selectedTextColor: selectedTextColor,
              itemTextColor: itemTextColor,
              borderRadiusShape: borderRadiusShape,
              hintText: hintText,
              fontSize: fontSize,
              isExpanded: isExpanded,
              title: title,
              allowSearch: allowSearch,
              onChanged: (DropDownItem<T>? value) {
                state.didChange(value);
                onChanged(value);
              },
              focusNode: focusNode,
              state: state,
              controller: controller,
            );
          },
        );
}

// Define the _SelectItemMenuWidget widget.
class _SelectItemMenuWidget<T> extends StatefulWidget {
  final DropDownItem<T>? selectedItem;
  final List<DropDownItem<T>> items;
  final Future<List<DropDownItem<T>>> Function()? fromApi;
  final Future<List<DropDownItem<T>>> Function(String)? searchApi;
  final BottomSheetItemMenuController? controller; /// controller to change states like reset clear items and all
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
  final String? title;
  final double? fontSize;
  final bool isExpanded;
  final bool allowSearch;
  final void Function(DropDownItem<T>?) onChanged;
  final FocusNode? focusNode;
  final FormFieldState<DropDownItem<T>> state;

  const _SelectItemMenuWidget({
    this.selectedItem,
    required this.items,
    required this.title,
    this.fromApi,
    this.searchApi,
    this.borderRadius,
    this.titleSize,
    this.height,
    this.borderColor,
    this.dropDownColor,
    this.titleColor,
    this.hintColor,
    this.bgColor,
    this.iconColor,
    this.selectedTextColor,
    this.itemTextColor,
    this.borderRadiusShape,
    this.hintText,
    this.fontSize,
    this.isExpanded = true,
    this.allowSearch = true,
    required this.onChanged,
    this.focusNode,
    required this.state,
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  _SelectItemMenuWidgetState<T> createState() =>
      _SelectItemMenuWidgetState<T>();
}

// Define the state for _SelectItemMenuWidget.
class _SelectItemMenuWidgetState<T> extends State<_SelectItemMenuWidget<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconRotation;
  FocusNode get focusNode => widget.focusNode ?? FocusNode();
  RxBool isLoading = false.obs;

  /// [isSearchLoading] is used to show loading when we call [widget.searchApi] function
  RxBool isSearchLoading = false.obs; // global search key
  List<DropDownItem<T>> items = [];
  DropDownItem<T>? _selectedItem;

  /// [initState] initial state when widget is being called
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _iconRotation = Tween<double>(begin: 0, end: 0.5).animate(_controller);

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
    // Assign controller actions
    if (widget.controller != null) {
      widget.controller!.clearItems = _clearItems;
      widget.controller!.resetItems = _resetItems;
      widget.controller!.getItems = loadItems;
    }

    _selectedItem = widget.selectedItem;
    items = widget.items;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? error;

  /// in case of search from api we will pass the query inside this function
  Future<void> loadItems({String? query}) async {
    if ((widget.fromApi != null && items.isEmpty) || query != null) {
      error = null;
      try {
        /// in case of normal functions and also it we are passing search api and the widget is loading first time
        if (query == null) {
          isLoading.value = true;
          items = await widget.fromApi!();
        }

        /// in case of external search api
        else {
          isSearchLoading.value = true;
          items = await widget.searchApi!(query);
        }
        isLoading.value = false;
        isSearchLoading.value = false;
      } catch (e, trace) {
        error = "Unable to load items";
        isLoading.value = false;
        isSearchLoading.value = false;
      } finally {
        isLoading.value = false;
        isSearchLoading.value = false;
      }
    }
  }

  List<DropDownItem<T>> filterItemsLst(String query) {
    return items
        .where((item) => item.title
            .trim()
            .toLowerCase()
            .contains(query.trim().toLowerCase()))
        .toList();
  }


  // Function to clear items
  void _clearItems() {
    setState(() {
      items.clear();
      _selectedItem = null;
      widget.state.didChange(null);
    });
  }

  // Function to reset items
  void _resetItems() {
    setState(() {
      items = widget.items;
      _selectedItem = widget.selectedItem;
      widget.state.didChange(_selectedItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => shimmerEffects(
        isLoading: isLoading.value,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: _showBottomSheet,
              child: Container(
                height: widget.height ?? 45,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: widget.bgColor ?? Colors.white,
                  border: Border.all(
                    color: widget.state.hasError
                        ? Colors.red
                        : widget.borderColor ?? Colors.grey,
                  ),
                  borderRadius:
                      widget.borderRadiusShape ?? BorderRadius.circular(7),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _selectedItem?.title ?? widget.hintText ?? '',
                            style: TextStyle(
                              color: _selectedItem == null
                                  ? widget.hintColor ?? Colors.grey
                                  : widget.selectedTextColor ?? Colors.black87,
                              fontSize: widget.fontSize,
                            ),
                          ),
                        ),
                        Transform.rotate(
                          angle: 1.55,
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: widget.iconColor ??
                                (focusNode.hasFocus ? Colors.blue : Colors.black),
                            size: 15,
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ),
            if (widget.state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  widget.state.errorText ?? '',
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet() {
    loadItems();
    Rx<TextEditingController> controller = TextEditingController().obs;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Obx(() {
          if (isLoading.value) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                  padding: AppPadding.pagePadding,
                  height: 250,
                  color: Colours.white,
                  width: Get.width,
                  child: listLoadingEffect(
                    count: 3,
                  )),
            );
          } else {
            return Stack(
              children: [
                StatefulBuilder(builder: (context, setState) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                    constraints: BoxConstraints(
                      maxHeight: Get.height - 50,
                      minWidth: 300,
                    ),
                    padding: EdgeInsets.only(
                        top: 20, bottom: 15, left: 15, right: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          /// appbar gap
                          Row(),
                          gap(space: 40),
                          // if called searchApi api
                          if (isSearchLoading.value)
                            Container(
                                padding: AppPadding.pagePadding,
                                height: 250,
                                color: Colours.white,
                                width: Get.width,
                                child: listLoadingEffect(
                                  count: 3,
                                )),

                          /// no items
                          if (!isSearchLoading.value)
                            Visibility(
                              visible: items.length == 0 && error == null,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.data_array,
                                      size: 40,
                                      color: Colours.border,
                                    ),
                                    gap(space: 10),
                                    Text(
                                      "No Items",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colours.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          /// error
                          if (!isSearchLoading.value)
                            Visibility(
                                visible:
                                    error != null && !isSearchLoading.value,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.error,
                                      color: Colours.red,
                                      size: 30,
                                    ),
                                    gap(space: 10),
                                    Text("Error Loading Data.\nTry again!",
                                        textAlign: TextAlign.center,
                                        style: appTextTheme.titleMedium),
                                    gap(space: 10),
                                    IconButton(
                                        onPressed: () {
                                          /// parsing query if user search api
                                          var query;
                                          if (widget.searchApi != null) {
                                            query = controller.value.text;
                                          }
                                          loadItems(query: query);
                                        },
                                        icon: Icon(Icons.refresh,
                                            size: 30, color: Colours.blue))
                                  ],
                                )),

                          /// search widget
                          Visibility(
                            visible: widget.allowSearch,
                            child: PrimaryTextField(
                                radius: 100,
                                hintText: "Search...",
                                fillColor: Colors.white,
                                controller: controller.value,
                                borderColor: Colours.border.withOpacity(0.5),
                                onChanged: (value) {
                                  /// looking for search from api function if you have provide function
                                  if (widget.fromApi != null) {
                                    loadItems(query: value);
                                  }

                                  /// normal search function
                                  else
                                    controller.refresh();
                                },
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      /// looking for search from api function if you have provide function
                                      if (widget.fromApi != null) {
                                        loadItems(query: controller.value.text);
                                      }
                                    },
                                    icon: Icon(
                                      Icons.search,
                                      size: 30,
                                      color: Colours.primary,
                                    ))),
                          ),

                          /// display items
                          Obx(() => Visibility(
                            visible: isSearchLoading.value || !isSearchLoading.value,
                            child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: displayList<DropDownItem<T>>(
                                      items:
                                          filterItemsLst(controller.value.text),
                                      builder: (item, index) {
                                        return InkWell(
                                          borderRadius: BorderRadius.circular(10),
                                          onTap: () {
                                            setState(() {
                                              _selectedItem = item;
                                            });
                                            widget.onChanged(item);
                                            widget.state.didChange(item);
                                            Get.back(result: item);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                // borderRadius: BorderRadius.circular(10),
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Colours.border))),
                                            height: 40,
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                item.title,
                                                style: TextStyle(
                                                    fontSize:
                                                        widget.fontSize ?? 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: widget.itemTextColor ??
                                                        Colors.black
                                                            .withOpacity(0.7)),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                          )),
                          safeAreaBottom(context)
                        ],
                      ),
                    ),
                  );
                }),

                /// app drag bar
                Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: Colours.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            gap(space: 10),
                            Container(
                                width: 100,
                                height: 5,
                                decoration: BoxDecoration(
                                    color: Colours.border.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(100))),
                            gap(space: 10),
                            Text(widget.title ?? "_",
                                style: textTheme.titleSmall),
                            gap(space: 10),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        });
      },
    );
  }
}

Widget bottomSheetItemMenuWithLabel<T>({
  Key? key,
  DropDownItem<T>? selectedItem,
  required List<DropDownItem<T>> items,
  required void Function(DropDownItem<T>?) onChanged,
  final Future<List<DropDownItem<T>>> Function()? fromApi,
  final Future<List<DropDownItem<T>>> Function(String)? searchApi,
  final BottomSheetItemMenuController? controller, /// controller to change states like reset clear items and all
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
  bool allowSearch = false,
  EdgeInsets padding = AppPadding.textFieldPadding,
  TextStyle? style,
  double? height,
}) {
  // widget
  return Column(
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
      bottomSheetItemMenu<T>(
        key: key,
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
        fromApi: fromApi,
        searchApi: searchApi,
        fontSize: fontSize,
        title: labelText,
        allowSearch: allowSearch,
        controller: controller,
      ),
    ],
  );
}
