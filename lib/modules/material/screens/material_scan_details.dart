import 'package:jog_inventory/modules/material/controllers/scan_qr.dart';
import 'package:jog_inventory/modules/material/widgets/select_jog_code_popup.dart';
import '../../../common/exports/main_export.dart';

class MaterialRequestDetailScreen
    extends GetView<MaterialScanDetailsController> {
  const MaterialRequestDetailScreen({super.key});

  MaterialScanDetailsController get controller =>
      MaterialScanDetailsController.getController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MaterialScanDetailsController>(
        init: controller,
        builder: (context) {
          return CustomAppBar(
              title: "Material requisition",
              body: SingleChildScrollView(
                padding: AppPadding.pagePadding,
                child: bodyWidget(),
              ));
        });
  }

  Widget bodyWidget() {
    return Column(
      children: [
        displayMaterialDetails(),
        gap(),
        displaySearchWidget(),
        gap(),
        safeAreaBottom(Get.context)
      ],
    );
  }

  Widget displayMaterialDetails() {
    var radius = 10.0;
    return Container(
        decoration: BoxDecoration(
          color: Colours.white,
          boxShadow: containerShadow(),
          border: Border.all(color: Colours.border),
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Column(
          children: [
            Container(
              padding: AppPadding.inner,
              decoration: BoxDecoration(
                  color: Colours.blackMat,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(radius),
                    topLeft: Radius.circular(radius),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller
                            .scanDetailsModal?.data?.fabric?.catId?.catNameEn ??
                        "_",
                    style: appTextTheme.titleMedium
                        ?.copyWith(color: Colours.white),
                  ),
                  displayAssetsWidget(AppIcons.boxes_white, height: 30),
                ],
              ),
            ),
            gap(space: 10),
            displayDataTiles(
                'Received Date',
                controller.scanDetailsModal?.data?.fabric?.fabricDateCreate ??
                    "_"),
            Divider(
              color: Colours.bgGrey,
            ),
            displayDataTiles(
                'Quantity',
                controller.scanDetailsModal?.data?.fabric?.fabricInTotal
                        ?.toString() ??
                    "_"),
            Divider(
              color: Colours.bgGrey,
            ),
            displayDataTiles('Roll Number',
                controller.scanDetailsModal?.data?.fabric?.fabricNo ?? "_"),
            Divider(
              color: Colours.bgGrey,
            ),
            displayDataTiles('Material Type', '_'),
            Divider(
              color: Colours.bgGrey,
            ),
            displayDataTiles('Color',
                controller.scanDetailsModal?.data?.fabric?.fabricColor ?? "_"),
            Divider(
              color: Colours.bgGrey,
            ),
            displayDataTiles(
                'Vendor Name',
                controller.scanDetailsModal?.data?.fabric?.supplierId
                        ?.supplierName ??
                    "_"),
            Divider(
              color: Colours.bgGrey,
            ),
            displayDataTiles('Warehouse Location',
                controller.scanDetailsModal?.data?.fabric?.fabricBox ?? "_"),
            gap(space: 10)
          ],
        ));
  }

  Widget displaySearchWidget() {
    return TextFieldWithLabel(
      allowShadow: true,
      labelText: 'Search for JOG Code',
      radius: 10,
      hintText: "Search",
      onTap: () {
        showSelectCodeMenu(Get.context!);
      },
      prefixIcon: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Icon(
            Icons.search,
            color: Colours.greyLight,
            size: 25,
          )),
    );
  }

  Widget displayDataTiles(String title, String value) {
    return Obx(
      () => shimmerEffects(
        isLoading: controller.isLoading.value,
        child: Container(
          padding: AppPadding.inner,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style:
                    appTextTheme.titleSmall?.copyWith(color: Colours.greyLight),
              ),
              Text(
                value,
                style: appTextTheme.titleSmall?.copyWith(color: Colours.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
