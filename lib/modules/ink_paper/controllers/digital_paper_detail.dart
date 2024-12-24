import 'package:jog_inventory/common/constant/enums.dart';
import 'package:jog_inventory/modules/ink_paper/modles/ink_model.dart';
import '../../../common/exports/main_export.dart';

class PaperDetailController extends GetxController {
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
    arguments[ScanBarcodeType.paper.key];
  }
  /// api call


  /// get and register controller
  static PaperDetailController getController() {
    var isRegistered = Get.isRegistered<PaperDetailController>();
    if (isRegistered) {
      return Get.find<PaperDetailController>();
    }
    return Get.put<PaperDetailController>(PaperDetailController());
  }

/// api calls
}