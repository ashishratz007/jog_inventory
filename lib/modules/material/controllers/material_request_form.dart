import 'package:jog_inventory/modules/material/models/material_rq_form.dart';
import 'package:jog_inventory/modules/material/models/fabric.dart';
import 'package:jog_inventory/modules/material/models/search.dart';
import '../../../common/exports/main_export.dart';

class MaterialRequestFormController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isBusy = false.obs;
  RxBool isUpdate = false.obs;
  RxBool isAddonYear = false.obs;
  RxBool enableAdd = false.obs;
  RxList<MaterialRQFormItem> items = <MaterialRQFormItem>[].obs;

  OrderCodeData? selectedOrderCode;

  FabricCategoryModel? selectedFabCate;
  FabricColorModel? selectedFabColor;
  ColorBoxesModel? selectedFabColorBoxes;

  BottomSheetItemMenuController fabricController =
      BottomSheetItemMenuController();
  BottomSheetItemMenuController fabricColorController =
      BottomSheetItemMenuController();
  BottomSheetItemMenuController colorBoxController =
      BottomSheetItemMenuController();

  @override
  void onInit() {
    if (Get.arguments != null) {
      isUpdate.value = true;
    }
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  /// functions
  addItem() {
    if (selectedFabCate == null ||
        selectedFabColorBoxes == null ||
        selectedFabColor == null) {
      errorSnackBar(message: "Please select all values");
      return;
    }
    fabricController.clearItems;
    fabricColorController.clearItems;
    colorBoxController.clearItems;
    var item = new MaterialRQFormItem(
      selectedFabCate: selectedFabCate!,
      selectedFabColorBoxes: selectedFabColorBoxes!,
      selectedFabColor: selectedFabColor!,
    );
    items.add(item);
    selectedFabCate = null;
    selectedFabColorBoxes = null;
    selectedFabColor = null;
    enableAdd.toggle();
  }

  /// get and register controller
  static MaterialRequestFormController getController() {
    var isRegistered = Get.isRegistered<MaterialRequestFormController>();
    if (isRegistered) {
      return Get.find<MaterialRequestFormController>();
    }
    return Get.put<MaterialRequestFormController>(
        MaterialRequestFormController());
  }

  /// api calls
  createFormRequest() async {
    if (selectedOrderCode == null) {
      errorSnackBar(message: "Please select Order code");
      return;
    }
    if (items.length == 0) {
      errorSnackBar(message: "No Item added inside form.");
      return;
    }
    var requestData = MaterialRqFormModel(
        order_code: selectedOrderCode!.orderTitle!,
        order_lkr_title_id: selectedOrderCode!.orderLkrTitleId!,
        items: items);

    isLoading.value = true;
    isBusy.value = true;
    requestData.addForm().then((value) {
      isLoading.value = false;
      isBusy.value = false;
      Get.back();
      successSnackBar(message: "Material RQ added successfully");
      ///
    }).onError((e, trace) {
      isLoading.value = false;
      isBusy.value = false;
      errorSnackBar(message: "Error posting data");
    });
  }
}
