import 'package:jog_inventory/common/utils/date_formater.dart';
import 'package:jog_inventory/modules/no_code/models/no_code_item.dart';
import 'package:jog_inventory/modules/stock_in/controllers/list.dart';
import 'package:jog_inventory/modules/stock_in/widgets/edit_popup.dart';

import '../../../common/exports/main_export.dart';

class StockInListPage extends StatefulWidget {
  const StockInListPage({super.key});

  @override
  State<StockInListPage> createState() => _StockInListPageState();
}

class _StockInListPageState extends State<StockInListPage> {
  StockInListController controller =
      getController<StockInListController>(StockInListController());

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(title: "Stock In List", body: body);
  }

  Widget body(BuildContext context) {
    return SingleChildScrollView(
        padding: AppPadding.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gap(),

            /// filters
            summeryAndPage(),
            gap(),

            /// search

            searchWidget(),
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

  Widget listLoadingEffect({int count = 5, double height = 45}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(
            count,
            (index) => Container(
                  margin: EdgeInsets.only(top: 20),
                  child: shimmerEffects(
                    isLoading: true,
                    child: Container(
                      height: height,
                      width: Get.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7)),
                    ),
                  ),
                ))
      ],
    );
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
                  editStockInItemPopup(Get.context!);
                  // TODo
                  // openNoCodeSummaryBottomSheet();
                },
                title: Strings.viewSummary,
                color: Colours.primary,
                borderColor: Colours.primary),

            /// calender
            //TODO
          ],
        ),
      ),
    );
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
          // TODO
        });
  }

  List<Widget> displayItems() {
    return displayList<NoCodeRQItemModel>(
      showGap: true,
      items: [NoCodeRQItemModel()],
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
                          Text("PO No.",
                              style: appTextTheme.titleSmall
                                  ?.copyWith(color: Colours.greyLight)),
                          gap(space: 10),
                          Text("G2W-F239485939-TW",
                              style: appTextTheme.titleSmall?.copyWith()),
                        ],
                      ),
                    ),
                    // Expanded(child: SizedBox()),
                    chipWidget(
                      dateTimeFormat.toYYMMDDHHMMSS(date: item.usedDate),
                    )
                  ],
                ),
              ),
              divider(),
              // gap(space: 10),

              /// info

              Stack(
                children: [
                  Padding(
                    padding: AppPadding.inner,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Pack No.",
                                style: appTextTheme.titleSmall
                                    ?.copyWith(color: Colours.greyLight)),
                            gap(space: 10),
                            Text("PAC-0028849",
                                style: appTextTheme.titleSmall?.copyWith(),
                                textAlign: TextAlign.center),
                          ],
                        ),
                        gap(space: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Supplier",
                                style: appTextTheme.titleSmall
                                    ?.copyWith(color: Colours.greyLight)),
                            gap(space: 10),
                            Text("Men Chuen",
                                style: appTextTheme.titleSmall?.copyWith(),
                                textAlign: TextAlign.center),
                          ],
                        ),
                        gap(space: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Total",
                                style: appTextTheme.titleSmall
                                    ?.copyWith(color: Colours.greyLight)),
                            gap(space: 10),
                            Text("300.00",
                                style: appTextTheme.titleSmall?.copyWith(),
                                textAlign: TextAlign.center),
                          ],
                        ),
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
