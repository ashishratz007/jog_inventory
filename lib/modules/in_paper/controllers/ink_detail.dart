import 'package:jog_inventory/common/constant/enums.dart';
import 'package:jog_inventory/modules/in_paper/modles/ink_model.dart';
import '../../../common/exports/main_export.dart';

class InkDetailController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isBusy = false.obs;
  RxList<int> selected = <int>[].obs;
  Rx<FilterItem<String>> colorFilter = FilterItem<String>(id: 0, title: '', key: '').obs;
  DateTime selectedDate = DateTime.now();
  Rx<InkModel> items = InkModel().obs;

  @override
  void onInit() {
    ///
    super.onInit();
  }

  @override
  void onReady() {
    readArgs();
    super.onReady();
  }

  /// functions
  readArgs(){
    var arguments = mainNavigationService.arguments;
    arguments[ScanBarcodeType.ink.key];
  }
  /// api call


  /// get and register controller
  static InkDetailController getController() {
    var isRegistered = Get.isRegistered<InkDetailController>();
    if (isRegistered) {
      return Get.find<InkDetailController>();
    }
    return Get.put<InkDetailController>(InkDetailController());
  }

/// api calls
}