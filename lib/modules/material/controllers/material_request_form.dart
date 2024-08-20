import '../../../common/exports/main_export.dart';

class MaterialRequestFormController extends GetxController {
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
  static MaterialRequestFormController getController() {
    var isRegistered = Get.isRegistered<MaterialRequestFormController>();
    if (isRegistered) {
      return Get.find<MaterialRequestFormController>();
    }
    return Get.put<MaterialRequestFormController>(MaterialRequestFormController());
  }

/// api calls
}
