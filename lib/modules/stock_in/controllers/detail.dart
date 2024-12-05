import 'dart:ffi';

import 'package:jog_inventory/common/utils/error_message.dart';
import 'package:jog_inventory/modules/stock_in/models/stock_in_list.dart';
import 'package:jog_inventory/modules/stock_in/models/stock_in_statics.dart';
import 'package:jog_inventory/services/tab_view_navigator.dart';

import '../../../common/exports/main_export.dart';

class StockInDetailController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isBusy = false.obs;

  late String pacId;
  StockInDetailModel stockInData = StockInDetailModel();

  @override
  void onInit() {
    readArgs();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  /// functions
  readArgs() {
    pacId = mainNavigationService.arguments[appKeys.pacId];
    getData();
  }

  /// api calls

  /// get data
  getData() {
    isLoading.value = true;
    StockInDetailModel.fetch(pacId).then((value) {
      isLoading.value = false;
      stockInData = value;
    }).onError((error, trace) {
      isLoading.value = false;
      displayErrorMessage(Get.context!,
          error: error,
          trace: trace,
          onRetry: getData,
          barrierDismissible: false);
    });
  }

  /// post Invoice data
  postInvoiceData(BuildContext context, String val) {
    var data = SetInvoiceModel(invoice: val, pac_id: pacId);
    data.create().then((value) {
      stockInData.packing?.invNo = val;
      isLoading.refresh();
      mainNavigationService.back(context);
      successSnackBar(message: "Invoice Updated.");
    }).onError((error, trace) {
      errorSnackBar(message: "Please try again");
    });
  }

  editPrice(BuildContext context, String price, bool isAll, String itemId) {
    if (double.tryParse(price) != null)
    {
      String ids = itemId;
      if (isAll) {
        ids = stockInData.fabrics!
            .map((item) => item.fabric_id!)
            .toList()
            .join(",");
      }
        var data = SetAmountModel(fabric_id_list: ids, new_unit_price: price);
        /// request
        data.create().then((value) {
          if (isAll) {
            stockInData.fabrics!.forEach(
                (item) => item.fabricInPrice = double.tryParse(price) ?? 0.0);
          } else {
            var item = stockInData.fabrics
                ?.where((item) => "${item.fabric_id}" == itemId).firstOrNull;
            if (item != null) {
              item.fabricInPrice = double.tryParse(price) ?? 0.0;
            }
          }
          isLoading.refresh();
          mainNavigationService.back(context);
          successSnackBar(message: "Price Updated.");
        }).onError((error, trace) {
          errorSnackBar(message: "Please try again");
        });
    }
    else {
      errorSnackBar(message: "Invalid amount");
    }
  }

  /// get and register controller
  static StockInDetailController getController() {
    var isRegistered = Get.isRegistered<StockInDetailController>();
    if (isRegistered) {
      return Get.find<StockInDetailController>();
    }
    return Get.put<StockInDetailController>(StockInDetailController());
  }
}
