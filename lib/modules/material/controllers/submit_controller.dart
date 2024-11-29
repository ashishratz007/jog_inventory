import 'package:jog_inventory/common/utils/error_message.dart';
import 'package:jog_inventory/modules/material/models/material_request.dart';
import 'package:jog_inventory/modules/material/models/material_request_detail.dart';
import 'package:jog_inventory/modules/material/models/material_rq_form.dart';
import 'package:jog_inventory/modules/material/models/search.dart';
import 'package:jog_inventory/services/tab_view_navigator.dart';
import '../../../common/exports/main_export.dart';
import '../models/material_check.dart';

class SubmitController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isBusy = false.obs;
  RxBool isNewOrder = true.obs;
  late ScanDetailsModal scanDetailsModal;
  late String fabricId;
  late OrderCodeData ethCode;
  late MaterialRQDetailModel materialRqDetail;
  TextEditingController commentController = TextEditingController();
  TextEditingController reRequestController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  MaterialRQItemScan? get oldItem => materialRqDetail.items
      ?.where((item) =>
          item.actions?.fabricId == scanDetailsModal.data?.fabric?.fabricId)
      .firstOrNull;

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
  /// get and register controller
  static SubmitController getController() {
    var isRegistered = Get.isRegistered<SubmitController>();
    if (isRegistered) {
      return Get.find<SubmitController>();
    }
    return Get.put<SubmitController>(SubmitController());
  }

  /// api calls
  readArgs() {
    var args = Get.arguments;
    if (args is Map) {
      ethCode = args[appKeys.ethCode];
      fabricId = args[appKeys.fabId];
      scanDetailsModal = args[appKeys.materialRQScan];
      scanDetailsModal = args[appKeys.materialRQScan];
      getData();
    }
  }

  getData() {
    isLoading.value = true;
    MaterialRQDetailModel.fetch(ethCode.orderLkrTitleId!.toString())
        .then((value) {
      materialRqDetail = value;
      isLoading.value = false;
      if (value.items?.length == null || value.items?.length == 0) {
        isNewOrder.value = true;
      }
      else{
        isNewOrder.value = false;
      }
    }).onError((error, trace) {
      isLoading.value = false;
      displayErrorMessage(Get.context!,
          error: error, trace: trace, onRetry: getData);
    });
  }

  submitRequest() {
    if ((formKey.currentState?.validate() ?? false) == false) {
      return;
    }
    isBusy.value = true;

    /// New order
    if (isNewOrder.value) {
      MaterialRqFormModel(
        items: [
          MaterialRQItem(fabricId: int.tryParse(fabricId)),
        ],
        order_code: ethCode.orderTitle!,
        order_lkr_title_id: ethCode.orderLkrTitleId!,
        balance_after: ((double.tryParse(
                        "${scanDetailsModal.data?.fabric?.fabricBalance ?? 0.0}") ??
                    0.0) -
                (double.tryParse(qtyController.text) ?? 0.0))
            .toString(),
        item_note: commentController.text,
      ).addForm().then((val) {
        mainNavigationService.pop();
        mainNavigationService.pop();
        successSnackBar(message: "Success");
        isBusy.value = false;
      }).onError((e, trace) {
        isBusy.value = false;
      });
    }

    /// OLD order
    else {
      List<String> codes = [];
      materialRqDetail.items?.forEach((item) {
        /// TODO
        if (item.actions?.fabricId != null) {}
        codes.add(item.actions?.fabricId?.toString() ?? "");
      });
      MaterialRQDetailModel.updateRequest(
              materialRqDetail.rqId.toString(), codes)
          .then((val) {
        mainNavigationService.pop();
        mainNavigationService.pop();
        successSnackBar(message: "Success");
        isBusy.value = false;
      }).onError((e, trace) {
        isBusy.value = false;
      });
    }
  }
}
