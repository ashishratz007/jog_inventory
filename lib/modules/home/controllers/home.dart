import 'package:barcode_scan2/platform_wrapper.dart';

import '../../../common/exports/main_export.dart';

class HomeController extends GetxController {
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
  scanQrCode() async {
    var result = await BarcodeScanner.scan();

    var ids = result.rawContent.split(" ");
    if (ids.length == 0) return;
    var pacId = ids[0];
    var fabId = ids[1];

    if (fabId.isNotEmpty) {
      Get.toNamed(AppRoutesString.materialDetailById,
          arguments: {appKeys.fabId: fabId, appKeys.pacId: pacId});
    } else {
      errorSnackBar(message: "Unable to get data from QR");
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
