import '../../../common/exports/main_export.dart';

class StockInDetailController extends GetxController {
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
  static StockInDetailController getController() {
    var isRegistered = Get.isRegistered<StockInDetailController>();
    if(isRegistered){
      return Get.find<StockInDetailController>();
    }
    return Get.put<StockInDetailController>(StockInDetailController());
  }

/// api calls

}