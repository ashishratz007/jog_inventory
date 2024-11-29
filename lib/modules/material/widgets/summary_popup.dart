import 'package:jog_inventory/common/utils/error_message.dart';

import '../../../common/exports/main_export.dart';
import '../models/material_request.dart';

class ViewSummaryBodyScreen extends StatefulWidget {
  const ViewSummaryBodyScreen({super.key});

  @override
  State<ViewSummaryBodyScreen> createState() => _ViewSummaryBodyScreenState();
}

class _ViewSummaryBodyScreenState extends State<ViewSummaryBodyScreen> {
  RxBool isLoading = false.obs;
  UsageDataModel? usesData;
  List<String> get keys => (usesData?.monthlyUsage.keys ?? []).toList();
  Map<String, UsageDataModel> usedDataMap = {};
  String year = timeNow().year.toString();

  @override
  void initState() {
    getSummeryData();
    super.initState();
  }

  getSummeryData() async {
    usesData = usedDataMap[year];

    setState(() {});
    if (usesData != null) {
      return;
    }
    isLoading.value = true;
    UsageDataModel.fetch(year.toString()).then((val) {
      usesData = val;
      usedDataMap[year] = usesData!;
      isLoading.value = false;
      setState(() {});

      ///
    }).onError((e, trace) {
      isLoading.value = false;
      displayErrorMessage(
        context,
        error: e,
        trace: trace,
        onRetry: () {
          getSummeryData();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                      Strings.usedTotal,
                      style: appTextTheme.titleMedium,
                    ),
                    gap(space: 15),
                    displayAssetsWidget(AppIcons.fabric, width: 20, height: 20)
                  ],
                ),
                SizedBox(
                  width: 100,
                  child: SecondaryFieldMenu<String>(
                    items: [
                      ...List.generate(
                          20,
                          (index) => DropDownItem<String>(
                              key: "${index}",
                              id: index,
                              value: "${timeNow().year - index}",
                              title: "${timeNow().year - index}")),
                    ],
                    hintText: year,
                    onChanged: (value) {
                      year = value?.value ?? timeNow().year.toString();
                      getSummeryData();
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
                    Strings.month,
                    style: appTextTheme.labelMedium
                        ?.copyWith(color: Colours.white),
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    Strings.used + "(KG)",
                    style: appTextTheme.labelMedium
                        ?.copyWith(color: Colours.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    Strings.cost,
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
                ...List.generate(usesData?.monthlyUsage.length ?? 0, (index) {
                  var key = keys[index];
                  var month = getMonthName(index + 1, short: true);
                  var data = usesData?.monthlyUsage[key];
                  return Container(
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
                              month,
                              style: appTextTheme.labelMedium
                                  ?.copyWith(color: Colours.blackLite),
                              textAlign: TextAlign.start,
                            )),
                        Expanded(
                            flex: 2,
                            child: Text(
                              "${data?.used}",
                              style: appTextTheme.labelMedium
                                  ?.copyWith(color: Colours.blackLite),
                              textAlign: TextAlign.center,
                            )),
                        Expanded(
                            flex: 2,
                            child: Text(
                              formatNumber("${data?.cost ?? 0.0}"),
                              style: appTextTheme.labelMedium
                                  ?.copyWith(color: Colours.blackLite),
                              textAlign: TextAlign.center,
                            )),
                      ],
                    ),
                  );
                }),
                gap(space: 10),
              ],
            ),
          ),

          ///
          gap(),
          SafeAreaBottom(context),
        ],
      ),
    );
  }
}
