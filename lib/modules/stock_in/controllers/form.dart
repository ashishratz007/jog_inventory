import '../../../common/exports/main_export.dart';

class StockInFormController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isBusy = false.obs;
  RxBool isAddStock = true.obs;

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
  static StockInFormController getController() {
    var isRegistered = Get.isRegistered<StockInFormController>();
    if (isRegistered) {
      return Get.find<StockInFormController>();
    }
    return Get.put<StockInFormController>(StockInFormController());
  }

  /// api calls
}
