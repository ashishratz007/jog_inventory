import 'package:jog_inventory/common/utils/error_message.dart';
import 'package:jog_inventory/modules/stock_in/models/po_order.dart';
import '../../../common/exports/main_export.dart';

class StockInFormController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isBusy = false.obs;
  RxBool isAddStock = true.obs;

  RxList<ForecastReceivedModel> receivedItems = <ForecastReceivedModel>[].obs;
  int get receivedCount =>
      (receivedItems.where((item) => !item.isReceive).length);
  bool get hasItems => receivedItems.length != 0;

  PoOrderModel? selectedPo;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  /// functions

  /// api calls
  getItems() async {
    isAddStock.value = true;
    receivedItems.clear();
    if (selectedPo == null) return;
    ForecastReceivedModel.fetchAll(selectedPo!.forId!).then((value) {
      receivedItems.value = value;
    }).onError((error, trace) {
      showErrorMessage(Get.context!,
          error: error, trace: trace, onRetry: getItems);
    });
  }

  onReceived(ForecastReceivedModel item) async {
    isBusy.value = true;
    await delay(2);
    isBusy.value = false;
  }

  /// get and register controller
  static StockInFormController getController() {
    var isRegistered = Get.isRegistered<StockInFormController>();
    if (isRegistered) {
      return Get.find<StockInFormController>();
    }
    return Get.put<StockInFormController>(StockInFormController());
  }
}
