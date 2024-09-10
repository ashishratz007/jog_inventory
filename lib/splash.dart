import 'package:flutter/material.dart';
import 'package:jog_inventory/common/animations/sliding%20container.dart';
import 'package:jog_inventory/common/constant/colors.dart';
import 'package:jog_inventory/common/constant/images.dart';
import 'package:jog_inventory/common/exports/common.dart';
import 'package:jog_inventory/common/globals/global.dart';
import 'package:jog_inventory/common/utils/utils.dart';
import 'package:jog_inventory/common/widgets/imageview.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    checkApp();
    super.initState();
  }

  checkApp() {
    Future.delayed(Duration(seconds: 2), () {
      Get.toNamed(globalData.authToken == null
          ? AppRoutesString.login
          : AppRoutesString.home);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colours.secondary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 300,
            width: 300,
            child: Lottie.asset(
              'assets/splash.json',
              controller: _controller,
              onLoaded: (composition) {
                // Configure the AnimationController with the duration of the
                // Lottie file and start the animation.
                _controller
                  ..duration = composition.duration
                  ..forward();
              },
            ),
          ),
          // Container(
          //   color: Colours.secondary,
          //   padding: EdgeInsets.only(top: 50, bottom: 50),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: [
          //           Stack(
          //             alignment: Alignment.center,
          //             children: [
          //               Container(
          //                 height: 35 * 4,
          //                 width: 200,
          //                 child: Stack(
          //                   children: [
          //                     ...List.generate(
          //                         4,
          //                         (index) => Positioned(
          //                               top: index * 35,
          //                               child: Container(
          //                                 width: 200,
          //                                 child: Row(
          //                                   mainAxisAlignment: index % 2 == 0
          //                                       ? MainAxisAlignment.start
          //                                       : MainAxisAlignment.end,
          //                                   children: [
          //                                     FixedPositionAnimatedWidthContainer(
          //                                         duration: Duration(
          //                                             milliseconds: 700),
          //                                         minWidth: 0,
          //                                         maxWidth: 200,
          //                                         height: 35,
          //                                         angle: -10,
          //                                         reverseAnimation: false,
          //                                         alignment:
          //                                             Alignment.centerLeft,
          //                                         decoration: BoxDecoration(
          //                                           color: Colors.white,
          //                                           borderRadius:
          //                                               BorderRadius.circular(
          //                                                   0),
          //                                         )),
          //                                   ],
          //                                 ),
          //                               ),
          //                             )),
          //                   ],
          //                 ),
          //               ),
          //               Align(
          //                   alignment: Alignment.topCenter,
          //                   child: Column(
          //                     children: [
          //                       FadeAnimation(
          //                           child: displayAssetImage(
          //                               imagePath: images.splashLogo,
          //                               height: 80,
          //                               width: 80)),
          //                       gap(space: 5),
          //                       Visibility(
          //                         visible: visibility,
          //                         child: Stack(
          //                           children: [
          //                             CustomRowAnimation(
          //                               start:
          //                                   30.0, // Starting point in the Row (e.g., from the left edge)
          //                               end:
          //                                   51.0, // Ending point in the Row (e.g., 200 pixels to the right)
          //                               duration: Duration(
          //                                   seconds: 1), // Animation duration
          //                               child: Center(
          //                                   child: Text('TORY',
          //                                       style: TextStyle(
          //                                           fontWeight: FontWeight.bold,
          //                                           fontSize: 14))),
          //                             ),
          //                             CustomRowAnimation(
          //                               start:
          //                                   120.0, // Starting point in the Row (e.g., from the left edge)
          //                               end:
          //                                   5.0, // Ending point in the Row (e.g., 200 pixels to the right)
          //                               duration: Duration(seconds: 1), // Animation duration
          //                               child: Center(
          //                                   child: Text('INVEN',
          //                                       style: TextStyle(
          //                                           fontWeight: FontWeight.bold,
          //                                           fontSize: 14))),
          //                             ),
          //                           ],
          //                         ),
          //                       ),
          //                       Visibility(
          //                         visible: !visibility,
          //                         child: Stack(
          //                           children: [
          //                             CustomRowAnimation(
          //                               start:
          //                                   0.0, // Starting point in the Row (e.g., from the left edge)
          //                               end:
          //                                   51.0, // Ending point in the Row (e.g., 200 pixels to the right)
          //                               duration: Duration(
          //                                   seconds: 2), // Animation duration
          //                               child: Center(
          //                                   child: Text('',
          //                                       style: TextStyle(
          //                                           fontWeight: FontWeight.bold,
          //                                           fontSize: 14))),
          //                             ),
          //                             CustomRowAnimation(
          //                               start:
          //                                   200.0, // Starting point in the Row (e.g., from the left edge)
          //                               end:
          //                                   5.0, // Ending point in the Row (e.g., 200 pixels to the right)
          //                               duration: Duration(
          //                                   seconds: 2), // Animation duration
          //                               child: Center(
          //                                   child: Text('',
          //                                       style: TextStyle(
          //                                           fontWeight: FontWeight.bold,
          //                                           fontSize: 14))),
          //                             ),
          //                           ],
          //                         ),
          //                       ),
          //                     ],
          //                   ))
          //             ],
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
