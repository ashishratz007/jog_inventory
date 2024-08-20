import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jog_inventory/modules/home/widgets/home_drawer.dart';

import '../exports/main_export.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final Widget? titleWidget;
  final Widget body;
  final Widget? trailingButton;
  final bool hasDrawer;
  final bool hasNotification;
  final Widget? bottomNavBar;
  final Function()? onGestureTap;
  final String? selectedValue;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CustomAppBar(
      {required this.title,
      required this.body,
      this.trailingButton,
      this.titleWidget,
      this.hasDrawer = false,
      this.hasNotification = false,
      this.bottomNavBar,
      this.onGestureTap,
      this.selectedValue,
      super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: (Get.currentRoute.split("/").length > 2),
      onPopInvoked: (bool value) async {
        if (!value)
          deleteItemPopup(
            context,
            onDelete: (v) async {
              SystemNavigator.pop();
            },
            title: "System",
            subTitle: "Are you sure you want to close the app?",
            buttonText: "Close",
          );
      },
      child: GestureDetector(
        onTap: () {
          if (onGestureTap != null) onGestureTap!();
          hideKeyboard(context);
        },
        child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colours.bgColor,
            drawer: hasDrawer ? HomeDrawerWidget() : null,
            appBar: appbar(),
            body: SafeArea(child: body),
            bottomNavigationBar: Visibility(
                visible: bottomNavBar != null,
                child: Container(
                    height: 70,
                    padding: EdgeInsets.only(right: 16, left: 16),
                    child: bottomNavBar))),
      ),
    );
  }

  /// App bar
  PreferredSize appbar() {
    var top = SafeAreaTopValue(Get.context);
    return PreferredSize(
      preferredSize: Size(Get.width, 70),
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: top - 10),
        height: 70 + top, // safe area
        decoration: BoxDecoration(
            color: Colours.secondary,
            // borderRadius: BorderRadius.only(
            //   bottomLeft: Radius.circular(30),
            //   bottomRight: Radius.circular(30),
            // ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(
                    2, 3), // This controls the vertical position of the shadow
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// leading widget
            ...[
              /// drawer icon in case of drawer
              if (hasDrawer)
                IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    size: 30,
                    color: Colors.white,
                  ),
                ),

              /// back button in case the of navigation or absence of drawer widget

              if (!hasDrawer)
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back_ios_new,
                        color: Colors.white, size: 22),
                  ),
                ),
            ],

            /// title
            titleWidget ??
                Text(title,
                    style:
                        appTextTheme.titleLarge?.copyWith(color: Colours.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),

            /// trailing button .
            /// implemented size box so that we can have title at center everytime

            if (trailingButton != null) trailingButton!,
            hasNotification
                ? Icon(
                    Icons.notifications_outlined,
                    size: 30,
                    color: Colors.white,
                  )
                : SizedBox(width: 42),
            // Container(
            //     margin: EdgeInsets.only(left: 15),
            //     padding:
            //     EdgeInsets.only(left: 7, right: 7, top: 7, bottom: 7),
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(100),
            //         color: Colors.black),
            //     child: Icon(Icons.notifications_none, size: 22,color: Colors.white)),
          ],
        ),
      ),
    );
  }

  /// bg with logo
  Widget background() {
    return Container(
      width: Get.width,
      height: Get.height,
      child: Center(child: Image.asset("assets/images/bg_logo.png")),
    );
  }
}
