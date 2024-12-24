import 'package:jog_inventory/common/utils/bottom_sheet.dart';
import 'package:jog_inventory/common/utils/date_time_picker.dart';
import 'package:jog_inventory/common/utils/validation.dart';
import 'package:jog_inventory/modules/ink_paper/modles/digital_paper.dart';
import '../../../common/exports/main_export.dart';

openUpdatePaperSheet(BuildContext context,
    {required List<DigitalPaperModel> items, Function? onDone}) {
  showAppBottomSheet(
      Get.context!, _UpdatePaperScreen(items: items, onDone: onDone),
      title: "Update Paper");
}

class _UpdatePaperScreen extends StatefulWidget {
  final List<DigitalPaperModel> items;
  final Function? onDone;
  const _UpdatePaperScreen({required this.items, this.onDone, super.key});

  @override
  State<_UpdatePaperScreen> createState() => _UpdatePaperScreenState();
}

class _UpdatePaperScreenState extends State<_UpdatePaperScreen> {
  var formKey = GlobalKey<FormState>();
  String used = "";
  String size = "";
  String month = "";
  String year = "";
  String usedDate = "";
  RxBool isBusy = false.obs;

  List<DropDownItem<String>> years = List.generate(
      20,
          // index + 1 is to add one future year
          (index) => DropDownItem(
        id: timeNow().year - index + 1,
        title: "${timeNow().year - index + 1}",
        key: "${timeNow().year - index + 1}",
        isSelected: false,
        value: "${timeNow().year - index + 1}",
      ));

  List<String> get monthNames => yearMonths(short: true);
  late List<DropDownItem<String>> months = List.generate(
      monthNames.length,
          (index) => DropDownItem(
          id: index + 1,
          title: monthNames[index],
          key: monthNames[index],
          isSelected: false,
          value: "${index + 1}"));

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        padding: AppPadding.pagePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                    child: PrimaryFieldMenuWithLabel<String>(
                        items: [
                      DropDownItem<String>(
                          id: 1,
                          title: "100",
                          key: "100",
                          isSelected: false,
                          value: "100"),
                      DropDownItem<String>(
                          id: 2,
                          title: "200",
                          key: "200",
                          isSelected: false,
                          value: "200"),
                    ],
                        allowSearch: true,
                        onSave: (item) {
                          size = item?.first.value ?? "";
                        },
                        hintText: "Paper size",
                        labelText: "Paper size",
                        onChanged: (List<DropDownItem<String>>? item) {
                          //
                        })),
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
                        hintText: "Paper Bal.",
                        labelText: "Paper Bal.")),
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
                    items: months,
                    allowSearch: true,
                    onChanged: (item) {
                      month = item?.first.value ?? "";
                    },
                    labelText: "Change Month",
                    hintText: "Change Month",
                  ),
                ),
                gap(space: 10),
                Expanded(
                  child: PrimaryFieldMenuWithLabel<String>(
                    items: years,
                    allowSearch: true,
                    onChanged: (item) {
                      year = item?.first.value ?? "";
                    },
                    labelText: "Change Year",
                    hintText: "Change Year",
                  ),
                ),
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
                      DigitalPaperModel.updatePaper(
                              size: size,
                              month: month,
                              year: year,
                              used: used,
                              appendIds: appendIds,
                              usedDate: ParseData.toDateTime(usedDate)!)
                          .then((val) {
                        isBusy.value = false;
                        Get.back();
                        widget.onDone?.call();
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
