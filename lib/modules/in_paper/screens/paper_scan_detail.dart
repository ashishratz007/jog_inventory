import 'package:jog_inventory/common/utils/error_message.dart';
import 'package:jog_inventory/modules/in_paper/modles/digital_paper.dart';
import '../../../common/exports/main_export.dart';

class ScanPaperDetailScreen extends StatefulWidget {
  const ScanPaperDetailScreen({super.key});

  @override
  State<ScanPaperDetailScreen> createState() => _ScanPaperDetailScreenState();
}

class _ScanPaperDetailScreenState extends State<ScanPaperDetailScreen> {
  RxBool isLoading = false.obs;
  DigitalPaperModel? paperData;
  late String paperId;

  @override
  void initState() {
    var args = mainNavigationService.arguments;
    paperId = args[appKeys.paperId];
    getData();
    super.initState();
  }

  getData() {
    isLoading.value = true;
    DigitalPaperModel.getPaperDetail(paper_id: paperId).then((value) {
      if (value != null) {
        paperData = value;
        setState(() {});
      } else
        displayErrorMessage(
          Get.context!,
          error: "Unable to find the Paper detail",
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
    return CustomAppBar(title: "Paper Detail", body: body);
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
                    "Digital Paper",
                    style: appTextTheme.titleMedium
                        ?.copyWith(color: Colours.white),
                  ),
                  displayAssetsWidget(AppIcons.boxes_white, height: 30),
                ],
              ),
            ),
            gap(space: 10),
            displayDataTiles('Date', paperData?.usedDate?? "_"),
            Divider(color: Colours.bgGrey),
            displayDataTiles('Supplier', paperData?.supplier?? "_"),
            Divider(color: Colours.bgGrey),
            displayDataTiles('PO', paperData?.po?? "_"),
            Divider(color: Colours.bgGrey),
            displayDataTiles('No', "${paperData?.rollNo?? "_"}"),
            Divider(color: Colours.bgGrey),
            displayDataTiles('In Stock', paperData?.inStock??"_"),
            Divider(color: Colours.bgGrey),
            displayDataTiles('Paper Size', paperData?.paperSize?? "_"),
            Divider(color: Colours.bgGrey),
            displayDataTiles('Price (Yads) ', paperData?.priceYads?? "_"),
            Divider(color: Colours.bgGrey),
            displayDataTiles('Price(lb)', paperData?.priceLb?? "_"),
            Divider(color: Colours.bgGrey),
            displayDataTiles('Used', paperData?.usedValue?? "_"),
            Divider(color: Colours.bgGrey),
            displayDataTiles('Paper size', paperData?.paperSize?? "_"),
            Divider(color: Colours.bgGrey),
            displayDataTiles('Balance', paperData?.paperBalance?? "_"),

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
