import 'package:flutter/material.dart';
import 'package:jog_inventory/common/constant/colors.dart';
import 'package:jog_inventory/common/constant/text_theme.dart';
import 'package:jog_inventory/common/utils/common_classes.dart';

class FilterWidget<T> extends StatefulWidget {
  final List<FilterItem<T>> items;
  final void Function(FilterItem<T>?)? onChange;
  final FilterItem<T>? selectedItem;
  final bool allowCancel;
  const FilterWidget({
    Key? key,
    required this.items,
    this.onChange,
    this.allowCancel = true,
    this.selectedItem,
  }) : super(key: key);

  @override
  State<FilterWidget<T>> createState() => _FilterWidgetState<T>();
}

class _FilterWidgetState<T> extends State<FilterWidget<T>> {
  late List<FilterItem<T>> _items;
  FilterItem<T>? selectedItem;

  @override
  void initState() {
    selectedItem = widget.selectedItem;
    super.initState();
    _items = widget.items;
  }

  void _handleSelection(FilterItem<T>? item) {
    selectedItem = item;
    widget.onChange?.call(selectedItem);
    selectedItem?.onTap?.call();
    setState(() {});
  }

  bool isSelected(FilterItem<T> item) => selectedItem?.id == item.id;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _items.map((item) {
          return isSelected(item)
              ? Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Colours.primary,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          Text(
                            item.title,
                            style: appTextTheme.labelMedium?.copyWith(
                                color: Colours.white,
                                fontWeight: FontWeight.bold),
                          ),
                          if (widget.allowCancel) ...[
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                selectedItem = null;
                                setState(() {});
                                _handleSelection(null);
                              },
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 30,
                              ),
                            )
                          ],
                        ],
                      ),
                    ),
                  ],
                )
              : GestureDetector(
                  onTap: () => _handleSelection(item),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colours.border),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      item.title,
                      style: appTextTheme.labelMedium,
                    ),
                  ),
                );
        }).toList(),
      ),
    );
  }
}
