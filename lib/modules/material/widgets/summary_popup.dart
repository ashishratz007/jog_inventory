import '../../../common/exports/main_export.dart';

class ViewSummaryBodyScreen extends StatefulWidget {
  const ViewSummaryBodyScreen({super.key});

  @override
  State<ViewSummaryBodyScreen> createState() => _ViewSummaryBodyScreenState();
}

class _ViewSummaryBodyScreenState extends State<ViewSummaryBodyScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              children: [
                Text(
                  Strings.usedTotal,
                  style: appTextTheme.titleMedium,
                ),
                gap(space: 15),
                displayAssetsWidget(AppIcons.fabric, width: 20, height: 20)
              ],
            ),
          ),
          gap(),
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
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                ...List.generate(
                    4,
                    (index) => Container(
                          padding: const EdgeInsets.only(bottom: 10, top: 10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colours.border))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    "Jan",
                                    style: appTextTheme.labelMedium
                                        ?.copyWith(color: Colours.blackLite),
                                    textAlign: TextAlign.start,
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    "5,858.21",
                                    style: appTextTheme.labelMedium
                                        ?.copyWith(color: Colours.blackLite),
                                    textAlign: TextAlign.center,
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    "1,224,578,12",
                                    style: appTextTheme.labelMedium
                                        ?.copyWith(color: Colours.blackLite),
                                    textAlign: TextAlign.center,
                                  )),
                            ],
                          ),
                        )),
                gap(space: 10),
              ],
            ),
          ),

          ///
          gap(),
          safeAreaBottom(context),
        ],
      ),
    );
  }
}
