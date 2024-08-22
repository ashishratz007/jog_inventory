import '../../../common/exports/main_export.dart';

class NoCodeRequestController extends GetxController {
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
  static NoCodeRequestController getController<T>() {
    var isRegistered = Get.isRegistered<NoCodeRequestController>();
    if(isRegistered){
      return Get.find<NoCodeRequestController>();
    }
    return Get.put<NoCodeRequestController>(NoCodeRequestController());
  }

/// api calls

}