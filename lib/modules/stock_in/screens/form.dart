import 'dart:ffi';

import 'package:jog_inventory/common/utils/date_formater.dart';
import 'package:jog_inventory/common/utils/dotted_border.dart';
import 'package:jog_inventory/modules/stock_in/controllers/form.dart';
import 'package:jog_inventory/modules/stock_in/models/po_order.dart';
import 'package:jog_inventory/modules/stock_in/models/stock_in.dart';
import 'package:jog_inventory/modules/stock_in/widgets/add_fabric_form.dart';

import '../../../common/exports/main_export.dart';

class StockInFromScreen extends StatefulWidget {
  const StockInFromScreen({super.key});

  @override
  State<StockInFromScreen> createState() => _StockInFromScreenState();
}

class _StockInFromScreenState extends State<StockInFromScreen> {
  StockInFormController get controller =>
      getController<StockInFormController>(StockInFormController());

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: "Stock in Form",
      body: body,
      bottomNavBar: bottomNavBar(),
    );
  }

  Widget body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          selectPoNumber(),
          gap(),
          divider(),
          tabsWidget(),
          divider(),

          Obx(
            () => Visibility(
              visible: controller.isAddStock.value,
              child: displayAddedItem(),
            ),
          ),
          Obx(
            () => Visibility(
              visible: !controller.isAddStock.value,
              child: displayReceivedItem(),
            ),
          ),

          /// bottom
          gap(),
          safeAreaBottom(context),
        ],
      ),
    );
  }

  Widget selectPoNumber() {
    return Container(
      decoration: containerDecoration(boxShadow: containerShadow()),
      padding: AppPadding.inner,
      margin: AppPadding.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: bottomSheetMenuWithLabel<PoOrderModel>(
                  labelText: "PO No.",
                  items: [],
                  selectedItems: [
                    if (controller.selectedPo != null)
                      DropDownItem<PoOrderModel>(
                        id: controller.selectedPo!.forId!,
                        title: controller.selectedPo!.poNumber ?? "_",
                        key: "${controller.selectedPo!.forId!}",
                        value: controller.selectedPo,
                      ),
                  ],
                  fromApi: () async {
                    List<DropDownItem<PoOrderModel>> items = [];
                    var data = await PoOrderModel.fetchAll();
                    data.forEach((item) {
                      items.add(DropDownItem<PoOrderModel>(
                          id: item.forId!,
                          title: item.poNumber ?? "_",
                          key: "${item.forId!}",
                          value: item));
                    });
                    return items;
                  },
                  onChanged: (List<DropDownItem<PoOrderModel>>? items) {
                    controller.selectedPo = items?.firstOrNull?.value;
                    setState(() {});
                    controller.getItems();
                  },
                ),
              ),
              gap(space: 10),
              Expanded(
                  child: TextFieldWithLabel(
                key: Key(DateTime.now().microsecond.toString()),
                initialValue: controller.selectedPo == null
                    ? null
                    : appDateTimeFormat.toYYMMDDHHMMSS(
                        date: controller.selectedPo!.poDate,
                        removeTime: true,
                        useNextLine: false),
                labelText: "PO date",
                enabled: false,
              ))
            ],
          ),
          gap(),
          Row(
            children: [
              Expanded(
                child: TextFieldWithLabel(
                  key: Key(DateTime.now().microsecond.toString()),
                  initialValue: controller.selectedPo?.supplier,
                  labelText: "Supplier",
                  enabled: false,
                  onChanged: (item) {},
                ),
              ),
              gap(space: 10),
              Expanded(child: TextFieldWithLabel(labelText: "Stock Date"))
            ],
          ),
        ],
      ),
    );
  }

  Widget tabsWidget() {
    return Obx(
      () => Container(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        color: Colours.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                gap(space: 4),
                InkWell(
                  onTap: () {
                    controller.isAddStock.value = true;
                  },
                  child: Text("Add Stock",
                      style: appTextTheme.titleSmall?.copyWith(
                          color: controller.isAddStock.value
                              ? Colours.secondary
                              : Colours.black)),
                ),
                gap(space: 14),
                SizedBox(
                    width: 120,
                    child: divider(
                        thickness: 2.5,
                        color: controller.isAddStock.value
                            ? Colours.secondary
                            : Colours.white)),
              ],
            ),
            gap(),
            IgnorePointer(
              ignoring: !controller.hasItems,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      controller.isAddStock.value = false;
                    },
                    child: Row(
                      children: [
                        Text("Receive",
                            style: appTextTheme.titleSmall?.copyWith(
                                color: !controller.isAddStock.value
                                    ? Colours.secondary
                                    : controller.hasItems
                                        ? Colours.black
                                        : Colours.greyLight)),
                        Visibility(
                          visible: controller.hasItems,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Stack(
                              children: [
                                Icon(Icons.circle,
                                    color: Colours.green.withOpacity(0.8),
                                    size: 27),
                                Positioned(
                                    top: 0,
                                    left: 0,
                                    bottom: 0,
                                    right: 0,
                                    child: Center(
                                        child: Text(
                                      controller.receivedCount.toString(),
                                      style: appTextTheme.labelSmall?.copyWith(
                                          color: Colours.white, fontSize: 12),
                                    )))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  gap(space: 10),
                  SizedBox(
                      width: 150,
                      child: divider(
                          thickness: 2.5,
                          color: !controller.isAddStock.value
                              ? Colours.secondary
                              : Colours.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget displayAddedItem() {
    return Obx(
      () => displayListBuilder<StockInFormItem>(
        items: controller.items,
        showGap: true,
        builder: (item, index) => addedItemTileWidget(item),
      ),
    );
  }

  Widget displayReceivedItem() {
    return displayListBuilder<ForecastReceivedModel>(
        items: controller.receivedItems,
        showGap: true,
        builder: receivedItemTileWidget);
  }

  Widget addedItemTileWidget(StockInFormItem item) {
    return Container(
      margin: AppPadding.pagePadding,
      decoration: containerDecoration(),
      child: Column(
        children: [
          gap(space: 10),
          Container(
            padding: AppPadding.inner,
            child: Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Material", style: appTextTheme.titleSmall),
                        gap(space: 5),
                        Text(item.material.catNameEn ?? "_",
                            style: appTextTheme.labelMedium
                                ?.copyWith(color: Colours.primaryText)),
                      ],
                    )),
                    gap(space: 10),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Color", style: appTextTheme.titleSmall),
                        gap(space: 5),
                        Text(item.color.fabricColor ?? "_",
                            style: appTextTheme.labelMedium?.copyWith()),
                      ],
                    )),
                  ],
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: (){
                        controller.items.remove(item);
                      },
                      child: Icon(Icons.delete_outlined,
                          size: 25, color: Colours.red),
                    )),
              ],
            ),
          ),
          divider(),
          Container(
              padding: AppPadding.inner,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFieldWithLabel(
                          labelText: "Box",
                          initialValue: "${item.box ?? ""}",
                          onChanged: (data) {
                            item.box = int.tryParse(data);
                          },
                        ),
                      ),
                      gap(space: 10),
                      Expanded(child: TextFieldWithLabel(labelText: "No.",
                        initialValue: "${item.no ?? ""}",
                        onChanged: (data) {
                          item.no = int.tryParse(data)??0;
                        },))
                    ],
                  ),
                  gap(space: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFieldWithLabel(
                          labelText: "Amount (Kg)",
                          initialValue: "${item.amount ?? ""}",
                          onChanged: (data) {
                            item.amount = double.tryParse(data);
                          },
                        ),
                      ),
                      gap(space: 10),
                      Expanded(
                          child: TextFieldWithLabel(
                        initialValue: "${item.unitPrice ?? ""}",
                        labelText: "Unit Price (THB)",
                        onChanged: (data) {
                          item.unitPrice = double.tryParse(data);
                        },
                      ))
                    ],
                  ),
                  gap(space: 10),
                  TextFieldWithLabel(
                    labelText: "Total Price (THB)",
                    enabled: false,
                    initialValue: "${item.total ?? ""}",
                  )
                ],
              )),
          // bottom
          gap(space: 10)
        ],
      ),
    );
  }

  Widget receivedItemTileWidget(ForecastReceivedModel item, index) {
    ///[hasValue] is tot check that the user has entered any value to [item.receiveKg] or not
    RxBool hasValue = ((item.receiveKg ?? "").trim().length > 0).obs;
    return Container(
      margin: AppPadding.pagePaddingAll,
      decoration: containerDecoration(),
      child: Column(
        children: [
          Container(
              padding: AppPadding.inner,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Fabric", style: appTextTheme.titleSmall),
                          gap(space: 5),
                          Text(item.catNameEn ?? "_",
                              style: appTextTheme.labelMedium
                                  ?.copyWith(color: Colours.primaryText)),
                        ],
                      )),
                      gap(space: 10),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Color", style: appTextTheme.titleSmall),
                          gap(space: 5),
                          Text(item.color ?? "_",
                              style: appTextTheme.labelMedium?.copyWith()),
                        ],
                      )),
                    ],
                  ),
                  gap(),
                  Row(
                    children: [
                      Expanded(
                        child: TextFieldWithLabel(
                          labelText: "Order(kg)",
                          initialValue: "${item.qty ?? "_"} Kg",
                          enabled: false,
                        ),
                      ),
                      gap(space: 10),

                      /// received kg
                      Expanded(
                          child: TextFieldWithLabel(
                              inputFormatters: [
                            amountFormatter(),
                          ],
                              enabled: !item.isReceive,
                              disableFillColor: item.isReceive
                                  ? Colours.green.withOpacity(0.3)
                                  : null,
                              labelText: "Receive (in kgs)",
                              labelColor: item.isReceive ? Colours.green : null,
                              initialValue: item.isReceive
                                  ? "${item.qty ?? "_"} Kg"
                                  : null,
                              onChanged: (String? value) {
                                item.receiveKg = value;
                              }))
                    ],
                  ),
                ],
              )),
          if (!item.isReceive) ...[
            dottedDivider(dotSpace: 2),
            gap(space: 10),
            Obx(
              () => Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: PrimaryButton(
                    title: "Receive",
                    onTap: () {
                      controller.onReceived(item);
                    },
                    isEnable: hasValue.value,
                    isBusy: controller.isBusy.value),
              ),
            ),
          ],
          // bottom
          gap(space: 10)
        ],
      ),
    );
  }

  Widget bottomNavBar() {
    return Container(
      color: Colours.white,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                openAddFabricPopup(controller.addItems);
              },
              child: DottedBorderContainer(
                  borderColor: Colours.green,
                  padding: AppPadding.inner,
                  gap: 2,
                  borderWidth: 1.5,
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(10),
                  // ),
                  borderRadius: BorderRadius.circular(10),
                  child: Center(
                      child: Text("Add Fabric",
                          style: appTextTheme.titleSmall
                              ?.copyWith(color: Colours.green)))),
            ),
          ),
          gap(),
          Expanded(
              child: PrimaryButton(
                  title: "Check",
                  onTap: () {},
                  radius: 10,
                  color: Colours.yellow))
        ],
      ),
    );
  }
}
