import '../../../common/exports/main_export.dart';

class FinishMaterialRQScreen extends StatelessWidget {
  const FinishMaterialRQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: "Finish material request",
      body: body(),
      bottomNavBar: bottomNavBarButtons(),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      padding: AppPadding.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          orderInfo(),
          gap(),
          // tiles
          itemTileWidget(),
          gap(),
          itemTileWidget(),
          gap(),
          itemTileWidget(),
          gap(),

          ///
          gap(),
          safeAreaBottom(Get.context!),
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
              Expanded(child: SizedBox()),
              Text(Strings.date,
                  style:
                      appTextTheme.labelMedium?.copyWith(color: Colours.white)),
              gap(),
              Text("24-08-06",
                  style:
                      appTextTheme.labelSmall?.copyWith(color: Colours.white)),
            ],
          )
        ],
      ),
    );
  }

  Widget itemTileWidget() {
    return Container(
      padding: AppPadding.inner,
      decoration:
          BoxDecoration(color: Colours.white, boxShadow: containerShadow()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          gap(space: 10),
          // info
          Row(
            children: [
              Text("10",
                  style: appTextTheme.labelSmall
                      ?.copyWith(color: Colours.greyLight)),
              gap(space: 10),
              Text("AK PRO MAX LIGHT ,",
                  style: appTextTheme.labelSmall
                      ?.copyWith(color: Colours.blackLite)),
              gap(space: 10),
              Text("Michigan Maize",
                  style: appTextTheme.labelSmall
                      ?.copyWith(color: Colours.primaryText)),
              Expanded(child: SizedBox()),
              Icon(
                Icons.delete_outlined,
                size: 20,
                color: Colours.red,
              )
            ],
          ),
          gap(space: 10),
          Row(
            children: [
              gap(space: 25),
              Text(Strings.box,
                  style: appTextTheme.labelSmall
                      ?.copyWith(color: Colours.greyLight)),
              gap(space: 5),
              Text("15",
                  style: appTextTheme.labelSmall
                      ?.copyWith(color: Colours.blackLite)),
              Expanded(child: SizedBox()),
              Text(Strings.bal,
                  style: appTextTheme.labelSmall
                      ?.copyWith(color: Colours.greyLight)),
              gap(space: 10),
              Text("10.00 kg",
                  style: appTextTheme.labelSmall
                      ?.copyWith(color: Colours.blackLite)),
              gap(space: 50),
            ],
          ),
          // bal form
          gap(space: 10),
          dottedDivider(),
          gap(space: 10),
          Row(
            children: [
              gap(space: 25),
              Expanded(
                  flex: 1,
                  child: TextFieldWithLabel(
                      labelText: "LabelText", hintText: "in kgs")),
              gap(),
              Expanded(
                  flex: 2,
                  child: TextFieldWithLabel(
                      labelText: "Note", hintText: "Add note")),
            ],
          ),
          gap(space: 5),
        ],
      ),
    );
  }

  Widget bottomNavBarButtons() {
    return Container(
      // padding: EdgeInsets.only(bottom: SafeAreaBottomValue(Get.context!)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              height: 40,
              child: PrimaryButton(
                title: Strings.cutAll,
                onTap: () {},
                isFullWidth: false,
                radius: 15,
              )),
          Container(
              height: 40,
              child: PrimaryButton(
                title: Strings.finish,
                color: Colours.greenLight,
                onTap: () {},
                isFullWidth: false,
                radius: 15,
              )),
        ],
      ),
    );
  }
}
