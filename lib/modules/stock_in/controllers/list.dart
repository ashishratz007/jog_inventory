import '../../../common/exports/main_export.dart';

class StockInListController extends GetxController {
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
  static StockInListController getController() {
    var isRegistered = Get.isRegistered<StockInListController>();
    if (isRegistered) {
      return Get.find<StockInListController>();
    }
    return Get.put<StockInListController>(StockInListController());
  }

  /// api calls
}
