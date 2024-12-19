import 'package:jog_inventory/common/utils/error_message.dart';
import 'package:jog_inventory/modules/in_paper/modles/ink_model.dart';
import '../../../common/exports/main_export.dart';

class ScanInkDetailScreen extends StatefulWidget {
  const ScanInkDetailScreen({super.key});

  @override
  State<ScanInkDetailScreen> createState() => _ScanInkDetailScreenState();
}

class _ScanInkDetailScreenState extends State<ScanInkDetailScreen> {
  RxBool isLoading = false.obs;
  InkModel? inkData;
  late String inkId;

  @override
  void initState() {
    var args = mainNavigationService.arguments;
    inkId = args[appKeys.inkId];
    getData();
    super.initState();
  }

  getData() {
    isLoading.value = true;
    InkModel.getInkDetail(ink_id: inkId).then((value) {
      if (value != null) {
        inkData = value;
        setState(() {});
      } else
        displayErrorMessage(
          Get.context!,
          error: "Unable to find the Ink detail",
          trace: StackTrace.current,
          onRetry: () {},
        );
      isLoading.value = false;
    }).onError((e, trace) {
      isLoading.value = false;
      displayErrorMessage(
        Get.context!,
        error: e,
        trace: trace,
        onRetry: () {},
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(title: "Ink Detail", body: body);
  }

  Widget body(BuildContext context) {
    return SingleChildScrollView(
      padding: AppPadding.pagePadding,
      child: Column(
        children: [
          displayMaterialDetails(),
          gap(),
        ],
      ),
    );
  }

  Widget displayMaterialDetails() {
    var radius = 10.0;
    return Container(
        decoration: BoxDecoration(
            color: Colours.white,
            boxShadow: containerShadow(),
            border: Border.all(color: Colours.border),
            borderRadius: BorderRadius.circular(radius)),
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
                    "Ink",
                    style: appTextTheme.titleMedium
                        ?.copyWith(color: Colours.white),
                  ),
                  displayAssetsWidget(AppIcons.boxes_white, height: 30),
                ],
              ),
            ),
            gap(space: 10),
            displayDataTiles('Date', inkData?.usedDate ?? "_"),
            Divider(color: Colours.bgGrey),
            displayDataTiles('Color', inkData?.inkColor ?? "_"),
            Divider(color: Colours.bgGrey),
            displayDataTiles('Type', inkData?.inkType ?? "_"),
            Divider(color: Colours.bgGrey),
            displayDataTiles('Supplier', inkData?.supplier ?? "_"),
            Divider(color: Colours.bgGrey),
            displayDataTiles('PO', inkData?.po ?? "_"),
            Divider(color: Colours.bgGrey),
            displayDataTiles('No', "${inkData?.rollNo ?? "_"}"),
            Divider(color: Colours.bgGrey),
            displayDataTiles('In Stock', inkData?.inStockMl ?? "_"),
            Divider(color: Colours.bgGrey),
            displayDataTiles('IM', inkData?.imSupplier ?? "_"),
            Divider(color: Colours.bgGrey),
            displayDataTiles('Price', inkData?.priceLb ?? "_"),
            Divider(color: Colours.bgGrey),
            displayDataTiles('Used', inkData?.usedValue ?? "_"),
            Divider(color: Colours.bgGrey),
            gap(space: 10)
          ],
        ));
  }

  Widget displayDataTiles(String title, String value) {
    return Obx(
      () => shimmerEffects(
        isLoading: isLoading.value,
        child: Container(
          padding: AppPadding.inner,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: appTextTheme.titleSmall
                      ?.copyWith(color: Colours.greyLight)),
              gap(),
              Flexible(
                child: Text(value,
                    style: appTextTheme.titleSmall
                        ?.copyWith(color: Colours.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
