import 'package:jog_inventory/common/constant/values.dart';
import 'package:jog_inventory/common/utils/bottom_sheet.dart';
import 'package:jog_inventory/common/utils/date_time_picker.dart';
import 'package:jog_inventory/common/utils/validation.dart';
import 'package:jog_inventory/modules/in_paper/modles/ink_model.dart';
import '../../../common/exports/main_export.dart';

openUpdateInkSheet(BuildContext context, {required List<InkModel> items}) {
  showAppBottomSheet(
      Get.context!,
      _UpdatePaperScreen(
        items: items,
      ),
      title: "Update Ink Data");
}

class _UpdatePaperScreen extends StatefulWidget {
  final List<InkModel> items;
  const _UpdatePaperScreen({required this.items, super.key});

  @override
  State<_UpdatePaperScreen> createState() => _UpdatePaperScreenState();
}

class _UpdatePaperScreenState extends State<_UpdatePaperScreen> {
  var formKey = GlobalKey<FormState>();
   String used = "";
   String color= "";
   String month= "";
   String usedDate= "";
  RxBool isBusy = false.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.pagePadding,
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                    child: PrimaryFieldMenuWithLabel<String>(
                        items: List.generate(
                            inkColors.length,
                            (index) => DropDownItem<String>(
                                id: index,
                                title: inkColors[index],
                                key: inkColors[index],
                                isSelected: false,
                                value: inkColors[index])),
                        allowSearch: true,
                        validate: validation.validateEmptyField,
                        onSave: (item) {
                          color = item?.first.value ?? "";
                        },
                        hintText: "Color",
                        labelText: "Color",
                        onChanged: (List<DropDownItem<String>>? items) {})),
                gap(space: 10),
                Expanded(
                    child: TextFieldWithLabel(
                  validator: validation.validateEmptyField,
                  onChanged: (val) {
                    used = val;
                  },
                  labelText: "Used Value",
                  hintText: "Used Value",
                )),
              ],
            ),
            gap(space: 10),
            Row(
              children: [
                Expanded(
                    child: TextFieldWithLabel(
                        enabled: false,
                        initialValue: "0",
                        hintText: "Ink Bal.",
                        labelText: "Ink Bal.")),
                gap(space: 10),
                Expanded(
                    child: DateTimePickerField(
                  validation: validation.validateEmptyField,
                  onChanged: (String? value) {
                    usedDate = value ?? "";
                  },
                  labelText: "Used Date",
                )),
              ],
            ),
            gap(space: 10),
            Row(
              children: [
                Expanded(
                  child: PrimaryFieldMenuWithLabel<String>(
                    items: [],
                    allowSearch: true,
                    onChanged: (item) {
                      month = item?.first.value ?? "";
                    },
                    labelText: "Change Month",
                    hintText: "Change Month",
                  ),
                ),
                Expanded(child: SizedBox()),
              ],
            ),
            gap(space: 30),
            Obx(
              () => PrimaryButton(
                  isBusy: isBusy.value,
                  title: "Update Data",
                  onTap: () async {
                    if (formKey.currentState?.validate() ?? false) {
                      isBusy.value = true;
                      var appendIds =
                          widget.items.map((item) => item.id!).toList();
                      InkModel.updateInk(
                              color: color,
                              month: month,
                              used: used,
                              appendIds: appendIds,
                              usedDate: ParseData.toDateTime(usedDate)!)
                          .then((val) {
                        isBusy.value = false;
                      }).onError((err, trace) {
                        isBusy.value = false;
                        errorSnackBar(message: "Please try again");
                        mainNavigationService.pop();
                      });
                    }
                  },
                  radius: 10,
                  color: Colours.greenLight),
            ),

            /// bottom
            SafeAreaBottom(context)
          ],
        ),
      ),
    );
  }
}
