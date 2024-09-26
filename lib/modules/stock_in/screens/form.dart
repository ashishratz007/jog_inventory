import 'package:jog_inventory/common/utils/dotted_border.dart';
import 'package:jog_inventory/modules/stock_in/controllers/form.dart';
import 'package:jog_inventory/modules/stock_in/models/po_order.dart';
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

          addedItemTileWidget(),
          gap(),
          receivedItemTileWidget(),

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
                  fromApi: ()async{
                    List<DropDownItem<PoOrderModel>> items = [];
                   var data = await PoOrderModel.fetchAll();
                    data.forEach((item){
                      items.add(DropDownItem<PoOrderModel>(id: item.forId!,title:item.poNumber??"_" ,key:"${item.forId!}" ,value:item ));
                    });
                   return items;
                  },
                  onChanged: (item) {},
                ),
              ),
              gap(space: 10),
              Expanded(child: TextFieldWithLabel(labelText: "PO date"))
            ],
          ),
          gap(),
          Row(
            children: [
              Expanded(
                child: TextFieldWithLabel(
                  labelText: "Supplier",
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
                Text("Add Stock",
                    style: appTextTheme.titleSmall
                        ?.copyWith(color: Colours.greyLight)),
                gap(space: 10),
                SizedBox(
                    width: 80,
                    child: divider(
                        thickness: 2.5,
                        color: controller.isAddStock.value
                            ? Colours.secondary
                            : Colours.white)),
              ],
            ),
            gap(),
            Column(
              children: [
                Text("Receive",
                    style: appTextTheme.titleSmall?.copyWith(
                        color: !controller.isAddStock.value
                            ? Colours.secondary
                            : Colours.greyLight)),
                gap(space: 10),
                SizedBox(
                    width: 80,
                    child: divider(
                        thickness: 2.5,
                        color: !controller.isAddStock.value
                            ? Colours.secondary
                            : Colours.white)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget addedItemTileWidget() {
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
                            Text("VI-SUPERPLUS",
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
                            Text("Dust Gold",
                                style: appTextTheme.labelMedium?.copyWith()),
                          ],
                        )),
                  ],
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: Icon(Icons.delete_outlined,size: 25, color: Colours.red)),
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
                          onChanged: (item) {},
                        ),
                      ),
                      gap(space: 10),
                      Expanded(
                          child:
                              TextFieldWithLabel(labelText: "No."))
                    ],
                  ),
                  gap(space: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFieldWithLabel(
                          labelText: "Amount (Kg)",
                          onChanged: (item) {},
                        ),
                      ),
                      gap(space: 10),
                      Expanded(
                          child:
                          TextFieldWithLabel(labelText: "Unit Price (THB)"))
                    ],
                  ),
                  gap(space: 10),
                  TextFieldWithLabel(labelText: "Total Price (THB)")
                ],
              )),
          dottedDivider(dotSpace: 2),
          gap(space: 10),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: PrimaryButton(
              title: "Receive",
              onTap: () {},
              isEnable: false,
            ),
          ),
          // bottom
          gap(space: 20)
        ],
      ),
    );
  }

  Widget receivedItemTileWidget() {
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
                          Text("VI-SUPERPLUS",
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
                          Text("Dust Gold",
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
                          onChanged: (item) {},
                        ),
                      ),
                      gap(space: 10),
                      Expanded(
                          child:
                              TextFieldWithLabel(labelText: "Receive (in kgs)"))
                    ],
                  ),
                ],
              )),
          dottedDivider(dotSpace: 2),
          gap(space: 10),
          PrimaryButton(
            title: "Receive",
            onTap: () {},
            isEnable: false,
          ),
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
              onTap: (){
                openAddFabricPopup();
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
