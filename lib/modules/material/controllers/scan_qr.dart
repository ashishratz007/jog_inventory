import 'package:jog_inventory/common/utils/error_message.dart';
import 'package:jog_inventory/modules/material/models/material_request_detail.dart';
import '../../../common/exports/main_export.dart';

class MaterialScanDetailsController extends GetxController {
  late String fabId;
  late String? pacId;

  RxBool isLoading = false.obs;
  RxBool isBusy = false.obs;
   ScanDetailsModal? scanDetailsModal;

  @override
  void onInit() {
    getArgs();
    super.onInit();
  }

  @override
  void onReady() {
    getFabricData();
    super.onReady();
  }

  /// functions
  getArgs() {
    var args = mainNavigationService.arguments;
    if (args != null) {
      fabId = args[appKeys.fabId];
      pacId = args[appKeys.pacId];

    }
  }

  /// get and register controller
  static MaterialScanDetailsController getController() {
    var isRegistered = Get.isRegistered<MaterialScanDetailsController>();
    if (isRegistered) {
      return Get.find<MaterialScanDetailsController>();
    }
    return Get.put<MaterialScanDetailsController>(MaterialScanDetailsController());
  }

/// api calls
 getFabricData() async {
    isLoading.value = true;
     try {
       scanDetailsModal = await MaterialRequestDetail.getDetails(fabId, pacId);
       print(scanDetailsModal?.message);
       isLoading.value = false;
       update();
     } catch (e,trace) {
       isLoading.value = false;
       displayErrorMessage(Get.context!, error: "Error displaying data!", trace: trace, onRetry: (){
         getFabricData();
       });
       print(e);
     }

 }
}
