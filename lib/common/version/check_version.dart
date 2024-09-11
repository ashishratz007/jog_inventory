// import 'package:app_version_update/app_version_update.dart';
// import 'package:app_version_update/data/models/app_version_result.dart';
import '../exports/main_export.dart';

class _AppUpdater {
  final appleId = '6636480918';
  final playStoreId = 'com.jogdigitialinnovations.inventory';

  ///IOS perms
  // 	<key>NSAppTransportSecurity</key>
  //         <dict>
  //           <key>NSAllowsArbitraryLoads</key><true/>
  //         </dict>

  Future<void> checkForUpdate() async {
    return;
    await Future.delayed(Duration(seconds: 2));
    // AppVersionUpdate.showAlertUpdate(
    //     appVersionResult: AppVersionResult(appleId: appleId, canUpdate: true,platform: TargetPlatform.iOS,playStoreId: playStoreId,storeVersion: "1.0.1",storeUrl: "here"), context: Get.context!);
    //
    // await AppVersionUpdate.checkForUpdates(
    //
    //         appleId: appleId, playStoreId: playStoreId)
    //     .then((data) async {
    //   print(data.storeUrl);
    //   print(data.storeVersion);
    //   // if (data.canUpdate!) {
    //     //showDialog(... your custom widgets view)
    //     //or use our widgets
    //     // AppVersionUpdate.showAlertUpdate
    //     // AppVersionUpdate.showBottomSheetUpdate
    //     // AppVersionUpdate.showPageUpdate
    //     AppVersionUpdate.showAlertUpdate(
    //         appVersionResult: AppVersionResult(appleId: appleId, canUpdate: true,platform: TargetPlatform.iOS,playStoreId: playStoreId,storeVersion: "1.0.1",storeUrl: "here"), context: Get.context!);
    //   // }
    // });
  }
}

var appUpdater = _AppUpdater();
