import 'package:jog_inventory/common/utils/error_message.dart';
import 'package:jog_inventory/modules/material/models/material_request.dart';
import 'package:jog_inventory/modules/material/models/material_rq_form.dart';
import 'package:jog_inventory/modules/material/models/fabric.dart';
import 'package:jog_inventory/modules/material/models/search.dart';
import '../../../common/exports/main_export.dart';

class MaterialRequestFormController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isBusy = false.obs;
  RxBool isUpdate = false.obs;
  int? materialRQId;
  MaterialRequestDetailModel? materialRqData;
  MaterialRequestModel? materialRqDetail;
  RxBool isAddonYear = false.obs;
  RxBool enableAdd = false.obs;
  RxBool scanning = false.obs;
  RxList<MaterialRQItem> items = <MaterialRQItem>[].obs;

  OrderCodeData? selectedOrderCode;

  FabricCategoryModel? selectedFabCate;
  FabricColorModel? selectedFabColor;
  ColorBoxesModel? selectedFabColorBoxes;

  MenuItemsController fabricController =
      MenuItemsController();
  MenuItemsController fabricColorController =
      MenuItemsController();
  MenuItemsController colorBoxController =
      MenuItemsController();

  @override
  void onInit() {
    if (Get.arguments != null) {
      isUpdate.value = true;
      materialRqDetail = Get.arguments[appKeys.materialRQDetail];
      materialRQId = Get.arguments[appKeys.materialRQId];
    }
    super.onInit();
  }

  readArgs() {
    if (isUpdate.value) {
      getMaterialDetail();
    }
  }

  @override
  void onReady() {
    readArgs();
    super.onReady();
  }

  /// functions

  bool hasItem(MaterialRQItem item){
    return(items.any((i)=> i.fabricId == item.fabricId));
  }

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
    var item = MaterialRQItem(
      balanceAfter: selectedFabColorBoxes?.fabricBalance?.toString(),
      balanceBefore: selectedFabColorBoxes?.fabricBalance?.toString(),
      catNameEn: selectedFabCate?.catNameEn,
      fabricBalance: selectedFabColorBoxes?.fabricBalance,
      fabricBox: selectedFabColorBoxes?.fabricBox,
      fabricColor: selectedFabColor?.fabricColor,
      fabricId: selectedFabColorBoxes?.fabricId,
      fabricNo: selectedFabColorBoxes?.fabricNo,
      catCode: selectedFabCate?.catCode,
    );
    /// already added
    if(hasItem(item)){
      errorSnackBar(message: "Duplicate item data!");
    }
    else{
      items.add(item);
    }
    selectedFabCate = null;
    selectedFabColorBoxes = null;
    selectedFabColor = null;
    enableAdd.toggle();
  }

  getMaterialDetail() {
    isLoading.value = true;
    MaterialRequestDetailModel.fetch(materialRQId!).then((value) {
      isLoading.value = false;
      items.value = value.orders ?? [];
    }).onError((e, trace) {
      isLoading.value = false;
      displayErrorMessage(
        Get.context!,
        error: e,
        trace: trace,
        onRetry: () {},
      );
    });
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

    isBusy.value = true;
    requestData.addForm().then((value) {
      isBusy.value = false;
      Get.back();
      Get.toNamed(AppRoutesString.materialRequestList);
      successSnackBar(message: "Material RQ added successfully");

      ///
    }).onError((e, trace) {
      isBusy.value = false;
      errorSnackBar(message: "Error posting data");
    });
  }

  /// delete RQ
  deleteMaterialRQRequest() {
    deleteItemPopup(Get.context!, onDelete: (context) async {
      try {
        await DeleteMaterialRQModel(rq_id: materialRqDetail!.rqId!.toString())
            .create();
      } catch (e, trace) {
        errorSnackBar(message: "Error removing data!");
      }
    }, onComplete: () {
      Get.back(result: true);
      successSnackBar(message: "Item removed successfully");
    });
  }

  updateFormRequest() async {
    isBusy.value = true;
    MaterialRequestModel.updateMaterialRq(materialRqDetail!.rqId!,
            items.map((f) => f.fabricId!.toString()).toList())
        .then((va) {
      isBusy.value = false;
      Get.back();
      successSnackBar(message: "Request updated");
    }).onError((error, trace) {
      isBusy.value = false;
      errorSnackBar(message: "Unable to update data");
    });
  }
}
