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
  String? selectedValue;
  bool isExpanded = true; // Tracks whether the sidebar is expanded

  @override
  void initState() {
    selectedValue = widget.selectedValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded; // Toggle expansion state on tap
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300), // Animation duration
          width: isExpanded ? 320 : 120,
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
                      padding: AppPadding.pagePaddingAll,
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
                        children: [
                          CircleAvatar(
                            radius: isExpanded?20:40,
                            child: CircleAvatar(
                              radius: isExpanded?19:40,
                              backgroundColor: Colours.primary,
                            ),
                          ),
                          if(isExpanded)...[
                            // gap(space: 10),
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
                              size: 15,
                            )
                          ],

                        ],
                      ),
                    ),
                    gap(space: 10),

                    /// Stock in
                    drawerTile(
                      context,
                      leading: displayAssetsWidget(AppIcons.boxes_white,
                          width:  isExpanded?15:40,
                          height:  isExpanded?15:40,
                          borderRadius: BorderRadius.circular(10),
                          color: Colours.blue,
                          padding: EdgeInsets.all(5)),
                      title: "Stock In List",
                      textColor: Colours.black,
                      hideTrailing: true,
                      onTap: () {
                        mainNavigationService.push(AppRoutesString.stockInList);
                      },
                    ),

                    /// Material Rq
                    drawerTile(
                      context,
                      leading: displayAssetsWidget(AppIcons.mat_white,
                          borderRadius: BorderRadius.circular(10),
                          color: Colours.secondary,
                          width:  isExpanded?15:40,
                          height:  isExpanded?15:40,
                          padding: EdgeInsets.all(5)),
                      title: "Material RQ list",
                      textColor: Colours.black,
                      hideTrailing: true,
                      onTap: () {
                        mainNavigationService
                            .push(AppRoutesString.materialRequestList);
                      },
                    ),

                    /// No code
                    drawerTile(
                      context,
                      leading: displayAssetsWidget(AppIcons.no_code,
                          borderRadius: BorderRadius.circular(10),
                          color: Colours.green,
                          width:  isExpanded?15:40,
                          height:  isExpanded?15:40,
                          padding: EdgeInsets.all(5)),
                      title: "No code RQ list",
                      textColor: Colours.black,
                      hideTrailing: true,
                      onTap: () {
                        mainNavigationService
                            .push(AppRoutesString.noCodeRequestList);
                      },
                    ),

                    /// Forecast list
                    drawerTile(
                      context,
                      leading: displayAssetsWidget(AppIcons.future,
                          width:  isExpanded?15:40,
                          height:  isExpanded?15:40,
                          borderRadius: BorderRadius.circular(10),
                          color: Colours.blackMat,
                          padding: EdgeInsets.all(5)),
                      title: "Forecast list",
                      textColor: Colours.black,
                      hideTrailing: true,
                      onTap: () {
                        mainNavigationService
                            .push(AppRoutesString.forecastList);
                      },
                    ),

                    // setupTiles(),
                    Expanded(child: SizedBox()),
                    Divider(color: Colours.border),

                    /// Log out user
                    drawerTile(
                      context,
                      leading: Icon(
                        Icons.logout,
                        color: Colors.red,
                        size: isExpanded?25:50,
                      ),
                      title: "Logout",
                      textColor: Colors.red,
                      hideTrailing: true,
                      onTap: () {
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
      double paddingLeft = 16,
      double paddingRight = 16,
      required String title,
      bool hideTrailing = true,
      Color textColor = Colors.black87,
      required void Function() onTap}) {
    RxBool isSelected = (selectedValue == title).obs;
    return Obx(
      () => Container(
        color: isSelected.value ? Colours.primaryBg : null,
        child: ListTile(
          minLeadingWidth: 10,
          contentPadding: EdgeInsets.only(
            left: paddingLeft,
            right: paddingRight,
          ),
          leading: leading,
          title: Visibility(
            visible: isExpanded,
            child: Text(title,
                style: appTextTheme.titleSmall?.copyWith(
                    color: isSelected.value ? Colours.primary : textColor,
                    fontWeight: FontWeight.w600)),
          ),
          trailing: hideTrailing
              ? null
              : Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                  color: Colors.black,
                ),
          onTap: () {
            // selectedValue = title;
            // setState(() {});
            onTap();
          },
        ),
      ),
    );
  }

  Widget setupTiles() {
    return drawerExpansionWidget(
      "Setup",
      Icon(Icons.settings, color: Colours.greyLight, size: 20),
      children: [
        DrawerItem(
          title: "Supplier",
          count: 0,
          onTap: () {},
        ),
        DrawerItem(
          title: "Position",
          count: 0,
          onTap: () {
            // Get.offAllNamed(AppRoutesString.underReviewCars);
          },
        ),
        DrawerItem(
          title: "Category",
          count: 0,
          onTap: () {
            // Get.offAllNamed(AppRoutesString.approvedCars);
          },
        ),
        DrawerItem(
          title: "Sold",
          count: 0,
          onTap: () {
            // Get.offAllNamed(AppRoutesString.soldCars);
          },
        ),
        DrawerItem(
          title: "Employee",
          count: 0,
          onTap: () {
            // Get.offAllNamed(AppRoutesString.rejectedCars);
          },
        ),
      ],
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
        ((selectedValue)?.trim().toLowerCase() == title.trim().toLowerCase())
            .obs;
    return Obx(
      () => InkWell(
        onTap: () {
          selectedValue = title;
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
