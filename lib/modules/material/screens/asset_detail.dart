import 'package:jog_inventory/common/utils/error_message.dart';
import 'package:jog_inventory/modules/material/models/assets.dart';

import '../../../common/exports/main_export.dart';

class AssetsDetailScreen extends StatefulWidget {
  const AssetsDetailScreen({super.key});

  @override
  State<AssetsDetailScreen> createState() => _AssetsDetailScreenState();
}

class _AssetsDetailScreenState extends State<AssetsDetailScreen> {
  RxBool isLoading = false.obs;
  AssetModel? assetModel;
  late String assetId;

  @override
  void initState() {
    var args = mainNavigationService.arguments;
    assetId = args[appKeys.assetId];
    getData();
    super.initState();
  }

  getData() {
    isLoading.value = true;
    AssetModel.fetch(assetId).then((value) {
      if (value != null) {
        assetModel = value;
        setState(() {});
      } else
        displayErrorMessage(
          Get.context!,
          error: "Unable to find the assets",
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
    return CustomAppBar(title: "Assets", body: body);
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
                    "Assets Code: ${assetModel?.assetCode??"_"}",
                    style: appTextTheme.titleMedium
                        ?.copyWith(color: Colours.white),
                  ),
                  displayAssetsWidget(AppIcons.boxes_white, height: 30),
                ],
              ),
            ),
            gap(space: 10),
            displayDataTiles('Date', assetModel?.purchasedDate?? "_"),
            Divider(color: Colours.bgGrey),
            displayDataTiles('Asset Name', assetModel?.assetName?? "_"),
            Divider(color: Colours.bgGrey),
            displayDataTiles('QTY', "${assetModel?.qty?? "_"}"),
            Divider(color: Colours.bgGrey),
            displayDataTiles('Amount', assetModel?.cost??"_"),
            Divider(color: Colours.bgGrey),
            displayDataTiles('Location', assetModel?.assetsLocation?? "_"),
            Divider(color: Colours.bgGrey),
            displayDataTiles('Department', assetModel?.department?? "_"),
            Divider(color: Colours.bgGrey),
            displayDataTiles('Supplier', assetModel?.suppliersName?? "_"),
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
