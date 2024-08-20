import 'package:jog_inventory/common/utils/bottom_sheet.dart';
import 'package:jog_inventory/common/utils/menu.dart';
import 'package:jog_inventory/modules/material/controllers/material_request_list.dart';
import 'package:jog_inventory/modules/material/widgets/search_filter.dart';
import 'package:jog_inventory/modules/material/widgets/summary_popup.dart';
import '../../../common/exports/main_export.dart';

class MaterialRequestListScreen extends GetView<MaterialRequestListController> {
  const MaterialRequestListScreen({super.key});

  MaterialRequestListController get controller => MaterialRequestListController.getController();

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(title: Strings.materialRequestList, body: body());
  }

  Widget body() {
    return SingleChildScrollView(
        padding: AppPadding.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// tab bar
            tabBarView(),
            divider(),

            /// search
            gap(),
            searchWidget(),
            gap(),

            /// filters
            summeryAndPage(),
            gap(),

            /// items
            itemTileWidget(),
            gap(),
            itemTileWidget(),

            ///
            gap(),
            safeAreaBottom(Get.context!),
          ],
        ));
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
                controller.isProducing.value = true;
              },
              child: Container(
                padding: EdgeInsets.only(bottom: 15),
                width: Get.width / 3,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: controller.isProducing.value
                                ? Colours.secondary
                                : Colours.transparent,
                            width: 3))),
                child: Text(
                  "New Order",
                  style: appTextTheme.titleMedium?.copyWith(
                      color: controller.isProducing.value
                          ? Colours.secondary
                          : Colours.greyLight),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            gap(),
            InkWell(
              onTap: () {
                controller.isProducing.value = false;
              },
              child: Container(
                width: Get.width / 3,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: !controller.isProducing.value
                                ? Colours.secondary
                                : Colours.transparent,
                            width: 3))),
                padding: EdgeInsets.only(bottom: 15),
                child: Text(
                  "Old Order",
                  style: appTextTheme.titleMedium?.copyWith(
                      color: controller.isProducing.value
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

  Widget searchWidget() {
    return InkWell(
      onTap: () {
        showAppBottomSheet(Get.context!, FilterMaterialList());
      },
      child: IgnorePointer(
        ignoring: true,
        child: PrimaryTextField(
          allowShadow: true,
          radius: 10,
          hintText: "Search",
          prefixIcon: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Icon(
                Icons.search,
                color: Colours.greyLight,
                size: 25,
              )),
        ),
      ),
    );
  }

  Widget summeryAndPage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButtonBorderWidget(
            onTap: () {
              showAppBottomSheet(Get.context!, ViewSummaryBodyScreen());
            },
            title: Strings.viewSummary,
            color: Colours.primary,
            borderColor: Colours.primary),

        /// Page Count
        Row(
          children: [
            Text("Page",
                style: appTextTheme.titleSmall?.copyWith(
                    color: Colours.blackLite, fontWeight: FontWeight.w700)),
            Gap(10),
            popupMenu(Get.context!,
                items: [
                  ...List.generate(
                      10,
                      (index) => MenuItem(
                          title: '${index + 1}',
                          onTap: (value) {
                            ///
                          },
                          id: index,
                          key: "$index"))
                ],
                menuIcon: Container(
                  height: 40,
                  width: 70,
                  decoration: BoxDecoration(
                      color: Colours.white,
                      border: Border.all(color: Colours.border),
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                      child: Text("${0}",
                          style: appTextTheme.titleSmall?.copyWith(
                              color: Colours.blackLite,
                              fontWeight: FontWeight.w700))),
                )),
            Gap(10),
            Text("of ${10}",
                style: appTextTheme.titleSmall?.copyWith(
                    color: Colours.blackLite, fontWeight: FontWeight.w700)),
          ],
        )
      ],
    );
  }

  Widget itemTileWidget() {
    return Container(
        decoration: BoxDecoration(
          color: Colours.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: AppPadding.inner,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "1",
                    style: appTextTheme.titleSmall
                        ?.copyWith(color: Colours.blackLite),
                  ),
                  gap(),
                  Text("EX21-1396A",
                      style: appTextTheme.titleSmall?.copyWith()),
                  Expanded(child: SizedBox()),
                  chipWidget(
                    "2024-08-06 12:58",
                  )
                ],
              ),
            ),
            divider(),
            gap(),

            /// info
            Padding(
              padding: AppPadding.inner,
              child: Row(
                children: [
                  gap(space: 30),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Items",
                            style: appTextTheme.titleSmall
                                ?.copyWith(color: Colours.greyLight)),
                        gap(space: 10),
                        Text(
                          "2",
                          style: appTextTheme.titleSmall?.copyWith(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("User",
                            style: appTextTheme.titleSmall
                                ?.copyWith(color: Colours.greyLight)),
                        gap(space: 10),
                        Text(
                          "Mirza Ravish Beg",
                          style: appTextTheme.titleSmall?.copyWith(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Status",
                            style: appTextTheme.titleSmall
                                ?.copyWith(color: Colours.greyLight)),
                        gap(space: 10),
                        Text(
                          "NEW",
                          style: appTextTheme.titleSmall
                              ?.copyWith(color: Colours.greenLight),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            gap(space: 10),
            divider(),
            gap(space: 10),

            /// buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PrimaryButton(
                    title: "View / Edit",
                    onTap: () {},
                    isFullWidth: false,
                    padding:
                        EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                    radius: 10),
                gap(space: 15),
                PrimaryButton(
                    color: Colours.greenLight,
                    title: "Finish",
                    onTap: () {},
                    isFullWidth: false,
                    padding:
                        EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
                    radius: 10)
              ],
            ),

            gap(space: 10)
          ],
        ));
  }
}