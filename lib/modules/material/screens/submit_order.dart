import 'package:jog_inventory/common/utils/dotted_border.dart';
import 'package:jog_inventory/modules/material/controllers/submit_controller.dart';
import '../../../common/exports/main_export.dart';

class SubmitOrderScreen extends GetView<SubmitController> {
  const SubmitOrderScreen({super.key});

  SubmitController get controller => SubmitController.getController();

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: "Material requisition ",
      body: body(context),
      bottomNavBar: Column(
        children: [
          PrimaryButton(title: "Submit", onTap: () {}),
        ],
      ),
    );
  }

  Widget body(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// item info
        itemInfoWidget(),
        gap(),
        tabBarView(),
        Divider(height: 2, color: Colours.border),
        Padding(
          padding: AppPadding.pagePadding,
          child: Obx(
            () => Column(
              children: [
                if (controller.isNewOrder.value) newOrderWidget(),
                if (!controller.isNewOrder.value) oldOrderWidget(),
              ],
            ),
          ),
        ),

        ///
        gap(),
        safeAreaBottom(context),
      ],
    ));
  }

  Widget itemInfoWidget() {
    return Container(
      padding: AppPadding.pagePaddingAll,
      decoration: BoxDecoration(
        color: Colours.secondary2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("VI T-FORCE",
              style: appTextTheme.titleMedium?.copyWith(color: Colours.white)),
          displayAssetsWidget(AppIcons.boxes_white, height: 25)
        ],
      ),
    );
  }

  Widget tabBarView() {
    return Obx(
      () => Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                controller.isNewOrder.value = true;
              },
              child: Container(
                padding: EdgeInsets.only(bottom: 15),
                width: Get.width / 3,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: controller.isNewOrder.value
                                ? Colours.secondary
                                : Colours.transparent,
                            width: 3))),
                child: Text(
                  "New Order",
                  style: appTextTheme.titleMedium?.copyWith(
                      color: controller.isNewOrder.value
                          ? Colours.secondary
                          : Colours.greyLight),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            gap(),
            InkWell(
              onTap: () {
                controller.isNewOrder.value = false;
              },
              child: Container(
                width: Get.width / 3,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: !controller.isNewOrder.value
                                ? Colours.secondary
                                : Colours.transparent,
                            width: 3))),
                padding: EdgeInsets.only(bottom: 15),
                child: Text(
                  "Old Order",
                  style: appTextTheme.titleMedium?.copyWith(
                      color: controller.isNewOrder.value
                          ? Colours.greyLight
                          : Colours.secondary),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget newOrderWidget() {
    return Container(
        padding: AppPadding.inner,
        width: Get.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colours.white,
            boxShadow: containerShadow()),
        child: Column(
          children: [
            gap(space: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Strings.checkOutDate,
                    style: appTextTheme.titleMedium
                        ?.copyWith(color: Colours.greyLight)),
                Text("2024-08-09 00:00:00", style: appTextTheme.titleMedium),
              ],
            ),
            gap(space: 15),
            divider(),
            gap(space: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Strings.quantityInStock,
                    style: appTextTheme.titleMedium
                        ?.copyWith(color: Colours.greyLight)),
                Text("5997", style: appTextTheme.titleMedium),
              ],
            ),
            gap(space: 15),
            divider(),
            gap(space: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Strings.quantityRequired,
                    style: appTextTheme.titleMedium
                        ?.copyWith(color: Colours.greyLight)),
                SizedBox(
                    width: 100,
                    child: PrimaryTextField(radius: 10, height: 40)),
              ],
            ),
            gap(space: 15),
            ...commentField(),
            gap(space: 15),
          ],
        ));
  }

  List<Widget> commentField() {
    return [
      DottedLineDivider(
        dotSpace: 3,
        color: Colours.greyLight,
      ),
      gap(space: 15),
      PrimaryTextField(maxLines: 3, hintText: "Enter Comments")
    ];
  }

  Widget oldOrderWidget() {
    return Container(
        padding: AppPadding.inner,
        width: Get.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colours.white,
            boxShadow: containerShadow()),
        child: Column(
          children: [
            gap(space: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Strings.qtdRequested,
                    style: appTextTheme.titleMedium
                        ?.copyWith(color: Colours.greyLight)),
                Text("123", style: appTextTheme.titleMedium),
              ],
            ),
            gap(space: 15),
            divider(),
            gap(space: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Strings.previousCheckQtd,
                    style: appTextTheme.titleMedium
                        ?.copyWith(color: Colours.greyLight)),
                Text("123", style: appTextTheme.titleMedium),
              ],
            ),
            gap(space: 15),
            divider(),
            gap(space: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Strings.previousCheckDate,
                    style: appTextTheme.titleMedium
                        ?.copyWith(color: Colours.greyLight)),
                Text("14/12/12", style: appTextTheme.titleMedium),
              ],
            ),
            gap(space: 15),
            divider(),
            gap(space: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Strings.dueDateReq,
                    style: appTextTheme.titleMedium
                        ?.copyWith(color: Colours.greyLight)),
                Text("14/12/12", style: appTextTheme.titleMedium),
              ],
            ),
            gap(space: 15),
            divider(),
            gap(space: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Strings.dueDateForShipping,
                    style: appTextTheme.titleMedium
                        ?.copyWith(color: Colours.greyLight)),
                Text("14/12/12", style: appTextTheme.titleMedium),
              ],
            ),
            gap(space: 15),
            divider(),
            gap(space: 15),
            TextFieldWithLabel(
                labelText: Strings.reasonForReRequest,
                maxLines: 3,
                minLines: 1),
            gap(space: 15),
            divider(),
            gap(space: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Strings.quantityInStock,
                    style: appTextTheme.titleMedium
                        ?.copyWith(color: Colours.greyLight)),
                Text("5997", style: appTextTheme.titleMedium),
              ],
            ),
            gap(space: 15),
            divider(),
            gap(space: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Strings.quantityRequired,
                    style: appTextTheme.titleMedium
                        ?.copyWith(color: Colours.greyLight)),
                SizedBox(
                    width: 100,
                    child: PrimaryTextField(radius: 10, height: 40)),
              ],
            ),
            gap(space: 15),
            ...commentField(),
            gap(space: 15),
          ],
        ));
  }
}
