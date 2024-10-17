import 'package:jog_inventory/common/exports/main_export.dart';
import 'package:jog_inventory/common/utils/bottom_seet.dart';
import 'package:jog_inventory/common/utils/date_formater.dart';
import 'package:jog_inventory/common/utils/error_message.dart';
import 'package:jog_inventory/modules/material/models/fabric.dart';
import 'package:jog_inventory/modules/no_code/controllers/no_code_request.dart';
import 'package:jog_inventory/modules/no_code/models/no_code.dart';

void openFabricDetailsPopup(String categoryId, {required Function() onDone}) {
  showAppBottomSheet(Get.context!, _FabricDetailsScreen(categoryId, onDone),
      title: "Fabric Details");
}

class _FabricDetailsScreen extends StatefulWidget {
  final String categoryId;
  final Function() onDone;
  const _FabricDetailsScreen(this.categoryId, this.onDone, {super.key});

  @override
  State<_FabricDetailsScreen> createState() => _FabricDetailsScreenState();
}

class _FabricDetailsScreenState extends State<_FabricDetailsScreen> {
  List<TypeCategoryModel> categoryData = [];

  RxBool isLoading = false.obs;
  RxBool isBusy = false.obs;

  RxSet<String> addedItem = <String>{}.obs;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    isLoading.value = true;
    TypeCategoryModel.fetchAll(widget.categoryId).then((value) {
      categoryData = value;
      isLoading.value = false;
    }).onError((error, trace) {
      displayErrorMessage(
        context,
        error: error,
        trace: trace,
        onRetry: () {
          getData();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colours.bgColor,
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(visible: isLoading.value, child: listLoadingEffect()),
            Visibility(
              visible: !isLoading.value,
              child: Flexible(
                child: SingleChildScrollView(
                    padding: AppPadding.inner,
                    child: Column(
                      children: [
                        ...displayList<TypeCategoryModel>(
                            items: categoryData,
                            builder: (item, index) {
                              return itemTileWidget(item);
                            }),

                        gap(space: 10),

                        ///
                        gap(),
                        safeAreaBottom(context),
                      ],
                    )),
              ),
            ),
            Padding(
              padding: AppPadding.leftRight,
              child: PrimaryButton(
                color: Colours.greenLight,
                title: "Add",
                isBusy: isBusy.value,
                onTap: () {
                  var controller = getController<NoCodeRequestController>(
                      NoCodeRequestController());
                  isBusy.value = true;
                  NoCodeRequestModel.addItems(addedItem.toList(),
                          controller.usedCode!, widget.categoryId)
                      .then((value) {
                    isBusy.value = false;
                    Get.back();
                    widget.onDone();
                  }).onError((error, trace) {
                    isBusy.value = false;
                  });
                },
                leading: Icon(Icons.add, size: 18, color: Colors.white),
              ),
            ),
            safeAreaBottom(context),
          ],
        ),
      ),
    );
  }

  Widget itemTileWidget(TypeCategoryModel item) {
    return Container(
      padding: AppPadding.inner,
      decoration: BoxDecoration(
        color: Colours.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: containerShadow(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("${item.catNameEn} ,",
                  style: appTextTheme.labelSmall
                      ?.copyWith(color: Colours.primaryText)),
              gap(space: 10),
              Text("${item.fabricColor}",
                  style: appTextTheme.labelSmall
                      ?.copyWith(color: Colours.blackMat)),
              Expanded(child: SizedBox()),
              Obx(() => checkBox(
                  value: addedItem.contains("${item.fabricId}"),
                  selectedColor: Colours.secondary,
                  onchange: (value) {
                    if (addedItem.contains("${item.fabricId}"))
                      addedItem.remove("${item.fabricId}");
                    else
                      addedItem.add("${item.fabricId}");
                    addedItem.refresh();
                  }))
            ],
          ),
          Row(
            children: [
              Expanded(
                  flex: 3,
                  child: titleSubtitleWidget(Strings.date,
                      "${dateTimeFormat.toYYMMDDHHMMSS(date: item.fabricDateCreate, removeTime: true)}")),
              Expanded(
                  flex: 2,
                  child: titleSubtitleWidget(
                      Strings.bal, "${item.fabricBalance} kg")),
            ],
          ),
          gap(space: 5),
          Row(
            children: [
              Expanded(
                  flex: 3,
                  child: titleSubtitleWidget(Strings.box, "${item.fabricBox}")),
              Expanded(
                  flex: 2,
                  child: titleSubtitleWidget(
                      Strings.used, "${item.fabricUsed ?? 0}")),
            ],
          ),
          gap(space: 5),
          Row(
            children: [
              Expanded(
                  flex: 3,
                  child: titleSubtitleWidget("No", "${item.fabricNo}")),
              Expanded(
                  flex: 2,
                  child: titleSubtitleWidget(
                      Strings.amount, "${item.fabricAmount}")),
            ],
          ),
        ],
      ),
    );
  }

  Widget titleSubtitleWidget(String title, String subtitle) {
    return Row(
      children: [
        Flexible(
          child: Text(title,
              style:
                  appTextTheme.labelSmall?.copyWith(color: Colours.greyLight)),
        ),
        gap(space: 5),
        Flexible(
          child: Text(subtitle,
              style:
                  appTextTheme.labelSmall?.copyWith(color: Colours.blackLite)),
        ),
      ],
    );
  }
}
