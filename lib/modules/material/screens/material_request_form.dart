import 'dart:ffi';

import 'package:jog_inventory/common/utils/dotted_border.dart';
import 'package:jog_inventory/modules/material/controllers/material_request_form.dart';
import 'package:jog_inventory/modules/material/widgets/order_codes_remove.dart';
import '../../../common/exports/main_export.dart';

class MaterialRequestFormScreen extends GetView<MaterialRequestFormController> {
  const MaterialRequestFormScreen({super.key});

  MaterialRequestFormController get controller =>
      MaterialRequestFormController.getController();

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
        title: "Material requisition form",
        body: bodyWidget(),
        bottomNavBar: bottomNavBarButtons());
  }

  Widget bodyWidget() {
    return SingleChildScrollView(
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

          /// Items
          itemTileWidget(),
          gap(),
          itemTileWidget(),
          gap(),
          itemTileWidget(),
          gap(),
          itemTileWidget(),
          gap(),
          itemTileWidget(),
          gap(),
          gap(),
          addButtonWidget(),
          gap(),
          dottedDivider(),
          gap(),
          addNewItemTile(),

          ///
          gap(),
          safeAreaBottom(Get.context!),
        ],
      ),
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
                  Text("  2024-08-08 18:58:45",
                      style: appTextTheme.labelSmall?.copyWith(fontSize: 14)),
                ],
              ),
            ),
            TextBorderButton(
                onTap: () {
                  openOrderCodePopup(Get.context!);
                },
                title: "Order Code",
                color: Colours.primary,
                borderColor: Colours.primary)
          ],
        ),
        gap(),
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
                      child: CustomDropDownWithLabel(
                          items: [],
                          onChanged: (value) {},
                          labelText: Strings.orderCode,
                          hintText: "Select " + Strings.orderCode),
                    ),
                    gap(space: 10),
                    Obx(
                      () => Visibility(
                        visible: controller.isAddonYear.value,
                        child: Expanded(
                          child: CustomDropDownWithLabel(
                              items: [],
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
                          onTap: () {
                            controller.isAddonYear.toggle();
                          },
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
              Text("New",
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
                  style:
                      appTextTheme.labelMedium?.copyWith(color: Colours.white)),
              gap(),
              Text("EX-5227A",
                  style:
                      appTextTheme.labelSmall?.copyWith(color: Colours.white)),
              Expanded(child: SizedBox()),
              Text(Strings.date,
                  style:
                      appTextTheme.labelMedium?.copyWith(color: Colours.white)),
              gap(),
              Text("24-08-06",
                  style:
                      appTextTheme.labelSmall?.copyWith(color: Colours.white)),
            ],
          )
        ],
      ),
    );
  }

  Widget itemTileWidget() {
    return Container(
      padding: AppPadding.inner,
      decoration:
          BoxDecoration(color: Colours.white, boxShadow: containerShadow()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("10",
                  style: appTextTheme.labelSmall
                      ?.copyWith(color: Colours.greyLight)),
              gap(space: 10),
              Text("AK PRO MAX LIGHT ,",
                  style: appTextTheme.labelSmall
                      ?.copyWith(color: Colours.primaryText)),
              gap(space: 10),
              Text("Michigan Maize",
                  style: appTextTheme.labelSmall
                      ?.copyWith(color: Colours.greyLight)),
              Expanded(child: SizedBox()),
              Icon(
                Icons.delete_outlined,
                size: 20,
                color: Colours.red,
              )
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
              Text("15",
                  style: appTextTheme.labelSmall
                      ?.copyWith(color: Colours.blackLite)),
              Expanded(child: SizedBox()),
              Text(Strings.bal,
                  style: appTextTheme.labelSmall
                      ?.copyWith(color: Colours.greyLight)),
              gap(space: 10),
              Text("10.00 kg",
                  style: appTextTheme.labelSmall
                      ?.copyWith(color: Colours.blackLite)),
              gap(space: 50),
            ],
          ),
        ],
      ),
    );
  }

  Widget addButtonWidget() {
    return DottedBorderContainer(
        borderColor: Colours.blueDark,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Color(0xffdae6f5),
          // borderRadius: BorderRadius.circular(15),
        ),
        borderRadius: BorderRadius.circular(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Colours.primary, size: 18),
            gap(),
            Text("Add",
                style:
                    appTextTheme.labelMedium?.copyWith(color: Colours.primary))
          ],
        ));
  }

  Widget addNewItemTile() {
    return Container(
      padding: AppPadding.inner,
      decoration: BoxDecoration(
          color: Colours.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: CustomDropDownWithLabel(
                      items: [],
                      onChanged: (item) {},
                      hintText: Strings.fabric,
                      labelText: Strings.fabric)),
              gap(space: 30),
              Expanded(
                  child: CustomDropDownWithLabel(
                items: [],
                onChanged: (item) {},
                labelText: Strings.color,
                hintText: Strings.color,
              )),
            ],
          ),
          gap(),
          Row(
            children: [
              Expanded(
                  child: CustomDropDownWithLabel(
                      items: [],
                      onChanged: (item) {},
                      hintText: Strings.box,
                      labelText: Strings.box)),
              gap(space: 30),
              Expanded(
                  child: Column(
                children: [
                  gap(space: 30),
                  PrimaryButton(
                    color: Colours.greenLight,
                    leading: Icon(Icons.add, color: Colours.white, size: 20),
                    title: "Add",
                    onTap: () {},
                  ),
                ],
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget bottomNavBarButtons() {
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
                  onTap: () {},
                  isFullWidth: false,
                  radius: 15,
                )),
            Container(
                height: 40,
                child: PrimaryButton(
                  title: Strings.submit,
                  onTap: () {},
                  isFullWidth: false,
                  radius: 15,
                )),
          ],
        ),
      );

    /// Add new
    else
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50,
            child: ClipRRect(
                child: PrimaryButton(
              title: Strings.submit,
              onTap: () {},
              isFullWidth: false,
              radius: 15,
            )),
          ),
        ],
      );
  }
}
