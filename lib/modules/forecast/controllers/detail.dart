import 'package:jog_inventory/common/utils/error_message.dart';
import 'package:jog_inventory/modules/forecast/models/detail.dart';
import 'package:jog_inventory/modules/forecast/models/forecast_list.dart';
import '../../../common/exports/main_export.dart';

class ForeCastDetailController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isBusy = false.obs;
  late int id;
  late ForecastDetail detail;

  @override
  void onInit() {
    id = Get.arguments[appKeys.forecastId];
    getForecastDetail();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  /// functions
  getForecastDetail() {
    isLoading.value = true;
    ForecastListModel.fetch(id.toString()).then((val) {
      isLoading.value = false;
      detail = val;
    }).onError((error, trace) {
      isLoading.value = false;
      displayErrorMessage(Get.context!,
          error: error, trace: trace, onRetry: getForecastDetail);
    });
  }

  /// get and register controller
  static ForeCastDetailController getController() {
    var isRegistered = Get.isRegistered<ForeCastDetailController>();
    if (isRegistered) {
      return Get.find<ForeCastDetailController>();
    }
    return Get.put<ForeCastDetailController>(ForeCastDetailController());
  }

  /// api calls
}
