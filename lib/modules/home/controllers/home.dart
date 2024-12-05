import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jog_inventory/common/constant/enums.dart';
import 'package:jog_inventory/common/globals/app_version.dart';
import 'package:jog_inventory/common/globals/global.dart';
import 'package:jog_inventory/common/permissson/permission.dart';
import 'package:jog_inventory/common/utils/error_message.dart';
import 'package:jog_inventory/modules/material/models/material_request.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../common/client/app_version.dart';
import '../../../common/client/location.dart';
import '../../../common/exports/main_export.dart';
import '../../material/models/material_request_detail.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isBusy = false.obs;

  @override
  void onInit() {
    // appLocation.init();
    if (config.isDebugMode) {
      debugPrint("=" * 100);
      debugPrint(globalData.authToken);
      debugPrint("=" * 100);
    }
    super.onInit();
  }

  @override
  void onReady() {
    getAppVersion();
    super.onReady();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  getAppVersion() async {
    checkAppVersion.checkForVersion().onError((e, trace) async {
      displayErrorMessage(Get.context!,
          error: e,
          trace: trace,
          onRetry: getAppVersion,
          barrierDismissible: false);
    });
  }

  /// functions
  Future<MaterialRQItem> getScanQrCodeData() async {
    try {
      var result = await BarcodeScanner.scan();

      var ids = result.rawContent.split(" ");
      if (ids.length != 1) {
        print(ids.length);
        var pacId = ids[0];
        var fabId = ids[1];

        if (fabId.isNotEmpty) {
          var scanDetailsModal =
              await MaterialRequestDetail.getDetails(fabId, pacId);
          var data = scanDetailsModal.data!;
          var fabric = scanDetailsModal.data!.fabric!;
          return MaterialRQItem(
            balanceAfter: "${fabric.fabricBalance!}",
            balanceBefore: "${fabric.fabricBalance!}",
            catNameEn: "${fabric.catId?.catNameEn!}",
            fabricBalance: fabric.fabricBalance ?? 0.0,
            fabricBox: "${fabric.fabricBox ?? "_"}",
            fabricColor: "${fabric.fabricColor ?? ""}",
            fabricId: fabric.fabricId!,
            fabricNo: "${fabric.catId?.catNameEn!}",
            catCode: "${fabric.catId?.catCode!}",
            catId: fabric.catId?.catId!,
          );
        } else {
          errorSnackBar(message: "Invalid QR try again");
          throw "Invalid QR try again";
        }
      }
      throw "Invalid QR try again";
    } catch (e, trace) {
      errorSnackBar(message: "Unable to get data from QR");
      throw "Unable to get data from QR";
    }
  }

  RxBool isGettingLocation = false.obs;
  checkLocation() async {
    isGettingLocation.value = true;
    appLocation.init(onDone: _homeScanQrCode).then((onValue) {
      isGettingLocation.value = false;
    }).onError((e, trace) async {
      isGettingLocation.value = false;
      displayErrorMessage(
        Get.context!,
        error: "Location error please try again",
        trace: trace,
        onRetry: checkLocation,
      );
    });
  }

  _homeScanQrCode() async {
    // PermissionStatus status = await Permission.camera.status;
    // if(PermissionStatus.permanentlyDenied == status ||  status == PermissionStatus.denied){
    //   permission.showPermissionPopup("Camera permission required to perform this operation.", (){
    //      Geolocator.openAppSettings();
    //   });
    //   return;
    // }
    isGettingLocation.value = false;
    var result = await BarcodeScanner.scan();
    print(result);
    if(result.rawContent.contains(ScanBarcodeType.assets.key) ){
      var ids = result.rawContent.split(" ");
      if (ids.length >= 1) {
        print(ids.length);
        var assetId;
        var type;
        if (ids.length == 1) {
          assetId = ids.firstOrNull;
        } else {
          assetId = ids[0];
          type = ids[1];
        }
        if (assetId.isNotEmpty) {
          mainNavigationService.push(AppRoutesString.assetsDetailById,
              arguments: {appKeys.assetId: assetId});
        } else {
          errorSnackBar(message: "Unable to get data from QR");
        }
      }
    }
    /// for material
    else {
      var ids = result.rawContent.split(" ");
      if (ids.length >= 1) {
        print(ids.length);
        var pacId;
        var fabId;
        if (ids.length == 1) {
          fabId = ids.firstOrNull;
        } else {
          pacId = ids[0];
          fabId = ids[1];
        }
        if (fabId.isNotEmpty) {
          mainNavigationService.push(AppRoutesString.materialDetailById,
              arguments: {appKeys.fabId: fabId, appKeys.pacId: pacId});
        } else {
          errorSnackBar(message: "Unable to get data from QR");
        }
      }

      /// only for fabId
      else {
        errorSnackBar(message: "Unable to get data from QR");
      }
    }
  }

  /// get and register controller
  static HomeController getController() {
    var isRegistered = Get.isRegistered<HomeController>();
    if (isRegistered) {
      return Get.find<HomeController>();
    }
    return Get.put<HomeController>(HomeController());
  }

  /// api calls
}

/*
//[YourClassName] change your class name from here
class YourClassName extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isBusy = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
/// functions
/// get and register controller
static RegisterController getController() {
var isRegistered = Get.isRegistered<RegisterController>();
if(isRegistered){
return Get.find<RegisterController>();
}
return Get.put<RegisterController>(RegisterController());
}

/// api calls

}
*/
