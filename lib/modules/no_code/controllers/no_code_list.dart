import 'package:jog_inventory/common/base_model/common_model.dart';
import 'package:jog_inventory/common/utils/error_message.dart';
import 'package:jog_inventory/modules/no_code/models/no_code_item.dart';
import '../../../common/exports/main_export.dart';

class NoCodeListRequestController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isBusy = false.obs;
  TextEditingController searchController = TextEditingController();
  Pagination<NoCodeRQItemModel>? pagination;
  RxList<NoCodeRQItemModel> items = <NoCodeRQItemModel>[].obs;

  @override
  void onInit() {
    ///
    super.onInit();
  }

  @override
  void onReady() {
    getItems(1);
    super.onReady();
  }

  /// functions

  /// get and register controller
  static NoCodeListRequestController getController<T>() {
    var isRegistered = Get.isRegistered<NoCodeListRequestController>();
    if (isRegistered) {
      return Get.find<NoCodeListRequestController>();
    }
    return Get.put<NoCodeListRequestController>(NoCodeListRequestController());
  }

  /// api calls
  getItems(int page, {String? search}) {
    isLoading.value = true;
    NoCodeRQItemModel.fetchAll(page: page, search: search).then((value) {
      isLoading.value = false;
      items.value = value.items;
      pagination = value;
    }).onError((error, trace) {
      isLoading.value = false;
      displayErrorMessage(
        Get.context!,
        error: error,
        trace: trace,
        onRetry: () {
          getItems(page, search: search);
        },
      );
    });
  }
}
