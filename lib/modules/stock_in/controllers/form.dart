import 'package:jog_inventory/common/utils/date_formater.dart';
import 'package:jog_inventory/common/utils/error_message.dart';
import 'package:jog_inventory/modules/no_code/models/stock_in_form.dart';
import 'package:jog_inventory/modules/stock_in/models/po_order.dart';
import 'package:jog_inventory/modules/stock_in/models/stock_in.dart';
import '../../../common/exports/main_export.dart';

class StockInFormController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isBusy = false.obs;
  RxBool isCheck = false.obs;
  RxBool isAddStock = true.obs;

  RxList<ForecastReceivedModel> receivedItems = <ForecastReceivedModel>[].obs;
  int get receivedCount =>
      (receivedItems.where((item) => !item.isReceive).length);
  bool get hasItems => receivedItems.length != 0;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  PoOrderModel? selectedPo;

  String? PODate;

  RxList<StockInFormItem> items = <StockInFormItem>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  /// functions

  resetCheck() {
    isCheck.value = false;
  }

  addItems(List<StockInFormItem> list) {
    items.addAll(list);
    items.refresh();
    resetCheck();
  }

  /// api calls
  getItems({bool refresh = true}) async {
    if (refresh) {
      isAddStock.value = true;
    }
    receivedItems.clear();
    if (selectedPo == null) return;
    ForecastReceivedModel.fetchAll(selectedPo!.forId!).then((value) {
      receivedItems.clear();
      receivedItems.value = value;
      isAddStock.refresh();
    }).onError((error, trace) {
      showErrorMessage(Get.context!,
          error: error, trace: trace, onRetry: getItems);
    });
  }

  RxSet<int> loadingForCastIds = <int>{}.obs;

  onReceived(ForecastReceivedModel received) async {
    if (received.receiveKg?.isEmpty ?? true) {
      errorSnackBar(message: "Please enter received data");
      return;
    }
    loadingForCastIds.add(received.forItemId!);
    ReceivedModel()
        .received(received.forItemId!.toString(), received.receiveKg!)
        .then((va) {
      loadingForCastIds.remove(received.forItemId!);
      loadingForCastIds.refresh();
      getItems(refresh: false);
      hideKeyboard(Get.context!);
    }).onError((err, trace) {
      errorSnackBar(message: "Unable to process data try again!");
      loadingForCastIds.add(received.forItemId!);
    });
  }

  /// on check
  onCheck() {
    if (formKey.currentState?.validate() ?? false) {
      if (items.length == 0) {
        errorSnackBar(message: "Please select items.");
        return;
      }
      isBusy.value = true;
      var detail = StockInFormModel(
        items: items,
        supplierId: selectedPo!.supplierId!,
        forId: selectedPo!.forId!,
        newInvNo: "",
        poDate: PODate!,
        stockDate: dateTimeFormat.yyMMDDFormat(selectedPo!.poDate!)!,
        supplierName: selectedPo!.supplier!,
      );
      StockInFormModel.check(detail).then(
        (va) {
          isBusy.value = false;
          Get.back();
          successSnackBar(message: "Item added.");
          Get.to(AppRoutesString.stockInList);
        },
      ).onError(
        (err, trace) {
          isBusy.value = false;
          errorSnackBar(message: err.toString());
        },
      );
    }
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
