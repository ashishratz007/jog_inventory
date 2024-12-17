import 'package:jog_inventory/common/utils/custom_expansion_tile.dart';
import 'package:jog_inventory/common/utils/error_message.dart';
import 'package:jog_inventory/modules/in_paper/modles/ink_model.dart';
import '../../../common/exports/main_export.dart';

class InkListController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isBusy = false.obs;
  RxBool isCollapsed = false.obs;
  RxBool enableSelect = false.obs;
  RxList<int> selected = <int>[].obs;
  Rx<FilterItem<String>> colorFilter =
      FilterItem<String>(id: 0, title: '', key: '').obs;
  DateTime selectedDate = DateTime.now();

  Rx<int> totalPages = 1.obs;
  Rx<int> currentPage = 1.obs;

  RxList<InkModel> items = <InkModel>[].obs;

  List<CustomExpandedTileController> controllers = [];

  @override
  void onInit() {
    getInkListData();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  /// functions

  toggleCollapse(bool isOpen) {
    controllers.forEach((ctr) {
      if (isOpen) {
        ctr.expand();
      } else {
        ctr.collapse();
      }
    });
  }

  /// api call
  getInkListData() {
    isLoading.value = true;
    InkModel.fetchAll(
      currentPage.value,
      color: colorFilter.value.value,
      month:  selectedDate.month.toString(),
      year:  selectedDate.year.toString(),
      stockMl: "1000",
    ).then((val) {
      items.value = val.items;
      totalPages.value = val.totalPages;

      // register controllers
      controllers.clear();
      val.items.forEach((action){

       controllers.add(CustomExpandedTileController());
      });
      isLoading.value = false;
    }).onError((e, trace) {
      isLoading.value = false;
      displayErrorMessage(Get.context!,
          error: e, trace: trace, onRetry: getInkListData);
    });
  }

  /// get and register controller
  static InkListController getController() {
    var isRegistered = Get.isRegistered<InkListController>();
    if (isRegistered) {
      return Get.find<InkListController>();
    }
    return Get.put<InkListController>(InkListController());
  }

  /// api calls
}
