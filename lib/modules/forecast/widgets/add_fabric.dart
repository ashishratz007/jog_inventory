import 'package:jog_inventory/common/utils/bottom_sheet.dart';
import 'package:jog_inventory/modules/forecast/models/forecast_item.dart';
import 'package:jog_inventory/modules/material/models/fabric.dart';
import 'package:jog_inventory/services/tab_view_navigator.dart';
import '../../../common/exports/main_export.dart';

void openForeCastAddFabricPopup(Function(List<ForeCastFormItem> items) onAdd) {
  showAppBottomSheet(
      Get.context!,
      _addFabric(
        onAdd: onAdd,
      ),
      title: "Add Forecast");
}

class _addFabric extends StatefulWidget {
  final Function(List<ForeCastFormItem> items) onAdd;
  const _addFabric({required this.onAdd, super.key});

  @override
  State<_addFabric> createState() => _addFabricState();
}

class _addFabricState extends State<_addFabric> {
  MenuItemsController fabricController = MenuItemsController();
  MenuItemsController fabricColorController = MenuItemsController();

  FabricCategoryModel? selectedFabCate;
  FabricColorModel? selectedFabColor;
  String forecast = "";

  String balance  = "";
  RxBool balanceLoading = false.obs;

  getBalance() async{
    balanceLoading.value = true;
    try{
      /// for color not selected
      if (selectedFabColor?.fabricColor == null) {
        throw "Select Color first to see data here";
      }
      var items = await ColorBoxesModel.fetchBoxes(
          selectedFabCate!.catId!, selectedFabColor!.fabricColor!);
      var bal = 0.0;
      items.forEach((item) => bal += item.fabricBalance ?? 0.0);
      balance = bal.toString();
      balance = formatDecimal(balance);
      balanceLoading.value = false;
    }catch(e,t){
      balanceLoading.value = false;
    }
    balanceLoading.value = false;
  }

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
                        balance = "";
                        forecast = "";
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
                      balance = "";
                      forecast = "";
                      selectedFabColor = item?.firstOrNull?.value;
                      getBalance();
                      setState(() {});
                    },
                    labelText: Strings.color,
                    hintText: Strings.color,
                  )),
            ],
          ),
          gap(space: 20),
          Row(
            children: [
              Expanded(
                child: Obx(()=> shimmerEffects(
                    isLoading: balanceLoading.value,
                    child: TextFieldWithLabel(
                      key: Key(balance),
                      labelText: "Balance(Kg)",
                      initialValue: balance,
                      enabled: false,
                    ),
                  ),
                ),
              ),
              gap(space: 10),
              Expanded(
                child: TextFieldWithLabel(
                  labelText: "Forecast(Kg)",
                  onChanged: (val) {
                    forecast = val;
                    setState(() {});
                  },
                ),
              ),
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
            isEnable: selectedFabCate != null && selectedFabColor != null && !forecast.isEmpty,
            onTap: () {
              widget.onAdd([ForeCastFormItem(
                  material: selectedFabCate!,
                  balance: balance,
                  forecast: forecast,
                  color: selectedFabColor!,)]);
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
