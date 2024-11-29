import 'package:jog_inventory/common/utils/bottom_sheet.dart';
import 'package:jog_inventory/modules/material/models/fabric.dart';
import 'package:jog_inventory/modules/stock_in/models/stock_in.dart';
import 'package:jog_inventory/services/tab_view_navigator.dart';

import '../../../common/exports/main_export.dart';

void openAddFabricPopup(BuildContext context, Function(List<StockInFormItem> items) onAdd) {
  showAppBottomSheet(
      context,
      _addFabric(
        onAdd: onAdd,
      ),
      title: "Add Fabric");
}

class _addFabric extends StatefulWidget {
  final Function(List<StockInFormItem> items) onAdd;
  const _addFabric({required this.onAdd, super.key});

  @override
  State<_addFabric> createState() => _addFabricState();
}

class _addFabricState extends State<_addFabric> {
  MenuItemsController fabricController = MenuItemsController();
  MenuItemsController fabricColorController = MenuItemsController();

  FabricCategoryModel? selectedFabCate;
  FabricColorModel? selectedFabColor;
  String? unitPrice;
  String? rolls;
  String? startNo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.pagePadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              /// Fabric
              Expanded(
                  child: PrimaryFieldMenuWithLabel<FabricCategoryModel>(
                      controller: fabricController,
                      items: [],
                      allowSearch: true,
                      fromApi: () async {
                        var items = await FabricCategoryModel.fetchAll();
                        return List.generate(
                            items.length,
                            (index) => DropDownItem(
                                id: index,
                                key: items[index].catCode ?? "_",
                                title: items[index].catCode ?? "_",
                                value: items[index]));
                      },
                      onChanged: (item) {
                        selectedFabCate = item?.firstOrNull?.value;
                        fabricColorController.clearItems!();
                        setState(() {});
                      },
                      hintText: Strings.fabric,
                      labelText: Strings.fabric)),
              gap(space: 10),

              /// Color
              Expanded(
                  child: PrimaryFieldMenuWithLabel<FabricColorModel>(
                controller: fabricColorController,
                items: [],
                allowSearch: true,
                fromApi: () async {
                  /// for category not selected
                  if (selectedFabCate?.catId == null) {
                    throw "Select Fabric first to see data here";
                  }
                  var colors =
                      await FabricColorModel.getColors(selectedFabCate!.catId!);
                  return List.generate(
                      colors.length,
                      (index) => DropDownItem(
                          id: index,
                          key: colors[index].fabricColor ?? "_",
                          title: colors[index].fabricColor ?? "_",
                          value: colors[index]));
                },
                onChanged: (item) {
                  selectedFabColor = item?.firstOrNull?.value;
                  setState(() {});
                },
                labelText: Strings.color,
                hintText: Strings.color,
              )),
            ],
          ),
          gap(space: 10),
          TextFieldWithLabel(
            labelText: "Unit Price",
            onChanged: (item) {
              unitPrice = item;
            },
          ),
          gap(space: 10),
          Row(
            children: [
              Expanded(
                child: TextFieldWithLabel(
                  labelText: "Rolls",
                  onChanged: (item) {
                    rolls = item;
                  },
                ),
              ),
              gap(space: 10),
              Expanded(
                  child: TextFieldWithLabel(
                labelText: "Start No.",
                onChanged: (item) {
                  startNo = item;
                },
              ))
            ],
          ),
          gap(space: 20),

          PrimaryButton(
            title: "Add",
            color: Colours.greenLight,
            leading: Icon(
              Icons.add,
              color: Colours.white,
            ),
            isEnable: selectedFabCate != null && selectedFabColor != null,
            onTap: () {
              List<StockInFormItem> items = [];
              int count = int.tryParse(rolls ?? "") ?? 0;
              int startCount = int.tryParse(startNo ?? "") ?? 0;
              double? unitPriceDouble = double.tryParse(unitPrice ?? "");
              if (count == 0) {
                items.add(StockInFormItem(
                    material: selectedFabCate!,
                    color: selectedFabColor!,
                    no: startCount,
                    unitPrice: unitPriceDouble));
              }
              for (var i = 0; i < count; i++) {
                items.add(StockInFormItem(
                    material: selectedFabCate!,
                    color: selectedFabColor!,
                    no: startCount,
                    unitPrice: unitPriceDouble));
                startCount++;
              }
              widget.onAdd(items);
              mainNavigationService.pop();
            },
          ),
          // bottom
          gap(),
          SafeAreaBottom(context)
        ],
      ),
    );
  }
}
