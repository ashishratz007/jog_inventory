import 'package:flutter/cupertino.dart';
import 'package:jog_inventory/common/utils/dotted_border.dart';

import '../../../common/exports/main_export.dart';

class AddForecastScreen extends StatefulWidget {
  const AddForecastScreen({super.key});

  @override
  State<AddForecastScreen> createState() => _AddForecastScreenState();
}

class _AddForecastScreenState extends State<AddForecastScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: "Forecast form",
      body: body(),
      trailingButton: SizedBox(
          child: TextBorderButton(
        title: 'Reset',
        trailing: Icon(
          Icons.refresh,
          color: Colours.white,
        ),
        borderColor: Colours.white,
        color: Colours.white,
        onTap: () {
          /// Todo
        },
      )),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      padding: AppPadding.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          forecastDetailWidget(),
          gap(),

          /// date
          selectDateWidget(),
          gap(),

          itemTileWidget(),
          gap(),
          addForecastButton(),

          /// safe area bottom
          gap(),
          safeAreaBottom(context),
        ],
      ),
    );
  }

  /// forecast code
  Widget forecastDetailWidget() {
    return Container(
        padding: AppPadding.inner,
        decoration: BoxDecoration(
            color: Colours.greyLight.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Forecast code",
                    style: appTextTheme.labelMedium
                        ?.copyWith(color: Colors.grey.shade700)),
                gap(space: 10),
                Text("FC-2408231619", style: appTextTheme.labelMedium),
              ],
            ),
            gap(space: 10),
            Row(
              children: [
                Text("Order code",
                    style: appTextTheme.labelMedium
                        ?.copyWith(color: Colors.grey.shade700)),
                gap(space: 10),
                Text("EX22-2365_OR", style: appTextTheme.labelMedium),
              ],
            ),
          ],
        ));
  }

  Widget selectDateWidget() {
    return Container(
      padding: AppPadding.inner,
      decoration: BoxDecoration(
        color: Colours.white,
        border: Border.all(color: Colours.primaryBlueBg),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          gap(space: 10),
          Text("Date", style: appTextTheme.titleMedium),
          gap(),
          Expanded(child: PrimaryTextField(radius: 10)),
          gap(space: 10),
        ],
      ),
    );
  }

  Widget itemTileWidget() {
    return Container(
      padding: AppPadding.inner,
      decoration: BoxDecoration(
        color: Colours.white,
        border: Border.all(color: Colours.primaryBlueBg),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Ak PRO MAX LIGHT",
                  style: appTextTheme.titleSmall
                      ?.copyWith(color: Colours.primaryText)),
              IconButton(
                  onPressed: () {},
                  icon:
                      Icon(Icons.delete_outlined, size: 25, color: Colours.red))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              displayTitleSubtitle("Color", "Dust Gold"),
              displayTitleSubtitle("Type", "Fabrics"),
              displayTitleSubtitle("Bal", "2.00 kg"),
            ],
          ),
          gap(space: 10),
          Row(
            children: [
              Text("Forecast",
                  style: appTextTheme.titleSmall
                      ?.copyWith(color: Colours.greyLight)),
              gap(),
              Expanded(child: PrimaryTextField(radius: 10, hintText: "in kgs"))
            ],
          ),
          gap(space: 10),
        ],
      ),
    );
  }

  Widget displayTitleSubtitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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

  Widget addForecastButton() {
    return DottedBorderContainer(
      gap: 2,
        borderWidth: 1,
        borderColor: Colours.green,
        borderRadius: BorderRadius.circular(200),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButtonWidget(
                onTap: () {},
                color: Colours.green,
                title: "Add forecast",
                trailing: Icon(
                  Icons.add,
                  color: Colours.green,
                )),
          ],
        ));
  }

  Widget bottomNavBar(){
    return Container();
  }
}
