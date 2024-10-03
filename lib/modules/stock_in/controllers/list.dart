import 'package:jog_inventory/common/utils/error_message.dart';
import 'package:jog_inventory/modules/no_code/models/stock_in_form.dart';

import '../../../common/exports/main_export.dart';
import '../../no_code/models/stck_in_list.dart';

class StockInListController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isBusy = false.obs;

  RxList<StockInModel> items = <StockInModel>[].obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  /// functions
  getData() {
    isLoading.value = true;
    StockInModel.fetchAll().then((value) {
      items.value = value;
      isLoading.value = false;
    }).onError((error, trace) {
      isLoading.value = false;
      showErrorMessage(
        Get.context!,
        error: error,
        trace: trace,
        onRetry: getData,
      );
    });
  }

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
