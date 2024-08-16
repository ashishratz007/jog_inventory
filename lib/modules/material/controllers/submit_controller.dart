import '../../../common/exports/main_export.dart';

class SubmitController extends GetxController {
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
  static SubmitController getController() {
    var isRegistered = Get.isRegistered<SubmitController>();
    if(isRegistered){
      return Get.find<SubmitController>();
    }
    return Get.put<SubmitController>(SubmitController());
  }

/// api calls

}