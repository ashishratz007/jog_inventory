import 'package:jog_inventory/common/base_model/common_model.dart';
import 'package:jog_inventory/common/utils/error_message.dart';
import 'package:jog_inventory/modules/material/models/material_request.dart';

import '../../../common/exports/main_export.dart';

class MaterialRequestListController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isBusy = false.obs;
  RxBool isProducing = true.obs;
  RxInt finishPage = 1.obs; //current page
  RxInt producingPage = 1.obs; // current page

  Pagination<MaterialRequestModel>? finishedList;
  Pagination<MaterialRequestModel>? producing;

  @override
  void onInit() {
    getDataList();
    super.onInit();
  }

  @override
  void onReady() {
    ///
    super.onReady();
  }

  /// change tabs
  changeTabs(bool isFinished) {
    if (isFinished) {
      isProducing.value = false;
      if ((finishedList?.length ?? 0) == 0) getDataList(isFinished: true);
    } else {
      isProducing.value = true;
    }
  }

  // page filter
  filterByPage(int page) {
    if (isProducing.value) {
      producingPage.value = page;
    } else {
      finishPage.value = page;
    }
    getDataList(
      isFinished: !isProducing.value,
    );
  }

  /// functions
  getDataList({bool isFinished = false, bool clearData = false}) {
    if (clearData) {
      finishedList?.clear();
      producing?.clear();
      producingPage.value = 1;
      finishPage.value = 1;
    }
    // if (isFinished) {
    //   finishPage.value++;
    // } else {
    //   producingPage.value++;
    // }
    isLoading.value = true;
    MaterialRequestModel.fetch(
            isFinished ? finishPage.value : producingPage.value,
            isFinished: isFinished)
        .then((value) {
      isLoading.value = false;
      if (isFinished) {
        finishedList = (value);
      } else {
        producing = (value);
      }
    isProducing.refresh();
    }).onError((e, trace) {
      isLoading.value = false;
      showErrorMessage(Get.context!, error: e, trace: trace, onRetry: () {
        getDataList(isFinished: isFinished,clearData: clearData);
      });
    });
  }

  /// get and register controller
  static MaterialRequestListController getController() {
    var isRegistered = Get.isRegistered<MaterialRequestListController>();
    if (isRegistered) {
      return Get.find<MaterialRequestListController>();
    }
    return Get.put<MaterialRequestListController>(
        MaterialRequestListController());
  }

  /// api calls
}
