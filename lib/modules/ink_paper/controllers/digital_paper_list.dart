import 'package:jog_inventory/common/utils/custom_expansion_tile.dart';
import 'package:jog_inventory/common/utils/error_message.dart';
import 'package:jog_inventory/modules/ink_paper/modles/digital_paper.dart';
import '../../../common/exports/main_export.dart';

class DigitalPaperController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isBusy = false.obs;
  RxBool isCollapsed = false.obs;
  RxBool enableSelect = false.obs;
  RxList<int> selected = <int>[].obs;
  Rx<FilterItem<String>> colorFilter =
      FilterItem<String>(id: 0, title: '', key: '').obs;
  String selectedMonth = timeNow().month.toString();
  String selectedYear = timeNow().year.toString();

  Rx<int> totalPages = 1.obs;
  Rx<int> currentPage = 1.obs;

  RxList<DigitalPaperModel> items = <DigitalPaperModel>[].obs;

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
    DigitalPaperModel.fetchAll(
      currentPage.value,
      paper_size: colorFilter.value.value,
      IMsupplier: "Digital paper",
      month:  selectedMonth,
      year:  selectedYear,

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


  /// delete list of ink data
  deletePaperList(BuildContext context, {required List<DigitalPaperModel> remItem}) {
    deleteItemPopup(context,
        title: "Delete Ink Data",
        subTitle: "Are you sure you want to delete Ink items?",
        onDelete: (context) async {
          DigitalPaperModel.deletePaper(
              appendIds: remItem.map((item) => item.id!).toList())
              .then((val) {
            remItem.forEach((item) {
              items.removeWhere((i) => item.id == i.id);
              controllers.removeLast(); // for balancing
            });
          }).onError((e, trace) {
            errorSnackBar(message: "Unable to delete item please try again");
          });
        });
  }

  /// get and register controller
  static DigitalPaperController getController() {
    var isRegistered = Get.isRegistered<DigitalPaperController>();
    if (isRegistered) {
      return Get.find<DigitalPaperController>();
    }
    return Get.put<DigitalPaperController>(DigitalPaperController());
  }

/// api calls
}
