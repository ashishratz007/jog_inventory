import 'package:jog_inventory/common/utils/bottom_sheet.dart';
import 'package:jog_inventory/modules/material/models/fabric.dart';
import 'package:jog_inventory/modules/material/models/search.dart';
import 'package:jog_inventory/services/tab_view_navigator.dart';
import '../../../common/exports/main_export.dart';

void openOrderCodeRemovePopup(BuildContext context) {
  showAppBottomSheet(
    context,
    _OrderCodesRemoveScreen(),
    title: "Removing Order Code",
    bgColor: Colours.bgColor,
  );
}

class _OrderCodesRemoveScreen extends StatefulWidget {
  const _OrderCodesRemoveScreen({super.key});

  @override
  State<_OrderCodesRemoveScreen> createState() =>
      _OrderCodesRemoveScreenState();
}

class _OrderCodesRemoveScreenState extends State<_OrderCodesRemoveScreen> {
  List<OrderCodeData> codes = [];
  String? error;
  RxBool isLoading = false.obs;
  RxBool isBusy = false.obs;

  RxSet<int> selectedCodeIds = <int>{}.obs;

  @override
  void initState() {
    getOrderCodes();
    super.initState();
  }

  getOrderCodes() async {
    try {
      error = null;
      isLoading.value = true;
      var data = await SearchOrderModal.searchData("", showAll: true);
      codes = data.data ?? [];
      isLoading.value = false;
    } catch (e, trace) {
      error = "Unable to load data";
      isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(visible: isLoading.value, child: listLoadingEffect()),
          Visibility(
            visible: !isLoading.value && error == null,
            child: Flexible(
              child: SingleChildScrollView(
                padding: AppPadding.inner,
                child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(codes.length, (index) {
                      OrderCodeData orderCode = codes[index];
                      return Obx(
                        () => InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            if (selectedCodeIds
                                .contains(orderCode.orderLkrTitleId)) {
                              selectedCodeIds.remove(orderCode.orderLkrTitleId);
                            } else {
                              selectedCodeIds.add(orderCode.orderLkrTitleId!);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: selectedCodeIds
                                        .contains(orderCode.orderLkrTitleId)
                                    ? Colours.primaryBlueBg
                                    : Colours.white,
                                border: Border.all(
                                    color: selectedCodeIds
                                            .contains(orderCode.orderLkrTitleId)
                                        ? Colours.primary
                                        : Colours.border)),
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 5),
                            child: Text(orderCode.orderTitle??""),
                          ),
                        ),
                      );
                    })),
              ),
            ),
          ),
          Visibility(
              visible: error != null && !isLoading.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    color: Colours.red,
                    size: 50,
                  ),
                  gap(space: 10),
                  Text("${error ?? "Error Loading Data."}\nTry again!",
                      textAlign: TextAlign.center,
                      style: appTextTheme.titleMedium),
                  gap(space: 10),
                  IconButton(
                      onPressed: () {
                        getOrderCodes();
                      },
                      icon: Icon(Icons.refresh, size: 40, color: Colours.blue))
                ],
              )),
          Obx(()=> Padding(
              padding: EdgeInsets.all(10),
              child: PrimaryButton(
                  title: "Remove selected orders",
                  onTap: () async {
                    try {
                      isBusy.value = true;
                      await RemoveCodeModel(selectedCodeIds.toList())
                          .removeCodes();
                      isBusy.value = false;
                      mainNavigationService.back(context);
                    } catch (e, trace) {
                      isBusy.value = false;
                      errorSnackBar(message: e.toString());
                    }
                  },
                  color: Colours.red,
                  isBusy:  isBusy.value,
                  isEnable: selectedCodeIds.length > 0),
            ),
          ),
          SafeAreaBottom(context)
        ],
      ),
    );
  }
}
