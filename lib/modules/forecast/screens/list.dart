import 'package:jog_inventory/common/utils/date_formater.dart';
import 'package:jog_inventory/common/utils/menu.dart';
import 'package:jog_inventory/modules/forecast/controllers/list.dart';
import 'package:jog_inventory/modules/forecast/models/forecast_list.dart';
import 'package:jog_inventory/services/tab_view_navigator.dart';

import '../../../common/exports/common.dart';

class ForecastListScreen extends StatefulWidget {
  const ForecastListScreen({super.key});

  @override
  State<ForecastListScreen> createState() => _ForecastListScreenState();
}

class _ForecastListScreenState extends State<ForecastListScreen> {
  ForeCastListController controller = ForeCastListController.getController();

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(title: "Forecast List", body: body);
  }

  Widget body(BuildContext context){
    return SingleChildScrollView(
        padding: AppPadding.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gap(),

            /// search

            searchWidget(),
            gap(),
            // page
            pageFilterWidget(),
            gap(),

            /// loading
            Obx(
                  () => Visibility(
                visible: controller.isLoading.value,
                child: listLoadingEffect(),
              ),
            ),

            /// items
            Obx(
                  () => Visibility(
                visible: !controller.isLoading.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: displayItems(),
                ),
              ),
            ),

            ///
            gap(),
            SafeAreaBottom(Get.context!),
          ],
        ));
  }


  Widget searchWidget() {
    return PrimaryTextField(
        allowShadow: true,
        radius: 10,
        hintText: "Search",
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Icon(
            Icons.search,
            color: Colours.greyLight,
            size: 25,
          ),
        ),
        onChanged: (value) {
          controller.getForecastList();
        });
  }

  Widget pageFilterWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text("Page",
            style: appTextTheme.titleSmall?.copyWith(
                color: Colours.blackLite, fontWeight: FontWeight.w700)),
        Gap(10),
        popupMenu(Get.context!,

            items: [
              ...List.generate(20,
                      (index) => MenuItem(
                      title: '${index + 1}',
                      value: index + 1,
                      onTap: (value) {
                        controller.page.value = value;
                        controller.getForecastList();
                      },
                      id: index,
                      key: "$index"))
            ],
            menuIcon: Container(
              height: 40,
              width: 70,
              decoration: BoxDecoration(
                  color: Colours.white,
                  border: Border.all(color: Colours.border),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                  child: Obx(()=> Text(
                        "${controller.page.value}",
                        style: appTextTheme.titleSmall?.copyWith(
                            color: Colours.blackLite,
                            fontWeight: FontWeight.w700)),
                  )),
            )),
        Gap(10),
        Text(
            "of ${20}",
            style: appTextTheme.titleSmall?.copyWith(
                color: Colours.blackLite, fontWeight: FontWeight.w700)),
      ],
    );
  }

  List<Widget> displayItems() {
    return displayList<ForecastItem>(
      showGap: true,
      items: controller.items,
      builder: (item, index) {
        return itemTileWidget(item, index);
      },
    );
  }

  Widget itemTileWidget(ForecastItem item, int index) {
    return InkWell(
      onTap: () {
        mainNavigationService.push(AppRoutesString.addForecast, arguments: {
          appKeys.forecastId: item.forecastId
        });
      },
      child: Container(
          decoration: BoxDecoration(
            color: Colours.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: AppPadding.inner,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${index + 1}",
                      style: appTextTheme.titleSmall
                          ?.copyWith(color: Colours.blackLite),
                    ),
                    gap(),
                    Expanded(
                      child: Text(item.forecastOrder??"_",
                          style: appTextTheme.titleSmall?.copyWith()),
                    ),
                    // Expanded(child: SizedBox()),
                    chipWidget(
                      dateTimeFormat.toYYMMDDHHMMSS(date: ParseData.toDateTime(item.forecastDate)),
                    )
                  ],
                ),
              ),
              divider(),
              // gap(space: 10),

              /// info

              Stack(
                children: [
                  Padding(
                    padding: AppPadding.inner,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Cat Code.",
                                style: appTextTheme.titleSmall
                                    ?.copyWith(color: Colours.greyLight)),
                            gap(space: 10),
                            Text(item.catCode??"_",
                                style: appTextTheme.titleSmall?.copyWith(),
                                textAlign: TextAlign.center),
                          ],
                        ),
                        gap(space: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Color",
                                style: appTextTheme.titleSmall
                                    ?.copyWith(color: Colours.greyLight)),
                            gap(space: 10),
                            Text(item.color??"_",
                                style: appTextTheme.titleSmall?.copyWith(),
                                textAlign: TextAlign.center),
                          ],
                        ),
                        gap(space: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Balance",
                                style: appTextTheme.titleSmall
                                    ?.copyWith(color: Colours.greyLight)),
                            gap(space: 10),
                            Text(("${item.balance??0}"),
                                style: appTextTheme.titleSmall?.copyWith(),
                                textAlign: TextAlign.center),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 50,
                      width: 60,
                      decoration: BoxDecoration(
                          color: Colours.primaryBlueBg,
                          borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(15))),
                      child: Center(
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colours.blueDark,
                          )),
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
