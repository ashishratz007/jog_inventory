import 'package:jog_inventory/common/utils/bottom_sheet.dart';
import 'package:jog_inventory/common/utils/error_message.dart';
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

  Map<String, NoCodeDataSummaryModel> usedDataMap = {};
  String year = "${getMonthName(timeNow().month,short: true)}";

  @override
  void initState() {
    super.initState();
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  value:
                                      "${getMonthName(index + 1, short: true)}",
                                  title:
                                      "${getMonthName(index + 1, short: true)}",
                                )),
                      ],
                      hintText: year,
                      onChanged: (value) {
                        year = value?.value ?? timeNow().year.toString();
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
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 10, top: 10),
                    decoration: BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colours.border))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text(
                              "100",
                              style: appTextTheme.labelMedium
                                  ?.copyWith(color: Colours.blackLite),
                              textAlign: TextAlign.start,
                            )),
                        Expanded(
                            flex: 2,
                            child: Text(
                              "${181}",
                              style: appTextTheme.labelMedium
                                  ?.copyWith(color: Colours.blackLite),
                              textAlign: TextAlign.center,
                            )),
                        Expanded(
                            flex: 2,
                            child: Text(
                              formatNumber("${10}"),
                              style: appTextTheme.labelMedium
                                  ?.copyWith(color: Colours.blackLite),
                              textAlign: TextAlign.center,
                            )),
                      ],
                    ),
                  )
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

            ///
            gap(),
            SafeAreaBottom(context),
          ],
        ),
      ),
    );
  }
}
