import 'package:jog_inventory/common/utils/date_formater.dart';
import 'package:jog_inventory/common/utils/menu.dart';
import 'package:jog_inventory/modules/no_code/controllers/no_code_list.dart';
import 'package:jog_inventory/modules/no_code/models/no_code_item.dart';
import 'package:jog_inventory/modules/no_code/widgits/summary_popup.dart';

import '../../../common/exports/main_export.dart';

class NoCodeRqListScreen extends StatefulWidget {
  const NoCodeRqListScreen({super.key});

  @override
  State<NoCodeRqListScreen> createState() => _NoCodeRqListScreenState();
}

class _NoCodeRqListScreenState extends State<NoCodeRqListScreen> {
  NoCodeListRequestController controller =
      getController<NoCodeListRequestController>(NoCodeListRequestController());

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(title: Strings.noCodeRqList, body: body);
  }

  Widget body(BuildContext context) {
    return SingleChildScrollView(
        padding: AppPadding.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// search
            gap(),
            searchWidget(),
            gap(),

            /// filters
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
                  children: displayItems(),
                ),
              ),
            ),

            ///
            gap(),
            safeAreaBottom(Get.context!),
          ],
        ));
  }

  Widget searchWidget() {
    return PrimaryTextField(
        allowShadow: true,
        radius: 10,
        hintText: "Search",
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Icon(
            Icons.search,
            color: Colours.greyLight,
            size: 25,
          ),
        ),
        onChanged: (value) {
          controller.getItems(1, search: value);
        });
  }

  Widget summeryAndPage() {
    return Obx(
      () => shimmerEffects(
        isLoading: controller.isLoading.value,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextBorderButton(
                onTap: () {
                  openNoCodeSummaryBottomSheet();
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
                          controller.pagination?.totalPages ?? 0,
                          (index) => MenuItem(
                              title: '${index + 1}',
                              onTap: (value) {
                                controller.getItems(index + 1);
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
                              "${controller.pagination?.currentPage ?? 1}",
                              style: appTextTheme.titleSmall?.copyWith(
                                  color: Colours.blackLite,
                                  fontWeight: FontWeight.w700))),
                    )),
                Gap(10),
                Text("of ${controller.pagination?.totalPages ?? 1}",
                    style: appTextTheme.titleSmall?.copyWith(
                        color: Colours.blackLite, fontWeight: FontWeight.w700)),
              ],
            )
          ],
        ),
      ),
    );
  }

  List<Widget> displayItems() {
    return displayList<NoCodeRQItemModel>(
      showGap: true,
      items: controller.items,
      builder: (item, index) {
        return itemTileWidget(item, index);
      },
    );
  }

  Widget itemTileWidget(NoCodeRQItemModel item, int index) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutesString.noCodeRequestDetail, arguments: {
          appKeys.usedItem: item,
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${index + 1}",
                      style: appTextTheme.titleSmall
                          ?.copyWith(color: Colours.blackLite),
                    ),
                    gap(),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text((item.usedCode ?? "_").trim(),
                              style: appTextTheme.titleSmall?.copyWith()),
                          gap(space: 10),
                          Text((item.usedOrderCode ?? "_").trim(),
                              style: appTextTheme.titleSmall?.copyWith()),
                        ],
                      ),
                    ),
                    // Expanded(child: SizedBox()),
                    chipWidget(
                      appDateTimeFormat.toYYMMDDHHMMSS(date: item.usedDate),
                    )
                  ],
                ),
              ),
              divider(),
              // gap(space: 10),

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
                          Text("Note",
                              style: appTextTheme.titleSmall
                                  ?.copyWith(color: Colours.greyLight)),
                          gap(space: 10),
                          Text(
                            "${item.noOrderNote ?? 0}",
                            style: appTextTheme.titleSmall?.copyWith(),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    verticalDivider(),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(Strings.total,
                              style: appTextTheme.titleSmall
                                  ?.copyWith(color: Colours.greyLight)),
                          gap(space: 10),
                          Text(
                            formatNumber("${item.usedTotal ?? 0}"),
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
            ],
          )),
    );
  }
}
