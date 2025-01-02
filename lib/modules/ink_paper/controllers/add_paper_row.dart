import 'package:jog_inventory/modules/ink_paper/modles/add_row.dart';
import '../../../common/exports/main_export.dart';

class AddPaperRowController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isBusy = false.obs;
  RxList<DigitalPaperRowData> items = <DigitalPaperRowData>[].obs;
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
      List<String> inkBal = items.map((item) => item.paperBalance!).toList();

      // po numbers
      List<String> poNumbers = items.map((item) => item.po!).toList();

      // in stock
      List<String> inStock = items.map((item) => item.inStock!).toList();

      // bal
      List<String> paperBalances =
          items.map((item) => item.paperBalance!).toList();
      List<String> paperSizes = items.map((item) => item.paperSize!).toList();
      List<String> priceYads = items.map((item) => item.priceYads!).toList();
      List<String> usedValue = items.map((item) => item.usedValue!).toList();
      List<String> usedYads = items.map((item) => item.usedYads!).toList();

      // roll no numbers
      List<String> rollsNop =
          items.map((item) => item.rollNo!.toString()).toList();

      // roll no numbers
      List<String> receiptDate =
          items.map((item) => item.receiptDate!.toString()).toList();

      // price lb numbers
      List<String> priceLb =
          items.map((item) => item.priceLb!.toString()).toList();

      DigitalPaperRowDataModel itemData = DigitalPaperRowDataModel(
        imSupplier: imSuppliers,
        po: poNumbers,
        supplier: suppliers,
        receiptDate: receiptDate,
        rollNo: rollsNop,
        priceLb: priceLb,
        inStock: inStock,
        paperBalance: paperBalances,
        paperSize: paperSizes,
        priceYads: priceYads,
        usedValue: usedValue,
        usedYads: usedYads,
        year: timeNow().year.toString(),
        month: timeNow().month.toString(),
      );

      itemData.create().then((onValue) {
        isBusy.value = false;
        mainNavigationService.pop(result: true);

        ///
      }).onError((error, trace) {
        isBusy.value = false;

        ///
      });
    }
  }

  /// get and register controller
  static AddPaperRowController getController() {
    var isRegistered = Get.isRegistered<AddPaperRowController>();
    if (isRegistered) {
      return Get.find<AddPaperRowController>();
    }
    return Get.put<AddPaperRowController>(AddPaperRowController());
  }

  /// api calls
}
