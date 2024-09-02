import 'package:jog_inventory/common/utils/date_formater.dart';
import 'package:jog_inventory/common/utils/error_message.dart';

import '../../../common/exports/main_export.dart';
import '../models/material_request.dart';

class FinishedMaterialDetailScreen extends StatefulWidget {
  const FinishedMaterialDetailScreen({super.key});

  @override
  State<FinishedMaterialDetailScreen> createState() =>
      _FinishedMaterialDetailScreenState();
}

class _FinishedMaterialDetailScreenState
    extends State<FinishedMaterialDetailScreen> {
  RxBool isLoading = false.obs;
  List<MaterialRQItem> items = [];
  MaterialRequestDetailModel materialDetail = MaterialRequestDetailModel();
  MaterialRequestModel materialRqDetail = MaterialRequestModel();

  double get total {
    var val = 0.0;
    materialDetail.orders?.forEach((item) {
      val += item.fabricTotal ?? 0.0;
    });
    return val;
  }

  double get usedKg {
    var val = 0.0;
    materialDetail.orders?.forEach((item) {
      val += double.tryParse(item.used ?? "_") ?? 0.0;
    });
    return val;
  }

  @override
  void initState() {
    materialRqDetail = Get.arguments[appKeys.materialRQDetail];
    getMaterialData();
    super.initState();
  }

  getMaterialData() async {
    isLoading.value = true;
    try {
      var materialRQId = Get.arguments[appKeys.materialRQId];
      materialDetail = await MaterialRequestDetailModel.fetch(materialRQId);
      isLoading.value = false;
    } catch (error, trace) {
      isLoading.value = false;
      showErrorMessage(context, error: error, trace: trace, onRetry: () {
        getMaterialData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(title: "Finished Detail", body: body());
  }

  Widget body() {
    return SingleChildScrollView(
        padding: AppPadding.pagePadding,
        child: Obx(
          () => Column(
            children: [
              orderInfo(),
              gap(space: 20),

              Visibility(
                  visible: isLoading.value,
                  child: listLoadingEffect(count: 2, height: 100)),
              if (!isLoading.value) ...[
                dottedDivider(color: Colours.greyLight),
                gap(space: 20),
                ...displayList(
                    showGap: true,
                    items: materialDetail.orders,
                    builder: (item, index) {
                      var item = materialDetail.orders![index];
                      return itemTileWidget(item, index);
                    }),
                gap(),
                totalWidget(),
              ],

              ///
              gap(),
              safeAreaBottom(context),
            ],
          ),
        ));
  }

  Widget orderInfo() {
    return Container(
      padding: AppPadding.inner,
      decoration: BoxDecoration(
          color: Colours.secondary2, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(Strings.status,
                  style:
                      appTextTheme.labelMedium?.copyWith(color: Colours.white)),
              gap(),
              Text(materialRqDetail.rqStatus ?? "",
                  style:
                      appTextTheme.labelMedium?.copyWith(color: Colours.white)),
              Expanded(child: SizedBox()),
              displayAssetsWidget(AppIcons.boxes_white, height: 22)
            ],
          ),
          gap(space: 10),
          Row(
            children: [
              Text(Strings.orderCode,
                  style:
                      appTextTheme.labelMedium?.copyWith(color: Colours.white)),
              gap(),
              Text(materialRqDetail.orderCode ?? "_",
                  style:
                      appTextTheme.labelSmall?.copyWith(color: Colours.white)),
            ],
          ),
          gap(space: 10),
          Row(
            children: [
              Text(Strings.date,
                  style:
                      appTextTheme.labelMedium?.copyWith(color: Colours.white)),
              gap(),
              Text(
                  appDateTimeFormat.toYYMMDDHHMMSS(
                      date: materialRqDetail.rqDate),
                  style:
                      appTextTheme.labelSmall?.copyWith(color: Colours.white)),
            ],
          ),
          gap(space: 10),
          Row(
            children: [
              Text(Strings.finish,
                  style:
                      appTextTheme.labelMedium?.copyWith(color: Colours.white)),
              gap(),
              Text(
                  appDateTimeFormat.toYYMMDDHHMMSS(
                      date: materialRqDetail.finishDate),
                  style:
                      appTextTheme.labelSmall?.copyWith(color: Colours.white)),
            ],
          ),
        ],
      ),
    );
  }

  Widget itemTileWidget(MaterialRQItem item, int index) {
    return Container(
        padding: AppPadding.inner,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: containerShadow(),
          color: Colours.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.fabricNo ?? "_",
                style: appTextTheme.titleSmall
                    ?.copyWith(color: Colours.blackLite)),
            gap(space: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("${item.catNameEn} , ",
                          style: appTextTheme.titleSmall
                              ?.copyWith(color: Colours.primaryText)),
                      Text("${item.fabricColor}",
                          style: appTextTheme.titleSmall?.copyWith()),
                      Expanded(child: SizedBox()),
                      displayAssetsWidget(AppIcons.edit, height: 20)
                    ],
                  ),
                  gap(space: 10),
                  Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child:
                              displayTitleSubtitle("Box", "${item.fabricBox}")),
                      Expanded(
                          flex: 2,
                          child:
                              displayTitleSubtitle("Used", "${item.used} kg")),
                    ],
                  ),
                  gap(space: 5),
                  Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: displayTitleSubtitle(
                              "Bal before", "${item.balanceBefore} kg")),
                      Expanded(
                          flex: 2,
                          child: displayTitleSubtitle(
                              "Unit price", "${item.fabricInPrice??0}")),
                    ],
                  ),
                  gap(space: 5),
                  Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: displayTitleSubtitle(
                              "Bal after", "${item.balanceAfter} kg")),
                      Expanded(
                          flex: 2,
                          child: displayTitleSubtitle(
                              "Total", "${item.fabricAmount??0}")),
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Widget displayTitleSubtitle(String title, String subtitle) {
    return Row(
      children: [
        Text(title,
            style: appTextTheme.titleSmall?.copyWith(color: Colours.greyLight)),
        gap(space: 10),
        Text(
          subtitle,
          style: appTextTheme.titleSmall?.copyWith(),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget totalWidget() {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              color: Colours.secondary,
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: Colours.white, size: 20),
                gap(),
                Expanded(child: SizedBox()),
                Expanded(
                    child: Text(
                  "Used(Kg)",
                  style:
                      appTextTheme.labelMedium?.copyWith(color: Colours.white),
                  textAlign: TextAlign.center,
                )),
                Expanded(
                    child: Text(
                  "Price",
                  style: appTextTheme.labelMedium?.copyWith(
                    color: Colours.white,
                  ),
                  textAlign: TextAlign.center,
                )),
              ],
            )),
        Container(
            padding: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              boxShadow: containerShadow(top: false, right: false, left: false),
              color: Colours.white,
            ),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  "GrandTotal",
                  style: appTextTheme.labelMedium
                      ?.copyWith(color: Colours.blackLite),
                  textAlign: TextAlign.center,
                )),
                gap(space: 10),
                Icon(Icons.arrow_forward, color: Colours.secondary, size: 20),
                gap(space: 10),
                Expanded(
                    child: Text(
                  "${usedKg} kg",
                  style: appTextTheme.labelMedium
                      ?.copyWith(color: Colours.blackLite),
                  textAlign: TextAlign.center,
                )),
                Expanded(
                    child: Text(
                  formatNumber(total.toString()),
                  style: appTextTheme.labelMedium?.copyWith(
                    color: Colours.blackLite,
                  ),
                  textAlign: TextAlign.center,
                )),
              ],
            )),
      ],
    );
  }
}
