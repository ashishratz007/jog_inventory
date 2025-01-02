import 'package:jog_inventory/modules/ink_paper/modles/add_row.dart';
import '../../../common/exports/main_export.dart';

class AddInkRowController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isBusy = false.obs;
  RxList<InkRowDataItem> items = <InkRowDataItem>[].obs;
  var formKey = GlobalKey<FormState>();

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
  readArgs() {
    ///
  }

  /// api call
  submit() {
    if (formKey.currentState?.validate() ?? false) {
      isBusy.value = true;

      // supplier
      List<String> suppliers = items.map((item) => item.supplier!).toList();
      // im supplier
      List<String> imSuppliers = items.map((item) => item.imSupplier!).toList();

      // inkBal
      List<String> inkBal = items.map((item) => item.inkBalanceMl!).toList();

      // po numbers
      List<String> poNumbers = items.map((item) => item.po!).toList();

      // po numbers
      List<String> inkColors = items.map((item) => item.inkColor!).toList();

      // stockMl numbers
      List<String> stockMl =
          items.map((item) => item.inStockMl!.toString()).toList();

      // roll no numbers
      List<String> rollsNop =
          items.map((item) => item.rollNo!.toString()).toList();

      // roll no numbers
      List<String> receiptDate =
          items.map((item) => item.receiptDate!.toString()).toList();

      // price lb numbers
      List<String> priceLb =
          items.map((item) => item.priceLb!.toString()).toList();

      // usedMl no numbers
      List<String> usedMl =
          items.map((item) => item.usedMl!.toString()).toList();

      // used no numbers
      List<String> usedList =
          items.map((item) => item.used!.toString()).toList();

      InkRowDataModel itemData = InkRowDataModel(
        imSupplier: imSuppliers,
        inkBalanceMl: inkBal,
        po: poNumbers,
        inkColor: inkColors,
        inStockMl: stockMl,
        used: usedList,
        priceLb: priceLb,
        receiptDate: receiptDate,
        rollNo: rollsNop,
        supplier: suppliers,
        usedMl: usedMl,
        month: timeNow().month,
        year: timeNow().year,
      );

      itemData.create().then((onValue){
        isBusy.value = false;
        mainNavigationService.pop(result: true);
        ///
      }).onError((error,trace){
        isBusy.value = false;
        ///
      });
    }
  }

  /// get and register controller
  static AddInkRowController getController() {
    var isRegistered = Get.isRegistered<AddInkRowController>();
    if (isRegistered) {
      return Get.find<AddInkRowController>();
    }
    return Get.put<AddInkRowController>(AddInkRowController());
  }

  /// api calls
}
