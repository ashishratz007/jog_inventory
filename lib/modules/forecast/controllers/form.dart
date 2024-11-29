import 'package:intl/intl.dart';
import 'package:jog_inventory/common/utils/error_message.dart';
import 'package:jog_inventory/modules/forecast/models/detail.dart';
import 'package:jog_inventory/modules/forecast/models/forecast_form.dart';
import 'package:jog_inventory/modules/forecast/models/forecast_item.dart';
import 'package:jog_inventory/modules/forecast/models/forecast_list.dart';
import 'package:jog_inventory/modules/material/models/search.dart';
import 'package:jog_inventory/services/tab_view_navigator.dart';
import '../../../common/exports/main_export.dart';

class ForecastFormController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isBusy = false.obs;
  RxBool isUpdate = false.obs;
  RxBool canEdit = true.obs;
  String? forecastId;
  ForecastDetail? forecastDetail;
  String usedCode = 'FC-${DateFormat('ymdHM').format(DateTime.now())}';
  OrderCodeData? orderCode;
  ForecastFormModel formData = ForecastFormModel();
  var formKey = GlobalKey<FormState>();
  RxList<ForeCastFormItem> items = <ForeCastFormItem>[].obs;

  @override
  void onInit() {
    readArgs();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  readArgs() {
    var args  = Get.arguments;
    if(args!= null){
      forecastId = "${args[appKeys.forecastId]}";
      isUpdate.value = true;
      getForecastById();
    }
  }

  /// functions
  addItems(List<ForeCastFormItem> value) {
    items.addAll(value);
    items.refresh();
  }

  /// api calls
  submitForm() {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      if (!isUpdate.value && orderCode == null) {
        errorSnackBar(message: "Select order Code");
        return;
      }
      // while updating forecast
      if(!isUpdate.value) {
        formData.forecastOrder = orderCode?.orderTitle;
        formData.forecastCode = usedCode;
      }
      // while updating forecast
      else {
        formData.forecast_id = forecastDetail?.forecastHead.firstOrNull?.forecastId?.toString();
        formData.forecastOrder = forecastDetail?.forecastHead.firstOrNull?.forecastOrder;
        formData.forecastCode = forecastDetail?.forecastHead.firstOrNull?.forecastCode;
        formData.forecastDate = forecastDetail?.forecastHead.firstOrNull?.forecastDate;
      }

      formData.rowUsed = items.map((i) => i.forecast!).toList();
      formData.rowTypeId = items.map((i) => "1").toList();
      formData.rowCatId =
          items.map((i) => i.material.catId!.toString()).toList();
      formData.rowSelectColorId = items.map((i) => i.color.color_id!).toList();
      formData.rowSelectColor = items.map((i) => i.color.fabricColor!).toList();
      formData.rowUnit = items.map((i) => "3").toList();
      isBusy.value = true;

      /// create new
     if(!isUpdate.value) {
        formData.create().then((val) {
          isBusy.value = false;

          mainNavigationService.pop();
          successSnackBar(message: "Forecast added successfully");
        }).onError((error, trace) {
          isBusy.value = false;
          errorSnackBar(message: "Unable to save data try again.");
        });
      }
     /// Update forecast
      else{
        formData.updateData().then((val) {
          isBusy.value = false;

          mainNavigationService.pop();
          successSnackBar(message: "Forecast Updated successfully");
        }).onError((error, trace) {
          isBusy.value = false;
          errorSnackBar(message: "Unable to save data try again.");
        });
      }
    }
  }

  /// get forecast by id
  getForecastById() {
    isLoading.value = true;
    ForecastListModel.fetch(forecastId!).then((value){
      forecastDetail = value;
      items.value = value.forecastItems;
      isLoading.value = false;
      canEdit.value = !(forecastDetail?.forecastHead.firstOrNull?.isProduced??false);
    }).onError((error, trace){
      isLoading.value = false;
      displayErrorMessage(Get.context!, error: error, trace: trace, onRetry: getForecastById);
    });
  }

  /// get and register controller
  static ForecastFormController getController() {
    var isRegistered = Get.isRegistered<ForecastFormController>();
    if (isRegistered) {
      return Get.find<ForecastFormController>();
    }
    return Get.put<ForecastFormController>(ForecastFormController());
  }

  /// api calls
}
