import 'package:jog_inventory/common/utils/dotted_border.dart';
import 'package:jog_inventory/modules/home/controllers/home.dart';
import '../../../common/exports/main_export.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});
  HomeController get controller =>
      HomeController.getController();

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      hasDrawer: true,
      title: "title",
      body: bodyWidget(),
    );
  }

  Widget bodyWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          /// scan barcode
          ScanBarCodeChipWidget(),
          gap(),
          DottedLineDivider(
            color: Colours.border,
            dotSpace: 3,
          ),
          actionsTilesWidget(),

          ///bottom
          gap(),
          safeAreaBottom(Get.context),
        ],
      ),
    );
  }

  Widget ScanBarCodeChipWidget() {
    var radius = 10.0;
    return Container(
      padding: AppPadding.pagePaddingAll,
      decoration: BoxDecoration(
          color: Colours.white,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
          boxShadow: containerShadow(top: false, right: false, left: false)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Scan Barcode to make material request',
              textAlign: TextAlign.center, style: appTextTheme.titleSmall),
          gap(),
          Container(
              decoration: BoxDecoration(
                color: Colours.white,
                borderRadius: BorderRadius.circular(radius),
                boxShadow: containerShadow(),
              ),
              margin: EdgeInsets.all(10),
              width: Get.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Stack(
                      fit: StackFit.passthrough,
                      children: [
                        Stack(
                          children: [
                            Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colours.greyLight.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(5)),
                                padding: EdgeInsets.only(top: 30, bottom: 30),
                                width: Get.width,
                                child: displayAssetsWidget(
                                    'assets/images/scanner.png')),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colours.greyLight.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(5)),
                                padding: EdgeInsets.only(top: 30, bottom: 30),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                // Adjust radius as needed
                                topLeft: Radius.circular(
                                    10), // Adjust radius as needed
                              ),
                              border: Border(
                                top: BorderSide(
                                    color: Colours.secondary, width: 3),
                                left: BorderSide(
                                    color: Colours.secondary, width: 3),
                              )),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  // Adjust radius as needed
                                  topRight: Radius.circular(
                                      10), // Adjust radius as needed
                                ),
                                border: Border(
                                  top: BorderSide(
                                      color: Colours.secondary, width: 3),
                                  right: BorderSide(
                                      color: Colours.secondary, width: 3),
                                )),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  // Adjust radius as needed
                                  bottomLeft: Radius.circular(
                                      10), // Adjust radius as needed
                                ),
                                border: Border(
                                  bottom: BorderSide(
                                      color: Colours.secondary, width: 3),
                                  left: BorderSide(
                                      color: Colours.secondary, width: 3),
                                )),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  // Adjust radius as needed
                                  bottomRight: Radius.circular(
                                      10), // Adjust radius as needed
                                ),
                                border: Border(
                                  bottom: BorderSide(
                                      color: Colours.secondary, width: 3),
                                  right: BorderSide(
                                      color: Colours.secondary, width: 3),
                                )),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: SizedBox(
                              height: 10,
                              width: 200,
                              child: Divider(
                                color: Colours.white,
                                thickness: 3,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  gap(),
                  /// Scan button
                  SecondaryButton(
                      title: "Scan Barcode ",
                      onTap:
                        controller.scanQrCode,
                      radius: radius,
                      trailing: displayAssetsWidget(AppIcons.scan, width: 20))
                ],
              )),
          gap(space: 10)
        ],
      ),
    );
  }

  Widget actionsTilesWidget() {
    return Padding(
      padding: AppPadding.pagePadding,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: actionTileWidget(
                      onTap: () {},
                      "Stock In",
                      displayAssetsWidget(AppIcons.boxes_white,
                          borderRadius: BorderRadius.circular(10),
                          color: Colours.blue,
                          height: 20,
                          padding: AppPadding.inner))),
              gap(space: 10),
              Expanded(
                  child: actionTileWidget(
                      onTap: () {},
                      "Material Request",
                      displayAssetsWidget(AppIcons.mat_white,
                          borderRadius: BorderRadius.circular(10),
                          color: Colours.secondary,
                          height: 20,
                          padding: AppPadding.inner))),
            ],
          ),
          gap(space: 10),
          Row(
            children: [
              Expanded(
                  child: actionTileWidget(
                      onTap: () {},
                      "No Code request",
                      displayAssetsWidget(AppIcons.no_code,
                          borderRadius: BorderRadius.circular(10),
                          color: Colours.green,
                          height: 20,
                          padding: AppPadding.inner))),
              gap(space: 10),
              Expanded(
                  child: actionTileWidget(
                      onTap: () {},
                      "Add Forecast",
                      displayAssetsWidget(AppIcons.future,
                          borderRadius: BorderRadius.circular(10),
                          color: Colours.blackMat,
                          height: 20,
                          padding: AppPadding.inner))),
            ],
          ),
        ],
      ),
    );
  }

  Widget actionTileWidget(String title, Widget icon,
      {required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: AppPadding.inner,
        decoration: BoxDecoration(
          boxShadow: containerShadow(),
          borderRadius: BorderRadius.circular(10),
          color: Colours.white,
        ),
        child: Column(
          children: [gap(space: 10), icon, gap(), Text(title), gap(space: 10)],
        ),
      ),
    );
  }
}
