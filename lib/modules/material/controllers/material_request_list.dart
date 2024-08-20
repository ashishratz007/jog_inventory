import '../../../common/exports/main_export.dart';

class MaterialRequestListController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isBusy = false.obs;
  RxBool isProducing = true.obs;

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
  static MaterialRequestListController getController() {
    var isRegistered = Get.isRegistered<MaterialRequestListController>();
    if (isRegistered) {
      return Get.find<MaterialRequestListController>();
    }
    return Get.put<MaterialRequestListController>(MaterialRequestListController());
  }

  /// api calls
}
