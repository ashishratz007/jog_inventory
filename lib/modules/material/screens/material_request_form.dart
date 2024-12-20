import 'package:jog_inventory/common/utils/date_formater.dart';
import 'package:jog_inventory/common/utils/dotted_border.dart';
import 'package:jog_inventory/modules/home/controllers/home.dart';
import 'package:jog_inventory/modules/material/controllers/material_request_form.dart';
import 'package:jog_inventory/modules/material/models/material_request.dart';
import 'package:jog_inventory/modules/material/models/fabric.dart';
import 'package:jog_inventory/modules/material/models/search.dart';
import 'package:jog_inventory/modules/material/widgets/order_codes_remove.dart';
import '../../../common/exports/main_export.dart';

class MaterialRequestFormScreen extends GetView<MaterialRequestFormController> {
  const MaterialRequestFormScreen({super.key});

  MaterialRequestFormController get controller =>
      MaterialRequestFormController.getController();

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      onBack: () {
        removeController<MaterialRequestFormController>(controller);
      },
      title: "Material requisition form",
      body: body,
      bottomNavBar: bottomNavBarButtons(context),
    );
  }

  Widget body(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: AppPadding.pagePadding,
            child: Column(
              children: [
                if (controller.isUpdate.value) ...[
                  orderInfo(),
                  gap(),
                  dottedDivider()
                ],
                if (!controller.isUpdate.value) ...[
                  selectOrderCode(),
                  gap(),
                  dottedDivider(),
                ],
                gap(),

                /// Loading effects
                Obx(() => Visibility(
                      visible: controller.isLoading.value,
                      child: listLoadingEffect(height: 100),
                    )),

                /// Items list
                Obx(
                  () => Visibility(
                    visible: !controller.isLoading.value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...displayItemsWidget(),
                      ],
                    ),
                  ),
                ),

                gap(),
              ],
            ),
          ),
        ),
        gap(space: 10),
        dottedDivider(),
        gap(space: 10),
        addButtonWidget(),

        addNewItemTile(),

        ///
      ],
    );
  }

  /// for new Material RQ
  Widget selectOrderCode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: AppPadding.inner,
              decoration: BoxDecoration(
                color: Colours.border,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Text("Date",
                      style: appTextTheme.labelSmall?.copyWith(fontSize: 13)),
                  Text("  ${dateTimeFormat.toYYMMDDHHMMSS()}",
                      style: appTextTheme.labelSmall?.copyWith(fontSize: 14)),
                ],
              ),
            ),
            TextBorderButton(
                onTap: () {
                  openOrderCodeRemovePopup(Get.context!);
                },
                title: "Remove Codes",
                color: Colours.primary,
                borderColor: Colours.primary)
          ],
        ),
        gap(),

        /// select codes
        Container(
            padding: AppPadding.inner,
            decoration: BoxDecoration(
              color: Colours.white,
              boxShadow: containerShadow(),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: PrimaryFieldMenuWithLabel<OrderCodeData>(
                          items: [],
                          allowSearch: true,
                          allowMultiSelect: false,
                          searchApi: searchCodesMenuItems,
                          fromApi: () async {
                            return searchCodesMenuItems("");
                          },
                          onChanged: (value) {
                            controller.selectedOrderCode =
                                value?.firstOrNull?.value;
                          },
                          labelText: Strings.orderCode,
                          hintText: "Select " + Strings.orderCode),
                    ),
                    gap(space: 10),
                    Obx(
                      () => Visibility(
                        visible: controller.isAddonYear.value,
                        child: Expanded(
                          child: PrimaryFieldMenuWithLabel(
                              items: [],
                              searchApi: searchCodesMenuItems,
                              fromApi: () async {
                                return searchCodesMenuItems("");
                              },
                              onChanged: (value) {},
                              labelText: "",
                              hintText: "Select Code"),
                        ),
                      ),
                    ),
                  ],
                ),
                gap(space: 10),
                Row(
                  children: [
                    Text("Add-On Year",
                        style: appTextTheme.labelSmall?.copyWith()),
                    gap(space: 10),
                    Obx(
                      () => InkWell(
                          // onTap: () {
                          //   controller.isAddonYear.toggle();
                          // },
                          child: Icon(
                              !controller.isAddonYear.value
                                  ? Icons.check_box_outline_blank_rounded
                                  : Icons.check_box_outlined,
                              size: 25,
                              color: controller.isAddonYear.value
                                  ? Colours.primary
                                  : Colours.border)),
                    )
                  ],
                ),
              ],
            ))
      ],
    );
  }

  /// for update
  Widget orderInfo() {
    return Container(
      padding: AppPadding.inner,
      decoration: BoxDecoration(
          color: Colours.secondary2, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(Strings.status,
                  style:
                      appTextTheme.labelMedium?.copyWith(color: Colours.white)),
              gap(),
              Text(controller.materialRqDetail?.rqStatus ?? "_",
                  style:
                      appTextTheme.labelMedium?.copyWith(color: Colours.white)),
              Expanded(child: SizedBox()),
              displayAssetsWidget(AppIcons.boxes_white, height: 22)
            ],
          ),
          gap(space: 10),
          Row(
            children: [
              Text(Strings.orderCode,
                  style: appTextTheme.labelMedium
                      ?.copyWith(color: Colours.white, fontSize: 13)),
              gap(space: 5),
              Text(controller.materialRqDetail?.orderCode ?? "_",
                  style: appTextTheme.labelSmall
                      ?.copyWith(color: Colours.white, fontSize: 13)),
              Expanded(child: SizedBox()),
              Text(Strings.date,
                  style: appTextTheme.labelMedium
                      ?.copyWith(color: Colours.white, fontSize: 13)),
              gap(space: 5),
              Text(
                  dateTimeFormat.toYYMMDDHHMMSS(
                      removeTime: true,
                      date: controller.materialRqDetail?.rqDate),
                  style: appTextTheme.labelSmall
                      ?.copyWith(color: Colours.white, fontSize: 13)),
            ],
          )
        ],
      ),
    );
  }

  List<Widget> displayItemsWidget() {
    return displayList<MaterialRQItem>(
      items: controller.items,
      showGap: true,
      builder: (item, index) => itemTileWidget(item),
    );
  }

  Widget itemTileWidget(MaterialRQItem item) {
    return Container(
      padding: AppPadding.inner,
      decoration:
          BoxDecoration(color: Colours.white, boxShadow: containerShadow()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!config.isTablet) ...[
            Row(
              children: [
                Text("${item.fabricNo ?? ""}",
                    style: appTextTheme.labelSmall
                        ?.copyWith(color: Colours.greyLight)),
                gap(space: 10),
                Text("${item.catNameEn} ,",
                    style: appTextTheme.labelSmall
                        ?.copyWith(color: Colours.primaryText)),
                gap(space: 10),
                Text("${item.fabricColor}",
                    style: appTextTheme.labelSmall
                        ?.copyWith(color: Colours.blackLite)),
                Expanded(child: SizedBox()),
                IconButton(
                    onPressed: () {
                      controller.items.remove(item);
                    },
                    icon: Icon(Icons.delete_outlined,
                        size: 20, color: Colours.red))
              ],
            ),
            gap(space: 10),
            Row(
              children: [
                gap(space: 25),
                Text(Strings.box,
                    style: appTextTheme.labelSmall
                        ?.copyWith(color: Colours.greyLight)),
                gap(space: 5),
                Text("${item.fabricBox ?? 0}",
                    style: appTextTheme.labelSmall
                        ?.copyWith(color: Colours.blackLite)),
                Expanded(child: SizedBox()),
                Text(Strings.bal,
                    style: appTextTheme.labelSmall
                        ?.copyWith(color: Colours.greyLight)),
                gap(space: 10),
                Text("${item.fabricBalance ?? 0.0} kg",
                    style: appTextTheme.labelSmall
                        ?.copyWith(color: Colours.blackLite)),
                gap(space: 50),
              ],
            )
          ],
          if (config.isTablet) ...[
            Row(
              children: [
                Text("Material",
                    style: appTextTheme.labelSmall
                        ?.copyWith(color: Colours.blackLite)),
                gap(space: 10),
                Text("${item.catNameEn} ",
                    style: appTextTheme.labelSmall
                        ?.copyWith(color: Colours.primaryText)),
                Expanded(child: SizedBox()),
                IconButton(
                    onPressed: () {
                      controller.items.remove(item);
                    },
                    icon: Icon(Icons.delete_outlined,
                        size: 20, color: Colours.red))
              ],
            ),
            gap(space: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text("Color",
                        style: appTextTheme.labelSmall
                            ?.copyWith(color: Colours.blackLite)),
                    gap(space: 5),
                    Text("${item.fabricColor}",
                        style: appTextTheme.labelSmall
                            ?.copyWith(color: Colours.blackLite)),
                  ],
                ),
                Row(
                  children: [
                    Text("No.",
                        style: appTextTheme.labelSmall
                            ?.copyWith(color: Colours.blackLite)),
                    gap(space: 5),
                    Text(item.fabricNo??"_",
                        style: appTextTheme.labelSmall
                            ?.copyWith(color: Colours.greyLight)),
                    gap(space: 5),
                  ],
                ),
                Row(
                  children: [
                    Text(Strings.box,
                        style: appTextTheme.labelSmall
                            ?.copyWith(color: Colours.blackLite)),
                    gap(space: 5),
                    Text(item.fabricBox??"_",
                        style: appTextTheme.labelSmall
                            ?.copyWith(color: Colours.greyLight)),
                    gap(space: 5),
                  ],
                ),
                Row(
                  children: [
                    Text(Strings.bal,
                        style: appTextTheme.labelSmall
                            ?.copyWith(color: Colours.blackLite)),
                    gap(space: 5),
                    Text("${item.fabricBalance ?? 0.0} kg",
                        style: appTextTheme.labelSmall
                            ?.copyWith(color: Colours.greyLight)),
                    gap(space: 5),
                  ],
                ),
                gap(space: 0),
              ],
            )
          ],
        ],
      ),
    );
  }

  Widget addButtonWidget() {
    return Obx(
      () => Visibility(
        visible: !controller.enableAdd.value,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 5, top: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: () {
                    controller.enableAdd.toggle();
                  },
                  child: DottedBorderContainer(
                      borderColor: Colours.blueDark,
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Color(0xffdae6f5),
                        // borderRadius: BorderRadius.circular(15),
                      ),
                      borderRadius: BorderRadius.circular(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: Colours.primary, size: 18),
                          gap(),
                          Text("Add",
                              style: appTextTheme.labelMedium
                                  ?.copyWith(color: Colours.primary))
                        ],
                      )),
                ),
              ),
              gap(),
              Expanded(
                  flex: 2,
                  child: SecondaryButton(
                    title: "Scan",
                    textSize: 12,
                    isBusy: controller.scanning.value,
                    trailing: displayAssetsWidget(AppIcons.scan, width: 15),
                    onTap: () {
                      var homeController =
                          getController<HomeController>(HomeController());
                      controller.scanning.value = true;
                      homeController.getScanQrCodeData().then((value) {
                        controller.scanning.value = false;
                        if (controller.hasItem(value)) {
                          errorSnackBar(message: "Duplicate item data!");
                        } else
                          controller.items.add(value);
                      }).onError((e, trace) {
                        controller.scanning.value = false;
                      });
                    },
                  )),
              gap(),
            ],
          ),
        ),
      ),
    );
  }

  Widget addNewItemTile() {
    return Obx(
      () => Visibility(
        visible: controller.enableAdd.value,
        child: Container(
          padding: AppPadding.inner,
          margin: EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
              color: Colours.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Row(
                children: [
                  /// Fabric
                  Expanded(
                      child: PrimaryFieldMenuWithLabel<FabricCategoryModel>(
                          controller: controller.fabricController,
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
                            controller.selectedFabCate =
                                item?.firstOrNull?.value;
                            controller.fabricColorController.clearItems!();
                            controller.colorBoxController.clearItems!();
                          },
                          hintText: Strings.fabric,
                          labelText: Strings.fabric)),
                  gap(space: 10),

                  /// Color
                  Expanded(
                      child: PrimaryFieldMenuWithLabel<FabricColorModel>(
                    controller: controller.fabricColorController,
                    items: [],
                    allowSearch: true,
                    fromApi: () async {
                      /// for category not selected
                      if (controller.selectedFabCate?.catId == null) {
                        throw "Select Fabric first to see data here";
                      }
                      var colors = await FabricColorModel.getColors(
                          controller.selectedFabCate!.catId!);
                      return List.generate(
                          colors.length,
                          (index) => DropDownItem(
                              id: index,
                              key: colors[index].fabricColor ?? "_",
                              title: colors[index].fabricColor ?? "_",
                              value: colors[index]));
                    },
                    onChanged: (item) {
                      controller.selectedFabColor = item?.firstOrNull?.value;
                      controller.colorBoxController.clearItems!();
                    },
                    labelText: Strings.color,
                    hintText: Strings.color,
                  )),
                ],
              ),
              gap(),

              /// Box
              Row(
                children: [
                  Expanded(
                      child: PrimaryFieldMenuWithLabel<ColorBoxesModel>(
                          items: [],
                          allowSearch: true,
                          controller: controller.colorBoxController,
                          onChanged: (item) {
                            controller.selectedFabColorBoxes =
                                item?.firstOrNull?.value;
                          },
                          fromApi: () async {
                            /// for color not selected
                            if (controller.selectedFabColor?.fabricColor ==
                                null) {
                              throw "Select Color first to see data here";
                            }
                            var items = await ColorBoxesModel.fetchBoxes(
                                controller.selectedFabCate!.catId!,
                                controller.selectedFabColor!.fabricColor!);
                            return List.generate(
                                items.length,
                                (index) => DropDownItem(
                                    id: index,
                                    key: items[index].fabricId.toString(),
                                    title: items[index].title ?? "0.0",
                                    value: items[index]));
                          },
                          hintText: Strings.box,
                          labelText: Strings.box)),
                  gap(space: 10),
                  Expanded(
                      child: Column(
                    children: [
                      gap(space: 30),
                      PrimaryButton(
                        color: Colours.greenLight,
                        leading:
                            Icon(Icons.add, color: Colours.white, size: 20),
                        title: "Add",
                        onTap: () {
                          controller.addItem();
                        },
                      ),
                    ],
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomNavBarButtons(BuildContext context) {
    /// Update material
    if (controller.isUpdate.value)
      return Container(
        // padding: EdgeInsets.only(bottom: SafeAreaBottomValue(Get.context!)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                height: 40,
                child: PrimaryButton(
                  title: Strings.deleteRQ,
                  color: Colours.redBg,
                  textColor: Colours.red,
                  onTap: () {
                    controller.deleteMaterialRQRequest(context);
                  },
                  isFullWidth: false,
                  radius: 15,
                )),
            Container(
                height: 40,
                child: PrimaryButton(
                  title: Strings.submit,
                  onTap: () {
                    controller.updateFormRequest();
                  },
                  isBusy: controller.isBusy.value,
                  isFullWidth: false,
                  radius: 15,
                )),
          ],
        ),
      );

    /// Add new
    else
      return Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              child: ClipRRect(
                  child: PrimaryButton(
                isEnable: controller.items.length != 0,
                isBusy: controller.isBusy.value,
                title: Strings.submit,
                onTap: () {
                  controller.createFormRequest();
                },
                isFullWidth: false,
                radius: 15,
              )),
            ),
          ],
        ),
      );
  }
}
