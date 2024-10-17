import 'package:jog_inventory/common/utils/error_message.dart';
import '../../../common/exports/main_export.dart';
import '../../no_code/models/stck_in_list.dart';

class StockInListController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isBusy = false.obs;

  RxList<StockInModel> items = <StockInModel>[].obs;
  RxList<StockInModel> _items = <StockInModel>[].obs;
  TextEditingController editingController = TextEditingController();



  @override
  void onInit() {
    getData();
    super.onInit();
  }


  search(){
    if(editingController.text.trim() == ""){
      items.value = _items;
    }
    else
    items.value = _items.where((item)=> (item.supplierName?.toLowerCase().contains(editingController.text.toLowerCase()))??false).toList();
  }

  /// functions
  getData() {
    _items.value = [];
    isLoading.value = true;
    StockInModel.fetchAll().then((value) {
      _items.value = value;
      items.value = _items;
      isLoading.value = false;
    }).onError((error, trace) {
      isLoading.value = false;
      displayErrorMessage(
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

}
