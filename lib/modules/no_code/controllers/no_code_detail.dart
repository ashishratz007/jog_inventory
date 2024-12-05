import 'package:jog_inventory/common/utils/date_formater.dart';
import 'package:jog_inventory/common/utils/error_message.dart';
import 'package:jog_inventory/modules/no_code/models/no_code_item.dart';
import 'package:jog_inventory/services/tab_view_navigator.dart';
import '../../../common/exports/main_export.dart';

class NoCodeDetailController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isBusy = false.obs;
  RxBool isCodeGenerated = false.obs;
  late NoCodeRQItemModel usedCode;
  RxList<NoCodeRQUsedItemModel> addedItems = <NoCodeRQUsedItemModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


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
  readArgs(){
    var args = mainNavigationService.arguments;
    if(args is Map){
      usedCode = args[appKeys.usedItem];
      getItems();
    }
  }
  /// get and register controller
  static NoCodeDetailController getController<T>() {
    var isRegistered = Get.isRegistered<NoCodeDetailController>();
    if (isRegistered) {
      return Get.find<NoCodeDetailController>();
    }
    return Get.put<NoCodeDetailController>(NoCodeDetailController());
  }

  /// api calls
  getItems() {
    isLoading.value = true;
    NoCodeRQUsedItemModel.fetchAll(usedCode.usedId.toString()).then((value) {
      isLoading.value = false;
      addedItems.value = value;
    }).onError((error, trace) {
      isLoading.value = false;
      displayErrorMessage(
        Get.context!,
        error: error,
        trace: trace,
        onRetry: () {
          getItems();
        },
      );
    });
  }

}
