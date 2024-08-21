import '../../../common/exports/main_export.dart';

class FinishedMaterialDetailScreen extends StatefulWidget {
  const FinishedMaterialDetailScreen({super.key});

  @override
  State<FinishedMaterialDetailScreen> createState() =>
      _FinishedMaterialDetailScreenState();
}

class _FinishedMaterialDetailScreenState
    extends State<FinishedMaterialDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomAppBar(title: "Finished Detail", body: body());
  }

  Widget body() {
    return SingleChildScrollView(
        padding: AppPadding.pagePadding,
        child: Column(
          children: [
            orderInfo(),
            gap(space: 20),
            dottedDivider(color: Colours.greyLight),
            gap(space: 20),
            itemTileWidget(),
            gap(),
            totalWidget(),

            ///
            gap(),
            safeAreaBottom(context),
          ],
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
              Text("New",
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
              Text("EX-5227A",
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
              Text("24-08-06 10:48:45",
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
              Text("24-08-06 10:48:45",
                  style:
                      appTextTheme.labelSmall?.copyWith(color: Colours.white)),
            ],
          ),
        ],
      ),
    );
  }

  Widget itemTileWidget() {
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
            Text("1",
                style: appTextTheme.titleSmall
                    ?.copyWith(color: Colours.blackLite)),
            gap(space: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Ak PRO MAX LIGHT , ",
                          style: appTextTheme.titleSmall
                              ?.copyWith(color: Colours.primaryText)),
                      Text("Brown", style: appTextTheme.titleSmall?.copyWith()),
                      Expanded(child: SizedBox()),
                      displayAssetsWidget(AppIcons.edit, height: 20)
                    ],
                  ),
                  gap(space: 10),
                  Row(
                    children: [
                      Expanded(child: displayTitleSubtitle("Box", "15")),
                      Expanded(child: displayTitleSubtitle("Used", "15.00 kg")),
                    ],
                  ),
                  gap(space: 5),
                  Row(
                    children: [
                      Expanded(child: displayTitleSubtitle("Bal before", "15")),
                      Expanded(
                          child:
                              displayTitleSubtitle("Unit price", "15.00 kg")),
                    ],
                  ),
                  gap(space: 5),
                  Row(
                    children: [
                      Expanded(child: displayTitleSubtitle("Bal after", "15")),
                      Expanded(
                          child: displayTitleSubtitle("Total", "15.00 kg")),
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
                  "25.00 kg",
                  style: appTextTheme.labelMedium
                      ?.copyWith(color: Colours.blackLite),
                  textAlign: TextAlign.center,
                )),
                Expanded(
                    child: Text(
                  "90000",
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
