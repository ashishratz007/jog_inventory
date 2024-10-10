import 'package:intl/intl.dart';
import 'package:jog_inventory/modules/forecast/models/forecast_form.dart';
import 'package:jog_inventory/modules/forecast/models/forecast_item.dart';
import 'package:jog_inventory/modules/material/models/search.dart';
import '../../../common/exports/main_export.dart';

class ForecastFormController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isBusy = false.obs;
  String usedCode = 'FC-${DateFormat('ymdHM').format(DateTime.now())}';
  OrderCodeData? orderCode;
  ForecastFormModel formData = ForecastFormModel();
  var formKey = GlobalKey<FormState>();
  RxList<ForeCastFormItem> items = <ForeCastFormItem>[].obs;

  @override
  void onInit() {
    //
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
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
      if (orderCode == null) {
        errorSnackBar(message: "Select order Code");
        return;
      }
      formData.forecastCode = usedCode;
      formData.forecastOrder = orderCode?.orderTitle;
      formData.rowUsed = items.map((i) => i.forecast!).toList();
      formData.rowTypeId = items.map((i) => "1").toList();
      formData.rowCatId =
          items.map((i) => i.material.catId!.toString()).toList();
      formData.rowSelectColorId = items.map((i) => i.color.color_id!).toList();
      formData.rowSelectColor = items.map((i) => i.color.fabricColor!).toList();
      formData.rowUnit = items.map((i) => "3").toList();
      isBusy.value = true;
      formData.create().then((val) {
        isBusy.value = false;

        Get.back();
        successSnackBar(message: "Forecast added successfully");
      }).onError((error, trace) {
        isBusy.value = false;
        errorSnackBar(message: "Unable to save data try again.");
      });
    }
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
