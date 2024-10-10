import '../../../common/exports/main_export.dart';

class ForeCastListController extends GetxController {
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
  static ForeCastListController getController() {
    var isRegistered = Get.isRegistered<ForeCastListController>();
    if(isRegistered){
      return Get.find<ForeCastListController>();
    }
    return Get.put<ForeCastListController>(ForeCastListController());
  }

/// api calls

}