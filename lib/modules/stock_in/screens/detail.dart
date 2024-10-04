import 'package:jog_inventory/modules/material/widgets/popup.dart';
import 'package:jog_inventory/modules/stock_in/controllers/detail.dart';
import 'package:jog_inventory/modules/stock_in/models/stock_in_list.dart';
import '../../../common/exports/main_export.dart';

class StockInDetailScreen extends StatefulWidget {
  const StockInDetailScreen({super.key});

  @override
  State<StockInDetailScreen> createState() => _StockInDetailState();
}

class _StockInDetailState extends State<StockInDetailScreen> {
  StockInDetailController get controller =>
      getController<StockInDetailController>(StockInDetailController());

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(title: "Stock In Detail", body: body);
  }

  Widget body(BuildContext context) {
    return SingleChildScrollView(
      padding: AppPadding.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          orderInfo(),
          gap(),
          Obx(() => Visibility(
              visible: controller.isLoading.value,
              child: listLoadingEffect(height: 100))),
          Obx(
            () => Visibility(
              visible: !controller.isLoading.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  gap(),
                  ...displayList<StockInFabric>(
                      showGap: true,
                      items: controller.stockInData.fabrics,
                      builder: (item, index) => itemTileWidget(item, index)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget orderInfo() {
    return Obx(
      () => shimmerEffects(
        isLoading: controller.isLoading.value,
        child: Container(
          padding: AppPadding.inner,
          decoration: BoxDecoration(
              color: Colours.secondary2,
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleSubtitle(
                  "Pack No.", controller.stockInData.packing?.packNo ?? "_"),
              gap(space: 10),
              titleSubtitle(
                  "PO No.", controller.stockInData.packing?.poNo ?? "_"),
              gap(space: 10),
              titleSubtitle("Supplier",
                  controller.stockInData.packing?.supplierName ?? "_"),
              gap(space: 10),
              titleSubtitle("Create Date",
                  controller.stockInData.packing?.addDate ?? "_"),
              gap(space: 10),
              titleSubtitle(
                  "PO Date", controller.stockInData.packing?.poDate ?? "_"),
              gap(space: 10),
              titleSubtitle(
                  "Inv No.", controller.stockInData.packing?.invNo ?? "",
                  onEdit: () {
                inputTextPopup(
                  context,
                  title: "Edit Inv No.",
                  onSave: controller.postInvoiceData,
                  initialValue: controller.stockInData.packing?.invNo,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleSubtitle(String title, String subtitle, {Function()? onEdit}) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(title,
              style: appTextTheme.labelMedium?.copyWith(color: Colours.white)),
        ),
        gap(),
        Flexible(
          flex: 2,
          child: Row(
            children: [
              Flexible(
                child: Text(subtitle,
                    style: appTextTheme.labelSmall
                        ?.copyWith(color: Colours.white)),
              ),
              Visibility(
                visible: onEdit != null,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: InkWell(
                      onTap: onEdit,
                      child: Icon(
                        Icons.edit,
                        size: 20,
                        color: Colours.white,
                      )),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget itemTileWidget(StockInFabric item, int index) {
    return Container(
        padding: AppPadding.inner,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: containerShadow(),
          color: Colours.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("${item.catNameEn ?? ""} , ",
                    style: appTextTheme.titleSmall
                        ?.copyWith(color: Colours.primaryText)),
                Text("${item.fabricColor}",
                    style: appTextTheme.titleSmall?.copyWith()),
              ],
            ),
            gap(space: 10),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: displayTitleSubtitle("Box", "${item.fabricBox}")),
                Expanded(
                    flex: 2,
                    child: displayTitleSubtitle(
                        "Unit Price (THB)", "${item.fabricInPrice}")),
              ],
            ),
            gap(space: 5),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: displayTitleSubtitle("NO", "${item.fabricNo}")),
                Expanded(
                  flex: 2,
                  child: displayTitleSubtitle("Price", "${item.fabricInTotal}",
                      onEdit: () {
                    RxBool isAll = false.obs;
                    inputTextPopup(
                      context,

                      title: "New Unit Price :",
                      buttonText: "Update",
                      addon: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          gap(space: 10),
                          Obx(
                            () => Row(
                              children: [
                                Text("Update all", style: appTextTheme.titleMedium,),
                                checkBox(
                                    value: isAll.value,
                                    onchange: (value) {
                                      isAll.value = value;
                                    }),
                              ],
                            ),
                          ),
                          gap(),
                          divider()
                        ],
                      ),
                      onSave: (String value) {
                        controller.editPrice(value, isAll.value, item.fabric_id!);
                      },
                      initialValue: controller.stockInData.packing?.invNo,
                    );
                  }),
                ),
              ],
            ),
          ],
        ));
  }

  Widget displayTitleSubtitle(String title, String subtitle,
      {Function()? onEdit}) {
    return Row(
      children: [
        Text(title,
            style: appTextTheme.titleSmall?.copyWith(color: Colours.greyLight)),
        gap(space: 10),
        Text(
          subtitle,
          style: appTextTheme.titleSmall?.copyWith(),
          textAlign: TextAlign.center,
        ),
        Visibility(
          visible: onEdit != null,
          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: InkWell(
                onTap: onEdit,
                child: Icon(
                  Icons.edit,
                  size: 20,
                  color: Colours.greyLight,
                )),
          ),
        )
      ],
    );
  }
}
