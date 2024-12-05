import 'package:jog_inventory/common/utils/error_message.dart';
import 'package:jog_inventory/modules/forecast/models/forecast_list.dart';
import '../../../common/exports/main_export.dart';

class ForeCastListController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isBusy = false.obs;
  RxInt page = 1.obs;
  List<ForecastItem> items = [];
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    getForecastList();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  /// functions
  getForecastList() {
    isLoading.value = true;
    ForecastListModel.fetchAll(page.value,searchController.text).then((itm){
      isLoading.value = false;
      items = itm.items;
    }).onError((error, trace){
      isLoading.value = false;
      displayErrorMessage(Get.context!, error: error, trace: trace, onRetry: getForecastList);
    });
    ForecastListModel.fetch("123");
  }


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