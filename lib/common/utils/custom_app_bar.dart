import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jog_inventory/modules/home/widgets/home_drawer.dart';
import 'package:jog_inventory/services/tab_view_navigator.dart';

import '../exports/main_export.dart';

class CustomAppBar extends StatefulWidget {
  final String title;
  final Widget? titleWidget;
  final Widget Function(BuildContext context) body;
  final Widget? trailingButton;
  final bool hasDrawer;
  final bool hasNotification;
  final Widget? bottomNavBar;
  final Function()? onGestureTap;
  final Function()? onBack;
  final String? selectedValue;

  CustomAppBar(
      {required this.title,
      required this.body,
      this.trailingButton,
      this.titleWidget,
      this.hasDrawer = false,
      this.hasNotification = false,
      this.bottomNavBar,
      this.onGestureTap,
      this.onBack,
      this.selectedValue,
      super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

        if (widget.onBack != null) widget.onBack!();
      },
      child: GestureDetector(
        onTap: () {
          if (widget.onGestureTap != null) widget.onGestureTap!();
          hideKeyboard(context);
        },
        child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colours.bgColor,
            drawer: (widget.hasDrawer && !config.isTablet)
                ? HomeDrawerWidget()
                : null, // hide for tab and deep navigation
            appBar: appbar(),
            body: SafeArea(child: widget.body(context)),
            bottomNavigationBar: widget.bottomNavBar == null
                ? null
                : Visibility(
                    visible: widget.bottomNavBar != null,
                    child: SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                              constraints: BoxConstraints(
                                maxHeight: 300,
                                minHeight: 70,
                              ),
                              decoration: BoxDecoration(
                                  color: Colours.white,
                                  boxShadow: containerShadow(
                                    bottom: false,
                                    left: false,
                                    right: false,
                                  )),
                              padding: EdgeInsets.only(right: 16, left: 16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  widget.bottomNavBar!,
                                ],
                              )),
                        ],
                      ),
                    ))),
      ),
    );
  }

  /// App bar
  PreferredSize appbar() {
    var top = SafeAreaTopValue(Get.context!);
    return PreferredSize(
      preferredSize: Size(Get.width, 70),
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: top - 10),
        height: config.isIOS ? 100 : 80, // safe area
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
              if (widget.hasDrawer && !config.isTablet)
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

              if (!widget.hasDrawer)
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      mainNavigationService.pop();
                    },
                    child:
                        Icon(Icons.arrow_back, color: Colors.white, size: 28),
                  ),
                ),
              if(config.isTablet) SizedBox()
            ],

            /// title
            widget.titleWidget ??
                Text(widget.title,
                    style:
                        appTextTheme.titleLarge?.copyWith(color: Colours.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),

            /// trailing button .
            /// implemented size box so that we can have title at center everytime

            if (widget.trailingButton != null) widget.trailingButton!,
            if (widget.hasNotification)
              Icon(
                Icons.notifications_outlined,
                size: 30,
                color: Colors.white,
              ),
            if (!widget.hasNotification && (widget.trailingButton == null))
              SizedBox(width: 42),
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
