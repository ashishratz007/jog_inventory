import 'dart:io';

import '../exports/common.dart';


/// [_Config] class is to get configuration data or variables
class _Config {
  // final baseUrl = 'http://192.168.1.7/salesrep';// local server
  final baseUrl = "https://api.jog-joinourgame.com/inv/";// live server
  final mediaUrl = "https://usedcarautoscan.s3.ap-south-1.amazonaws.com/";
  final uploadUrl = "https://sales-test.jog-joinourgame.com/upload/new_design/";
  final quotationsUploadUrl = "https://sales-test.jog-joinourgame.com/upload/samples/";

  String imageUrl(String imagePath) => mediaUrl + imagePath;

  /// [kIsWeb] is to check that the app is running on web
  bool get isWeb => kIsWeb;
  bool get isIOS => Platform.isIOS;
  bool get isAndroid => Platform.isAndroid;
  bool get isMobile => isIOS || isAndroid;

  // bool get isUserLoggedIn => globalData.authToken != null;

  /// checks the application is opened or not
  bool get isAppInitialized => Get.context != null;

  bool get isDebugMode => kDebugMode;
  bool get isReleaseMode => kReleaseMode;
  // /// currentContext
  // BuildContext get context => Get.context!;


/// actions
 setWalkThrough() {
   storage.configBox.put(appKeys.walkThrough, true,);
 }

 bool getWalkThroughStatus () {
  return storage.configBox.get(appKeys.walkThrough, defaultValue: false);
 }


}

var config = _Config();
