import 'package:jog_inventory/common/exports/main_export.dart';
import 'package:jog_inventory/common/utils/bottom_sheet.dart';

void openFabricDetailsPopup({required Function() onDone}) {
  showAppBottomSheet(Get.context!, _FabricDetailsScreen(),
      title: "Fabric Details");
}

class _FabricDetailsScreen extends StatefulWidget {
  const _FabricDetailsScreen({super.key});

  @override
  State<_FabricDetailsScreen> createState() => _FabricDetailsScreenState();
}

class _FabricDetailsScreenState extends State<_FabricDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colours.bgColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: SingleChildScrollView(
                padding: AppPadding.inner,
                child: Column(
                  children: [
                    itemTileWidget(),
                    gap(space: 10),
                    itemTileWidget(),
                    gap(space: 10),
                    itemTileWidget(),
                    gap(space: 10),
                    itemTileWidget(),
                    gap(space: 10),
                    itemTileWidget(),
                    gap(space: 10),

                    ///
                    gap(),
                    safeAreaBottom(context),
                  ],
                )),
          ),
          Padding(
            padding: AppPadding.leftRight,
            child: PrimaryButton(
              color: Colours.greenLight,
              title: "Add",
              onTap: () {},
              leading: Icon(Icons.add, size: 18, color: Colors.white),
            ),
          ),
          safeAreaBottom(context),
        ],
      ),
    );
  }

  Widget itemTileWidget() {
    RxBool isSelected = false.obs;
    return Container(
      padding: AppPadding.inner,
      decoration: BoxDecoration(
        color: Colours.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: containerShadow(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("AK PRO MAX LIGHT ,",
                  style: appTextTheme.labelSmall
                      ?.copyWith(color: Colours.primaryText)),
              gap(space: 10),
              Text("Michigan Maize",
                  style: appTextTheme.labelSmall
                      ?.copyWith(color: Colours.blackMat)),
              Expanded(child: SizedBox()),
              Obx(() => checkBox(
                  value: isSelected.value,
                  selectedColor: Colours.secondary,
                  onchange: (value) {
                    isSelected.value = value;
                  }))
            ],
          ),
          Row(
            children: [
              Expanded(
                  flex: 3,
                  child: titleSubtitleWidget(Strings.date, "23/08/2024")),
              Expanded(
                  flex: 2, child: titleSubtitleWidget(Strings.bal, "10.00 kg")),
            ],
          ),
          gap(space: 5),
          Row(
            children: [
              Expanded(flex: 3, child: titleSubtitleWidget(Strings.box, "15")),
              Expanded(
                  flex: 2,
                  child: titleSubtitleWidget(Strings.used, "10.00 kg")),
            ],
          ),
          gap(space: 5),
          Row(
            children: [
              Expanded(flex: 3, child: titleSubtitleWidget("No", "15.00 kg")),
              Expanded(
                  flex: 2, child: titleSubtitleWidget(Strings.amount, "10.00")),
            ],
          ),
        ],
      ),
    );
  }

  Widget titleSubtitleWidget(String title, String subtitle) {
    return Row(
      children: [
        Flexible(
          child: Text(title,
              style:
                  appTextTheme.labelSmall?.copyWith(color: Colours.greyLight)),
        ),
        gap(space: 5),
        Flexible(
          child: Text(subtitle,
              style:
                  appTextTheme.labelSmall?.copyWith(color: Colours.blackLite)),
        ),
      ],
    );
  }
}
