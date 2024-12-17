import 'package:jog_inventory/common/animations/animated_switcher.dart';
import 'package:jog_inventory/common/animations/small_to_large.dart';
import 'package:jog_inventory/common/globals/global.dart';
import 'package:jog_inventory/modules/auth/models/user_login.dart';
import 'package:jog_inventory/modules/home/controllers/home.dart';
import 'package:jog_inventory/services/tab_view_navigator.dart';
import '../../../common/exports/main_export.dart';

class HomeDrawerWidget extends Drawer {
  HomeDrawerWidget({super.key});
  HomeController get homeController => Get.find<HomeController>();
  // late var setState;
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shadowColor: Colors.white,
      width: 320,
      child: SideBarWidget(
        selectedValue: selectedValue,
      ),
    );
  }
}

class SideBarWidget extends StatefulWidget {
  String? selectedValue;
  SideBarWidget({super.key, this.selectedValue});

  @override
  State<SideBarWidget> createState() => _SideBarWidgetState();
}

class _SideBarWidgetState extends State<SideBarWidget> {
  RxString selectedValue = "Dash Board".obs;
  bool isExpanded = true; // Tracks whether the sidebar is expanded

  @override
  void initState() {
    selectedValue.value = widget.selectedValue ?? "Dash Board";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: !config.isTablet
            ? null
            : () {
                setState(() {
                  isExpanded = !isExpanded; // Toggle expansion state on tap
                });
              },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300), // Animation duration
          width: isExpanded ? 300 : 100,
          child: Drawer(
            shadowColor: Colors.white,
            child: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  color: Colours.bgGrey,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: AppPadding.inner,
                      height: 93,
                      decoration: BoxDecoration(
                        color: Colours.secondary,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Shadow color
                            // How far the shadow spreads horizontally
                            spreadRadius: 2,
                            blurRadius: 3, // The blur effect of the shadow
                            // Offset of the shadow (x, y) - positive y for bottom shadow
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (!isExpanded)
                            Container(
                                key: Key(DateTime.now()
                                    .microsecondsSinceEpoch
                                    .toString()),
                                child: SmallToLargeAnimation(
                                  child: displayAssetsWidget(
                                    AppIcons.double_arrow,
                                    width: 35
                                  ),
                                  duration: Duration(milliseconds: 700),
                                )),
                          if (isExpanded) ...[
                            SmallToLargeAnimation(
                              duration: Duration(milliseconds: 300),
                              child: CircleAvatar(
                                radius: 30,
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colours.primary,
                                ),
                              ),
                            ),
                            gap(space: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hi, ${globalData.activeUser?.employeeName ?? "_"}",
                                    style: appTextTheme.titleSmall
                                        ?.copyWith(color: Colours.white),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  gap(space: 5),
                                  Text(
                                    "${globalData.activeUser?.employeeEmail ?? "_"}",
                                    style: appTextTheme.labelSmall
                                        ?.copyWith(color: Colours.white),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                            // gap(space: 5),

                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colours.white,
                              size: 20,
                            ),
                          ],
                        ],
                      ),
                    ),
                    gap(space: 10),

                    /// dashboard
                    if (config.isTablet)
                      drawerTile(
                        context,
                        paddingLeft: 5,
                        leading: Container(
                            child: Icon(
                              Icons.dashboard,
                              color: Colours.greyLight,
                              size: isExpanded ? 20 : 20,
                            ),
                            width: isExpanded ? 50 : 50,
                            height: isExpanded ? 50 : 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colours.bgGrey,
                            ),
                            padding: EdgeInsets.all(5)),
                        selected: Container(
                            child: Icon(
                              Icons.dashboard,
                              color: Colours.secondary,
                              size: isExpanded ? 20 : 20,
                            ),
                            width: isExpanded ? 50 : 50,
                            height: isExpanded ? 50 : 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colours.secondary.withOpacity(0.2),
                            ),
                            padding: EdgeInsets.all(5)),
                        title: " Dash Board",
                        textColor: Colours.black,
                        hideTrailing: true,
                        onTap: () async {
                          await mainNavigationService
                              .push(AppRoutesString.dashboard, removeAll: true);
                        },
                      ),

                    /// Stock in
                    drawerTile(
                      context,
                      leading: displayAssetsWidget(AppIcons.stock_in_list_un,
                          width: isExpanded ? 50 : 50,
                          height: isExpanded ? 50 : 50,
                          borderRadius: BorderRadius.circular(10),
                          padding: EdgeInsets.all(5)),
                      selected: displayAssetsWidget(AppIcons.stock_in_list_sel,
                          width: isExpanded ? 50 : 50,
                          height: isExpanded ? 50 : 50,
                          fit: BoxFit.contain,
                          borderRadius: BorderRadius.circular(10),
                          padding: EdgeInsets.all(5)),
                      title: "Stock In List",
                      textColor: Colours.black,
                      hideTrailing: true,
                      onTap: () async {
                        await mainNavigationService
                            .push(AppRoutesString.stockInList, removeAll: true);
                      },
                    ),

                    /// Material Rq
                    drawerTile(
                      context,
                      leading: displayAssetsWidget(AppIcons.material_req_un,
                          borderRadius: BorderRadius.circular(10),
                          width: isExpanded ? 50 : 50,
                          height: isExpanded ? 50 : 50,
                          padding: EdgeInsets.all(5)),
                      selected: displayAssetsWidget(AppIcons.material_req_sel,
                          borderRadius: BorderRadius.circular(10),
                          width: isExpanded ? 50 : 50,
                          height: isExpanded ? 50 : 50,
                          padding: EdgeInsets.all(5)),
                      title: "Material RQ list",
                      textColor: Colours.black,
                      hideTrailing: true,
                      onTap: () async {
                        await mainNavigationService.push(
                            AppRoutesString.materialRequestList,
                            removeAll: true);
                      },
                    ),
                    /// Ink list
                    drawerTile(
                      context,
                      leading: displayAssetsWidget(AppIcons.material_req_un,
                          borderRadius: BorderRadius.circular(10),
                          width: isExpanded ? 50 : 50,
                          height: isExpanded ? 50 : 50,
                          padding: EdgeInsets.all(5)),
                      selected: displayAssetsWidget(AppIcons.material_req_sel,
                          borderRadius: BorderRadius.circular(10),
                          // color: Colours.secondary,
                          width: isExpanded ? 50 : 50,
                          height: isExpanded ? 50 : 50,
                          padding: EdgeInsets.all(5)),
                      title: "INK list",
                      textColor: Colours.black,
                      hideTrailing: true,
                      onTap: () async {
                        await mainNavigationService.push(
                            AppRoutesString.inkList,
                            removeAll: true);
                      },
                    ),
                   /// digital paper list
                    drawerTile(
                      context,
                      leading: displayAssetsWidget(AppIcons.material_req_un,
                          borderRadius: BorderRadius.circular(10),
                          width: isExpanded ? 50 : 50,
                          height: isExpanded ? 50 : 50,
                          padding: EdgeInsets.all(5)),
                      selected: displayAssetsWidget(AppIcons.material_req_sel,
                          borderRadius: BorderRadius.circular(10),
                          // color: Colours.secondary,
                          width: isExpanded ? 50 : 50,
                          height: isExpanded ? 50 : 50,
                          padding: EdgeInsets.all(5)),
                      title: "Digital Paper list",
                      textColor: Colours.black,
                      hideTrailing: true,
                      onTap: () async {
                        await mainNavigationService.push(
                            AppRoutesString.digitalPaper,
                            removeAll: true);
                      },
                    ),

                    /// No code
                    drawerTile(
                      context,
                      leading: displayAssetsWidget(AppIcons.no_code_req_un,
                          borderRadius: BorderRadius.circular(10),
                          width: isExpanded ? 50 : 50,
                          height: isExpanded ? 50 : 50,
                          padding: EdgeInsets.all(5)),
                      selected: displayAssetsWidget(AppIcons.no_code_req_sel,
                          borderRadius: BorderRadius.circular(10),
                          width: isExpanded ? 50 : 50,
                          height: isExpanded ? 50 : 50,
                          padding: EdgeInsets.all(5)),
                      title: "No code RQ list",
                      textColor: Colours.black,
                      hideTrailing: true,
                      onTap: () async {
                        await mainNavigationService.push(
                            AppRoutesString.noCodeRequestList,
                            removeAll: true);
                      },
                    ),

                    /// Forecast list
                    drawerTile(
                      context,
                      leading: displayAssetsWidget(AppIcons.forecast_un,
                          width: isExpanded ? 50 : 50,
                          height: isExpanded ? 50 : 50,
                          borderRadius: BorderRadius.circular(10),
                          padding: EdgeInsets.all(5)),
                      selected: displayAssetsWidget(AppIcons.forecast_sel,
                          width: isExpanded ? 50 : 50,
                          height: isExpanded ? 50 : 50,
                          borderRadius: BorderRadius.circular(10),
                          padding: EdgeInsets.all(5)),
                      title: "Forecast list",
                      textColor: Colours.black,
                      hideTrailing: true,
                      onTap: () async {
                        await mainNavigationService.push(
                            AppRoutesString.forecastList,
                            removeAll: true);
                      },
                    ),

                    // setupTiles(),
                    Expanded(child: SizedBox()),
                    Divider(color: Colours.border),

                    /// Log out user
                    drawerTile(
                      context,
                      paddingLeft: 16,paddingRight: 16,
                      leading: Icon(
                        Icons.logout,
                        color: Colors.red,
                        size: isExpanded ? 25 : 50,
                      ),
                      selected: Icon(
                        Icons.logout,
                        color: Colors.red,
                        size: isExpanded ? 25 : 50,
                      ),
                      title: "Logout",
                      textColor: Colors.red,
                      hideTrailing: true,
                      onTap: () async {
                        deleteItemPopup(
                          Get.context!,
                          title: "Logout",
                          subTitle: "Are you sure you want to logout!",
                          buttonText: "Logout",
                          onDelete: (context) async {
                            await UserLoginModel.logoutUser();
                            Get.offAllNamed(AppRoutesString.login);
                          },
                          onComplete: () {
                            successSnackBar(message: "Logout successfully");
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget drawerTile(BuildContext context,
      {required Widget leading,
      required Widget selected,
      double paddingLeft = 0,
      double paddingRight = 0,
      required String title,
      bool hideTrailing = true,
      Color textColor = Colors.black87,
      required Future<void> Function() onTap}) {
    return Obx(
      () => Container(
        // color: (selectedValue == title) ? Colours.primaryBg : null,
        child: ListTile(
          minLeadingWidth: 10,
          contentPadding: EdgeInsets.only(
            left: paddingLeft,
            right: paddingRight,
          ),
          leading: !(selectedValue == title) ? leading : selected,
          title: Visibility(
            visible: isExpanded,
            child: Text(title,
                style: appTextTheme.titleSmall?.copyWith(
                    color: (selectedValue.value == title)
                        ? Colours.secondary
                        : textColor,
                    fontWeight: FontWeight.w600),
            maxLines: 1,
            ),
          ),
          trailing: hideTrailing
              ? null
              : Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                  color: Colors.black,
                ),
          onTap: () async {
            if (selectedValue == title) {
              return;
            }
            selectedValue.value = title;
            await onTap();
            selectedValue.value = "Dash Board";
          },
        ),
      ),
    );
  }

  Widget drawerExpansionWidget(
    String title,
    Widget icon, {
    required List<DrawerItem> children,
  }) {
    return CustomExpansionTile(
      titlePadding: EdgeInsets.only(top: 15, bottom: 5, left: 10),
      childrenPadding: EdgeInsets.zero,
      initialValue: true,
      cancelExpand: true,
      children: [
        ...children
            .map(
              (e) => drawerItemTile(
                title: e.title,
                count: e.count ?? 0,
                onTap: e.onTap,
              ),
            )
            .toList()
      ],
      onChange: (val) {
        // isExpanded.value = val;
      },
      borderColor: Colours.bgGrey,
      childrenBgColor: Colours.bgGrey,
      childrenMargin: EdgeInsets.zero,
      bgColor: Colors.transparent,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          gap(space: 5),
          icon,
          gap(space: 15),
          Text(
            title,
            style: appTextTheme.titleSmall?.copyWith(
              color: Colors.black87,
            ),
            maxLines: 1,
          ),
        ],
      ),
      hideTrailing: true,
    );
  }

  Widget drawerItemTile(
      {required String title,
      required int count,
      required void Function() onTap}) {
    print(selectedValue);
    RxBool isSelected =
        ((selectedValue).trim().toLowerCase() == title.trim().toLowerCase())
            .obs;
    return Obx(
      () => InkWell(
        onTap: () {
          selectedValue.value = title;
          // setState(() {});
          onTap();
        },
        child: Container(
          height: 40,
          padding: EdgeInsets.only(left: 56),
          color: isSelected.value ? Colours.primaryBg : null,
          child: Row(
            children: [
              Text(title,
                  style: appTextTheme.headlineMedium?.copyWith(
                      color: isSelected.value ? Colours.primary : null)),
            ],
          ),
        ),
      ),
    );
  }
}
