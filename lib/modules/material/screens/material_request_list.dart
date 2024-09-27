import 'package:jog_inventory/common/animations/sliding%20container.dart';
import 'package:jog_inventory/common/constant/images.dart';
import 'package:jog_inventory/common/utils/bottom_seet.dart';
import 'package:jog_inventory/common/utils/menu.dart';
import 'package:jog_inventory/common/widgets/imageview.dart';
import 'package:jog_inventory/modules/material/controllers/material_request_list.dart';
import 'package:jog_inventory/modules/material/models/material_request.dart';
import 'package:jog_inventory/modules/material/widgets/search_filter.dart';
import 'package:jog_inventory/modules/material/widgets/summary_popup.dart';
import '../../../common/exports/main_export.dart';
import '../../../common/utils/date_formater.dart';

class MaterialRequestListScreen extends GetView<MaterialRequestListController> {
  const MaterialRequestListScreen({super.key});

  MaterialRequestListController get controller =>
      MaterialRequestListController.getController();

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(title: Strings.materialRequestList, body: body);
  }

  Widget body(BuildContext context) {
    return SingleChildScrollView(
        padding: AppPadding.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// tab bar
            tabBarView(),
            divider(),

            /// search TODO
            gap(),
            searchWidget(),
            gap(),

            /// filters TODO
            summeryAndPage(),
            gap(),

            /// loading
            Obx(
              () => Visibility(
                visible: controller.isLoading.value,
                child: listLoadingEffect(),
              ),
            ),

            /// items
            Obx(
              () => Visibility(
                visible: !controller.isLoading.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: !controller.isProducing.value
                      ? displayFinishedItems()
                      : displayProductionItems(),
                ),
              ),
            ),

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
                controller.changeTabs(false);
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
                  Strings.producing,
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
                controller.changeTabs(true);
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
                  Strings.finished,
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
    return PrimaryTextField(
      radius: 10,
      onChanged: (value) {
        controller.getDataList(
            isFinished: !controller.isProducing.value, clearData: true);
      },
      hintText: "Search",
      prefixIcon: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Icon(
            Icons.search,
            color: Colours.greyLight,
            size: 25,
          )),
    );
  }

  Widget summeryAndPage() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextBorderButton(
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
                        controller.isProducing.value
                            ? controller.producing?.totalPages ?? 0
                            : controller.finishedList?.totalPages ?? 0,
                        (index) => MenuItem(
                            title: '${index + 1}',
                            onTap: (value) {
                              controller.filterByPage(index + 1);
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
                        child: Text(
                            "${controller.isProducing.value ? controller.producingPage : controller.finishPage}",
                            style: appTextTheme.titleSmall?.copyWith(
                                color: Colours.blackLite,
                                fontWeight: FontWeight.w700))),
                  )),
              Gap(10),
              Text(
                  "of ${controller.isProducing.value ? controller.producing?.totalPages ?? 0 : controller.finishedList?.totalPages ?? 0}",
                  style: appTextTheme.titleSmall?.copyWith(
                      color: Colours.blackLite, fontWeight: FontWeight.w700)),
            ],
          )
        ],
      ),
    );
  }

  List<Widget> displayProductionItems() {
    return displayList<MaterialRequestModel>(
      showGap: true,
      items: controller.producing?.items,
      builder: (item, index) {
        return producingItemTileWidget(item, index);
      },
    );
  }

  List<Widget> displayFinishedItems() {
    return displayList<MaterialRequestModel>(
      items: controller.finishedList?.items,
      showGap: true,
      builder: (item, index) {
        return finishedItemTileWidget(item, index);
      },
    );
  }

  Widget producingItemTileWidget(MaterialRequestModel item, int index) {
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
                    "${index + 1}",
                    style: appTextTheme.titleSmall
                        ?.copyWith(color: Colours.blackLite),
                  ),
                  gap(),
                  Text(item.orderCode ?? "_",
                      style: appTextTheme.titleSmall?.copyWith()),
                  Expanded(child: SizedBox()),
                  chipWidget(
                    dateTimeFormat.toYYMMDDHHMMSS(date: item.rqDate),
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
                          "${item.itemNum ?? 0}",
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
                          item.employeeName ?? "_",
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
                          item.rqStatus ?? "_",
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
                    onTap: () {
                      Get.toNamed(AppRoutesString.materialRequestForm,
                          arguments: {
                            appKeys.materialRQId: item.rqId,
                            appKeys.materialRQDetail: item,
                          });
                    },
                    isFullWidth: false,
                    padding:
                        EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                    radius: 10),
                gap(space: 15),
                PrimaryButton(
                    color: Colours.greenLight,
                    title: Strings.finish,
                    onTap: () async {
                      var data = await Get.toNamed(
                          AppRoutesString.materialRQFinish,
                          arguments: {
                            appKeys.materialRQId: item.rqId,
                            appKeys.materialRQDetail: item,
                          });
                      if (data == true) {
                        controller.finishedList?.clear();
                        controller.changeTabs(true);
                      }
                    },
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

  Widget finishedItemTileWidget(MaterialRequestModel item, int index) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutesString.materialRQFinishDetail, arguments: {
          appKeys.materialRQId: item.rqId,
          appKeys.materialRQDetail: item,
        });
      },
      child: Container(
          decoration: BoxDecoration(
            color: Colours.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: AppPadding.inner,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${index + 1}",
                          style: appTextTheme.titleSmall
                              ?.copyWith(color: Colours.blackLite),
                        ),
                        gap(),
                        Text(item.orderCode ?? "_",
                            style: appTextTheme.titleSmall?.copyWith()),
                      ],
                    ),
                    gap(space: 10),
                    Row(
                      children: [
                        chipWidget(
                            dateTimeFormat.toYYMMDDHHMMSS(date: item.rqDate),
                            fontSize: 12),
                        gap(space: 5),
                        Icon(
                          Icons.arrow_forward,
                          color: Colours.greyLight,
                          size: 18,
                        ),
                        gap(space: 5),
                        chipWidget(
                            dateTimeFormat.toYYMMDDHHMMSS(
                                date: item.finishDate),
                            color: Colours.redBg,
                            textColor: Colours.red,
                            fontSize: 12),
                      ],
                    ),
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
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Items",
                              style: appTextTheme.titleSmall
                                  ?.copyWith(color: Colours.greyLight)),
                          gap(space: 10),
                          Text(
                            "${item.itemNum ?? 0}",
                            style: appTextTheme.titleSmall?.copyWith(),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    verticalDivider(),
                    Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(Strings.used + "(kg)",
                                  style: appTextTheme.titleSmall
                                      ?.copyWith(color: Colours.greyLight)),
                              gap(space: 10),
                              Text(
                                "${item.gUsed}",
                                style: appTextTheme.titleSmall?.copyWith(),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )),
                    verticalDivider(),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(Strings.total,
                              style: appTextTheme.titleSmall
                                  ?.copyWith(color: Colours.greyLight)),
                          gap(space: 10),
                          Text(
                            "${formatDecimal(item.gTotal ?? "_")}",
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
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 10, bottom: 0),
                    child: Row(
                      children: [
                        gap(space: 30),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Add on",
                                  style: appTextTheme.titleSmall
                                      ?.copyWith(color: Colours.greyLight)),
                              gap(space: 10),
                              Text(
                                "${item.addonNum ?? 0}",
                                style: appTextTheme.titleSmall?.copyWith(),
                                textAlign: TextAlign.center,
                              ),
                              gap()
                            ],
                          ),
                        ),
                        verticalDivider(),
                        // gap(space: 10),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("User",
                                    style: appTextTheme.titleSmall
                                        ?.copyWith(color: Colours.greyLight)),
                                gap(space: 10),
                                Text(
                                  item.employeeName ?? "_",
                                  style: appTextTheme.titleSmall?.copyWith(),
                                  textAlign: TextAlign.center,
                                ),
                                gap()
                              ],
                            ),
                          ),
                        ),
                        Expanded(flex: 1, child: SizedBox())
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 50,
                      width: 60,
                      decoration: BoxDecoration(
                          color: Colours.primaryBlueBg,
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(15))),
                      child: Center(
                          child: Icon(
                        Icons.arrow_forward,
                        color: Colours.blueDark,
                      )),
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
