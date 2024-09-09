import 'package:jog_inventory/common/utils/error_message.dart';
import 'package:jog_inventory/common/utils/validation.dart';
import 'package:jog_inventory/modules/material/models/material_request.dart';
import 'package:jog_inventory/modules/material/models/material_rq_form.dart';
import '../../../common/exports/main_export.dart';
import '../../../common/utils/date_formater.dart';

class FinishMaterialRQScreen extends StatefulWidget {
  const FinishMaterialRQScreen({super.key});

  @override
  State<FinishMaterialRQScreen> createState() => _FinishMaterialRQScreenState();
}

class _FinishMaterialRQScreenState extends State<FinishMaterialRQScreen> {
  RxBool isLoading = false.obs;
  RxBool isBusy = false.obs;
  int? materialRQId;
  late MaterialRequestModel materialRqDetail;
  RxList<MaterialRQItem> items = <MaterialRQItem>[].obs;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (Get.arguments != null) {
      materialRqDetail = Get.arguments[appKeys.materialRQDetail];
      materialRQId = Get.arguments[appKeys.materialRQId];
      getMaterialDetail();
    }
    super.initState();
  }

  /// get material data
  getMaterialDetail() {
    isLoading.value = true;
    MaterialRequestDetailModel.fetch(materialRQId!).then((value) {
      isLoading.value = false;
      items.value = value.orders ?? [];
    }).onError((e, trace) {
      isLoading.value = false;
      showErrorMessage(
        Get.context!,
        error: e,
        trace: trace,
        onRetry: () {},
      );
    });
  }

  /// finish form submit
  submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      isBusy.value = true;
      SubmitRQFinishModel(
        rqId: materialRqDetail.rqId!.toString(),
        rqItemIds: items.map((f) => f.rqItemId.toString()).toList(),
        afterBal: items.map((f) => f.balanceAfter.toString()).toList(),
        beforeBal: items.map((f) => f.balanceBefore.toString()).toList(),
        fabricIds: items.map((f) => f.fabricId.toString()).toList(),
        itemNote: items.map((f) => f.itemNote.toString()).toList(),
      ).create().then((value) {
        isBusy.value = false;
        Get.back(result: true);
        successSnackBar(message: "Material RQ Finished");

        ///
      }).onError((e, trace) {
        isBusy.value = false;
        errorSnackBar(message: "Error posting data");
        // });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: "Finish material request",
      body: body(),
      bottomNavBar: bottomNavBarButtons(),
    );
  }

  Widget body() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: AppPadding.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            orderInfo(),
            gap(),
            // tiles
            /// Loading effects
            Obx(() => Visibility(
                  visible: isLoading.value,
                  child: listLoadingEffect(height: 100),
                )),

            /// Items list
            Obx(
              () => Visibility(
                visible: !isLoading.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...displayItemsWidget(),
                  ],
                ),
              ),
            ),

            ///
            gap(),
            safeAreaBottom(Get.context!),
          ],
        ),
      ),
    );
  }

  /// for update
  Widget orderInfo() {
    return Container(
      padding: AppPadding.inner,
      decoration: BoxDecoration(
          color: Colours.secondary2, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(Strings.status,
                  style:
                      appTextTheme.labelMedium?.copyWith(color: Colours.white)),
              gap(),
              Text(materialRqDetail.rqStatus ?? "_",
                  style:
                      appTextTheme.labelMedium?.copyWith(color: Colours.white)),
              Expanded(child: SizedBox()),
              displayAssetsWidget(AppIcons.boxes_white, height: 22)
            ],
          ),
          gap(space: 10),
          Row(
            children: [
              Text(Strings.orderCode,
                  style: appTextTheme.labelMedium
                      ?.copyWith(color: Colours.white, fontSize: 13)),
              gap(space: 10),
              Text(materialRqDetail.orderCode ?? "_",
                  style: appTextTheme.labelSmall
                      ?.copyWith(color: Colours.white, fontSize: 13)),
              Expanded(child: SizedBox()),
              Text(Strings.date,
                  style: appTextTheme.labelMedium
                      ?.copyWith(color: Colours.white, fontSize: 13)),
              gap(space: 10),
              Text(
                  appDateTimeFormat.toYYMMDDHHMMSS(
                      removeTime: true, date: materialRqDetail.rqDate),
                  style: appTextTheme.labelSmall
                      ?.copyWith(color: Colours.white, fontSize: 13)),
            ],
          )
        ],
      ),
    );
  }

  List<Widget> displayItemsWidget() {
    return displayList<MaterialRQItem>(
      items: items,
      showGap: true,
      builder: (item, index) => itemTileWidget(item, index),
    );
  }

  Widget itemTileWidget(MaterialRQItem item, index) {
    return Container(
      padding: AppPadding.inner,
      decoration:
          BoxDecoration(color: Colours.white, boxShadow: containerShadow()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          gap(space: 10),
          // info
          Row(
            children: [
              Text("${item.fabricNo??""}",
                  style: appTextTheme.labelSmall
                      ?.copyWith(color: Colours.greyLight)),
              gap(space: 10),
              Text("${item.catNameEn} ,",
                  style: appTextTheme.labelSmall
                      ?.copyWith(color: Colours.blackLite)),
              gap(space: 10),
              Text("${item.fabricColor}",
                  style: appTextTheme.labelSmall
                      ?.copyWith(color: Colours.primaryText)),
              Expanded(child: SizedBox()),
            ],
          ),
          gap(space: 10),
          Row(
            children: [
              gap(space: 25),
              Text(Strings.box,
                  style: appTextTheme.labelSmall
                      ?.copyWith(color: Colours.greyLight)),
              gap(space: 5),
              Text("${item.fabricBox??""}",
                  style: appTextTheme.labelSmall
                      ?.copyWith(color: Colours.blackLite)),
              Expanded(child: SizedBox()),
              Text(Strings.bal,
                  style: appTextTheme.labelSmall
                      ?.copyWith(color: Colours.greyLight)),
              gap(space: 10),
              Text("${item.fabricBalance} kg",
                  style: appTextTheme.labelSmall
                      ?.copyWith(color: Colours.blackLite)),
              gap(space: 50),
            ],
          ),
          // bal form
          gap(space: 10),
          dottedDivider(),
          gap(space: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              gap(space: 25),
              Expanded(
                flex: 1,
                child: TextFieldWithLabel(
                    inputFormatters: [
                      amountFormatter()],
                    keyboardType: TextInputType.number,
                    labelText: "Balance after",
                    hintText: "in kgs",
                    validator: (String? val){
                      if(val == null || ((val??"").trim() == "")) return appValidation.validateEmptyField(val);
                      if(!compareBalance(val, item.fabricBalance)){
                        var message = "Value must be less than or equal to balance.";
                        errorSnackBar(message: message);
                        return message;
                      }
                      return null;
                    },
                    onChanged: (val) {
                      item.balanceAfter = val;
                    }),
              ),
              gap(),
              Expanded(
                flex: 2,
                child: TextFieldWithLabel(
                    labelText: "Note",
                    hintText: "Add note",
                    onChanged: (val) {
                      item.itemNote = val;
                    }),
              ),
            ],
          ),
          gap(space: 5),
        ],
      ),
    );
  }

  Widget bottomNavBarButtons() {
    return Container(
      // padding: EdgeInsets.only(bottom: SafeAreaBottomValue(Get.context!)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Container(
          //     height: 40,
          //     child: PrimaryButton(
          //       title: Strings.cutAll,
          //       onTap: () {},
          //       isFullWidth: false,
          //       radius: 15,
          //     )),
          Expanded(
            child: Container(
                height: 40,
                child: Obx(
                  () => PrimaryButton(
                    title: Strings.finish,
                    color: Colours.greenLight,
                    onTap: () {
                      submitForm();
                    },
                    isFullWidth: true,
                    isBusy: isBusy.value,
                    radius: 15,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
