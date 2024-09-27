import 'package:jog_inventory/common/utils/date_formater.dart';
import 'package:jog_inventory/modules/no_code/models/no_code_item.dart';
import 'package:jog_inventory/modules/stock_in/controllers/detail.dart';
import '../../../common/exports/main_export.dart';

class StockInDetailScreen extends StatefulWidget {
  const StockInDetailScreen({super.key});

  @override
  State<StockInDetailScreen> createState() => _StockInDetailState();
}

class _StockInDetailState extends State<StockInDetailScreen> {
  StockInDetailController get controller =>
      getController<StockInDetailController>(StockInDetailController());

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(title: "Stock In Detail", body: body);
  }

  Widget body(BuildContext context) {
    return SingleChildScrollView(
      padding: AppPadding.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          orderInfo(),
          gap(),
          Obx(() => Visibility(
              visible: controller.isLoading.value,
              child: listLoadingEffect(height: 100))),
          Obx(
            () => Visibility(
              visible: 0 > 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  gap(),
                  ...displayList<NoCodeRQUsedItemModel>(
                      showGap: true,
                      items: [],
                      builder: (item, index) => itemTileWidget(item, index)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
              Text("Code",
                  style:
                      appTextTheme.labelMedium?.copyWith(color: Colours.white)),
              gap(),
              Text("Code",
                  style:
                      appTextTheme.labelSmall?.copyWith(color: Colours.white)),
            ],
          ),
          gap(space: 10),
          Row(
            children: [
              Text(Strings.orderCode,
                  style:
                      appTextTheme.labelMedium?.copyWith(color: Colours.white)),
              gap(),
              Text("controller.usedCode.usedOrderCode",
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
              Text(dateTimeFormat.toYYMMDDHHMMSS(),
                  style:
                      appTextTheme.labelSmall?.copyWith(color: Colours.white)),
            ],
          ),
        ],
      ),
    );
  }

  Widget itemTileWidget(NoCodeRQUsedItemModel item, int index) {
    return Container(
        padding: AppPadding.inner,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: containerShadow(),
          color: Colours.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("${item.catName ?? ""} , ",
                    style: appTextTheme.titleSmall
                        ?.copyWith(color: Colours.primaryText)),
                Text("${item.usedDetailColor ?? ""}",
                    style: appTextTheme.titleSmall?.copyWith()),
                Expanded(child: SizedBox()),
              ],
            ),
            gap(space: 10),
            Row(
              children: [
                Expanded(
                    flex: 3,
                    child: displayTitleSubtitle(
                        "Type", "${item.typeId == 1 ? "Fabric" : ""}")),
                Expanded(
                    flex: 2,
                    child: displayTitleSubtitle(
                        "Used", "${item.usedDetailUsed ?? 0} kg")),
              ],
            ),
            gap(space: 5),
            Row(
              children: [
                Expanded(
                    flex: 3,
                    child: displayTitleSubtitle("NO", "${item.usedDetailNo}")),
                Expanded(
                    flex: 2,
                    child: displayTitleSubtitle(
                        "Price", "${item.usedDetailPrice ?? 0}")),
              ],
            ),
            gap(space: 5),
            Row(
              children: [
                Expanded(
                    flex: 3,
                    child: displayTitleSubtitle(
                        "Balance", "${item.balance ?? 0.0} kg")),
                Expanded(
                    flex: 2,
                    child: displayTitleSubtitle("Total",
                        "${formatDecimal("${(item.usedDetailUsed ?? 0.0) * (item.usedDetailPrice ?? 0)}")}")),
              ],
            ),
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
}
