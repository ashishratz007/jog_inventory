import 'package:jog_inventory/common/utils/bottom_sheet.dart';
import 'package:jog_inventory/common/utils/error_message.dart';
import 'package:jog_inventory/modules/ink_paper/modles/digital_paper.dart';
import 'package:jog_inventory/modules/material/models/material_request.dart';
import 'package:jog_inventory/modules/no_code/models/no_code_item.dart';
import '../../../common/exports/main_export.dart';

openStockDataBottomSheet() {
  showAppBottomSheet(Get.context!, _ViewStockDataScreen());
}

class _ViewStockDataScreen extends StatefulWidget {
  const _ViewStockDataScreen();

  @override
  State<_ViewStockDataScreen> createState() => _ViewStockDataScreenState();
}

class _ViewStockDataScreenState extends State<_ViewStockDataScreen> {
  RxBool isLoading = false.obs;
  List<StockDataModel> stockData = [];

  Map<String, NoCodeDataSummaryModel> usedDataMap = {};
  String year = "${timeNow().year}";
  int month = timeNow().month;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    isLoading.value = true;
    StockDataModel.getStock(year: year, month: month.toString())
        .then((onValue) {
      stockData = onValue;
      isLoading.value = false;
    }).onError((error, trace) {
      isLoading.value = false;
      displayErrorMessage(context,
          error: error, trace: trace, onRetry: getData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        "Stock Data",
                        style: appTextTheme.titleMedium,
                      ),
                      gap(space: 15),
                      displayAssetsWidget(AppIcons.fabric,
                          width: 20, height: 20)
                    ],
                  ),
                  Expanded(child: SizedBox()),
                  SizedBox(
                    width: 100,
                    child: SecondaryFieldMenu<String>(
                      items: [
                        ...List.generate(
                            20,
                            (index) => DropDownItem<String>(
                                  key: "${timeNow().year - index}",
                                  id: timeNow().year - index,
                                  value: "${timeNow().year - index}",
                                  title: "${timeNow().year - index}",
                                )),
                      ],
                      hintText: year,
                      onChanged: (value) {
                        year = value?.value ?? timeNow().year.toString();
                        getData();
                      },
                    ),
                  ),
                  gap(),
                  SizedBox(
                    width: 100,
                    child: SecondaryFieldMenu<String>(
                      items: [
                        ...List.generate(
                            12,
                            (index) => DropDownItem<String>(
                                  key:
                                      "${getMonthName(index + 1, short: true)}",
                                  id: index,
                                  value: "${(index + 1)}",
                                  title:
                                      "${getMonthName(index + 1, short: true)}",
                                )),
                      ],
                      hintText: getMonthName(month, short: true),
                      onChanged: (value) {
                        month = int.parse(
                            value?.value ?? timeNow().month.toString());
                        getData();
                      },
                    ),
                  )
                ],
              ),
            ),
            gap(),

            /// title
            Container(
              color: Colours.secondary,
              padding: EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Size",
                      style: appTextTheme.labelMedium
                          ?.copyWith(color: Colours.white),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Stock Room',
                      style: appTextTheme.labelMedium
                          ?.copyWith(color: Colours.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Paper Req.",
                      style: appTextTheme.labelMedium
                          ?.copyWith(color: Colours.white),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
            gap(),
            Obx(
              () => Visibility(
                visible: isLoading.value,
                child: listLoadingEffect(count: 6),
              ),
            ),

            /// data list

            Obx(
              () => isLoading.value
                  ? listLoadingEffect()
                  : Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        children: [
                          ...displayList<StockDataModel>(
                              items: stockData,
                              builder: (item, index) {
                                return Container(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colours.border))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                            item.paperSize.toString(),
                                            style: appTextTheme.labelMedium
                                                ?.copyWith(
                                                    color: Colours.blackLite),
                                            textAlign: TextAlign.start,
                                          )),
                                      Expanded(
                                          flex: 2,
                                          child: Text(
                                            "${item.unusedCount}",
                                            style: appTextTheme.labelMedium
                                                ?.copyWith(
                                                    color: Colours.blackLite),
                                            textAlign: TextAlign.center,
                                          )),
                                      Expanded(
                                          flex: 2,
                                          child: Text(
                                            formatNumber(
                                                "${item.balanceCount}"),
                                            style: appTextTheme.labelMedium
                                                ?.copyWith(
                                                    color: Colours.blackLite),
                                            textAlign: TextAlign.center,
                                          )),
                                    ],
                                  ),
                                );
                              })

                          // ...List.generate(usesData?.data?.length ?? 0, (index) {
                          //   var month = getMonthName(index + 1, short: true);
                          //   var data = usesData?.data![index];
                          //   return Container(
                          //     padding: const EdgeInsets.only(bottom: 10, top: 10),
                          //     decoration: BoxDecoration(
                          //         border:
                          //         Border(bottom: BorderSide(color: Colours.border))),
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         Expanded(
                          //             flex: 1,
                          //             child: Text(
                          //               month,
                          //               style: appTextTheme.labelMedium
                          //                   ?.copyWith(color: Colours.blackLite),
                          //               textAlign: TextAlign.start,
                          //             )),
                          //         Expanded(
                          //             flex: 2,
                          //             child: Text(
                          //               "${data?.usedKg}",
                          //               style: appTextTheme.labelMedium
                          //                   ?.copyWith(color: Colours.blackLite),
                          //               textAlign: TextAlign.center,
                          //             )),
                          //         Expanded(
                          //             flex: 2,
                          //             child: Text(
                          //               formatNumber("${data?.cost ?? 0.0}"),
                          //               style: appTextTheme.labelMedium
                          //                   ?.copyWith(color: Colours.blackLite),
                          //               textAlign: TextAlign.center,
                          //             )),
                          //       ],
                          //     ),
                          //   );
                          // }),
                          // gap(space: 10),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Expanded(
                          //         flex: 1,
                          //         child: Text(
                          //           Strings.total,
                          //           style: appTextTheme.labelMedium
                          //               ?.copyWith(color: Colours.primaryText),
                          //           textAlign: TextAlign.start,
                          //         )),
                          //     Expanded(
                          //         flex: 2,
                          //         child: Text(
                          //           "${totalKg}",
                          //           style: appTextTheme.labelMedium
                          //               ?.copyWith(color: Colours.primaryText),
                          //           textAlign: TextAlign.center,
                          //         )),
                          //     Expanded(
                          //         flex: 2,
                          //         child: Text(
                          //           ("${usesData?.totalCost ?? 0.0}"),
                          //           style: appTextTheme.labelMedium
                          //               ?.copyWith(color: Colours.primaryText),
                          //           textAlign: TextAlign.center,
                          //         )),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
            ),

            ///
            gap(),
            SafeAreaBottom(context),
          ],
        ),
      ),
    );
  }
}
