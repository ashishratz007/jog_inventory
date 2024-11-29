import 'package:jog_inventory/common/constant/enums.dart';
import 'package:jog_inventory/common/utils/date_formater.dart';
import 'package:jog_inventory/common/utils/dotted_border.dart';
import 'package:jog_inventory/common/utils/validation.dart';
import 'package:jog_inventory/modules/material/controllers/submit_controller.dart';
import 'package:jog_inventory/services/tab_view_navigator.dart';
import '../../../common/exports/main_export.dart';

class SubmitOrderScreen extends StatefulWidget {
  const SubmitOrderScreen({super.key});

  @override
  State<SubmitOrderScreen> createState() => _SubmitOrderScreenState();
}

class _SubmitOrderScreenState extends State<SubmitOrderScreen> {
  SubmitController get controller => SubmitController.getController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Form(
        key: controller.formKey,
        child: Obx(
          () => shimmerEffects(
              isLoading: controller.isLoading.value, child: body(context)),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => PrimaryButton(title: "Submit", onTap: controller.submitRequest, isBusy: controller.isBusy.value)),
          ],
        ),
      ),
    );
  }

  PreferredSize appBar() {
    return PreferredSize(
      preferredSize: Size(Get.width, 70),
      child: Container(
        padding: EdgeInsets.only(
            left: 10, right: 10, top: SafeAreaTopValue(context) > 0?(SafeAreaTopValue(context) - 10):0),
        height: 70 + SafeAreaTopValue(context), // safe area
        decoration: BoxDecoration(
            color: Colours.secondary,
            // borderRadius: BorderRadius.only(
            //   bottomLeft: Radius.circular(30),
            //   bottomRight: Radius.circular(30),
            // ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(
                    2, 3), // This controls the vertical position of the shadow
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {
                  mainNavigationService.pop();
                },
                child: Icon(Icons.arrow_back, color: Colors.white, size: 28),
              ),
            ),
            Text("Material Requisition",
                style: appTextTheme.titleLarge?.copyWith(color: Colours.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
            SizedBox(
              width: 40,
            )
          ],
        ),
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
        SafeAreaBottom(context),
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
    return IgnorePointer(
      ignoring: true,
      child: Obx(
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
                Text(dateTimeFormat.toYYMMDDHHMMSS(),
                    style: appTextTheme.titleMedium),
              ],
            ),
            gap(space: 15),
            divider(),
            gap(space: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Strings.quantityInStock+"(${FabricMaterialType.getTitle(
                    controller.scanDetailsModal.data?.fabric?.fabricTypeUnit ??
                        1)})",
                    style: appTextTheme.titleMedium
                        ?.copyWith(color: Colours.greyLight)),
                Text(
                    "${controller.scanDetailsModal.data?.fabric?.fabricBalance ?? 0.0}",
                    style: appTextTheme.titleMedium),
              ],
            ),
            gap(space: 15),
            divider(),
            gap(space: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Strings.quantityRequired,
                    style: appTextTheme.titleMedium
                        ?.copyWith(color: Colours.greyLight)),
                SizedBox(
                    width: 100,
                    child: PrimaryTextField(
                      controller: controller.qtyController,
                      radius: 10,
                      hintText: "Kg",
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 0, bottom: 0),
                      inputFormatters: [amountFormatter()],
                      keyboardType: TextInputType.number,
                      // autovalidateMode: AutovalidateMode.always,
                      validator: (String? val) {
                        if (val == null || ((val ?? "").trim() == ""))
                          return validation.validateEmptyField(val);
                        if (!compareBalance(
                            val,
                            controller.scanDetailsModal.data?.fabric
                                ?.fabricBalance)) {
                          var message =
                              "Value must be less than or equal to balance.";
                          errorSnackBar(message: message);
                          return message;
                        }
                        return null;
                      },
                    )),
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
      PrimaryTextField(
          maxLines: 3,
          hintText: "Enter Comments",
          controller: controller.commentController,
          onChanged: (value) {})
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
            /// TODO
            // gap(space: 15),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(Strings.qtdRequested,
            //         style: appTextTheme.titleMedium
            //             ?.copyWith(color: Colours.greyLight)),
            //     Text("123", style: appTextTheme.titleMedium),
            //   ],
            // ),
            // gap(space: 15),
            // divider(),
            gap(space: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Strings.previousCheckQtd,
                    style: appTextTheme.titleMedium
                        ?.copyWith(color: Colours.greyLight)),
                Text("${controller.oldItem?.balanceAfter ?? 0.0}",
                    style: appTextTheme.titleMedium),
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
                Text(
                    dateTimeFormat.toYYMMDDHHMMSS(
                        removeTime: true,
                        date: controller.materialRqDetail.updatedAt),
                    style: appTextTheme.titleMedium),
              ],
            ),

            /// TODO:
            // gap(space: 15),
            // divider(),
            // gap(space: 15),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(Strings.dueDateReq,
            //         style: appTextTheme.titleMedium
            //             ?.copyWith(color: Colours.greyLight)),
            //     Text(appDateTimeFormat.toYYMMDDHHMMSS(removeTime: true,date: controller.scanDetailsModal.data.fabric), style: appTextTheme.titleMedium),
            //   ],
            // ),
            // gap(space: 15),
            // divider(),
            // gap(space: 15),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(Strings.dueDateForShipping,
            //         style: appTextTheme.titleMedium
            //             ?.copyWith(color: Colours.greyLight)),
            //     Text("14/12/12", style: appTextTheme.titleMedium),
            //   ],
            // ),
            gap(space: 15),
            divider(),
            gap(space: 15),
            TextFieldWithLabel(
                controller: controller.reRequestController,
                labelText: Strings.reasonForReRequest,
                maxLines: 3,
                minLines: 1),
            gap(space: 15),
            divider(),
            gap(space: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Strings.quantityInStock+"(${FabricMaterialType.getTitle(
                    controller.scanDetailsModal.data?.fabric?.fabricTypeUnit ??
                        1)})",
                    style: appTextTheme.titleMedium
                        ?.copyWith(color: Colours.greyLight)),
                Text(
                    "${controller.scanDetailsModal.data?.fabric?.fabricBalance ?? 0.0}",
                    style: appTextTheme.titleMedium),
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
                    child: PrimaryTextField(
                      controller: controller.qtyController,
                      radius: 10,
                      keyboardType: TextInputType.number,
                      // autovalidateMode: AutovalidateMode.always,
                      validator: (String? val) {
                        if (val == null || ((val ?? "").trim() == ""))
                          return validation.validateEmptyField(val);
                        if (!compareBalance(
                            val,
                            controller.scanDetailsModal.data?.fabric
                                ?.fabricBalance)) {
                          var message =
                              "Value must be less than or equal to balance.";
                          errorSnackBar(message: message);
                          return message;
                        }
                        return null;
                      },
                    )),
              ],
            ),
            gap(space: 15),
            ...commentField(),
            gap(space: 15),
          ],
        ));
  }
}
