import 'package:jog_inventory/modules/no_code/controllers/no_code_request.dart';
import 'package:jog_inventory/modules/no_code/widgits/fabric_detail.dart';
import '../../../common/exports/main_export.dart';

class NoCodeRequestFormScreen extends GetView<NoCodeRequestController> {
  const NoCodeRequestFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
        title: Strings.noCodeRQ, body: body(), bottomNavBar: viewWidget());
  }

  Widget body() {
    return SingleChildScrollView(
      padding: AppPadding.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(Strings.requisitionWithNoCode, style: appTextTheme.titleMedium),

          /// form
          gap(),
          Row(
            children: [
              // code
              Expanded(child: autoGenerateCodeWidget()),
              gap(),
              //date
              Expanded(child: dateWidget()),
            ],
          ),

          gap(),
          // note
          noteWidget(),

          ///
          gap(),
          safeAreaBottom(Get.context!),
        ],
      ),
    );
  }

  Widget autoGenerateCodeWidget() {
    return TextFieldWithLabel(
        labelText: Strings.autoGenCode,
        enabled: false,
        hintText: "OR-45343534232");
  }

  Widget dateWidget() {
    return TextFieldWithLabel(
        labelText: Strings.date,
        enabled: false,
        hintText: "2024-08-13 16:52:22");
  }

  Widget noteWidget() {
    return TextFieldWithLabel(
        labelText: Strings.note,
        enabled: true,
        hintText: Strings.enterComments,
        maxLines: 2);
  }

  Widget submitButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 50,
          child: ClipRRect(
              child: PrimaryButton(
            title: Strings.submit,
            onTap: () {},
            isFullWidth: false,
            radius: 15,
          )),
        ),
      ],
    );
  }

  Widget viewWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        gap(),
        Row(
          children: [
            Expanded(
              child: CustomDropDownWithLabel(
                items: [],
                onChanged: (item) {},
                labelText: Strings.selectType,
                hintText: Strings.selectType,
              ),
            ),
            gap(),
            Expanded(
              child: CustomDropDownWithLabel<String>(
                items: [
                  ...List.generate(
                    100,
                    (index) => DropDownItem<String>(
                        id: index, title: 'index${index}', key: '${index}'),
                  )
                ],
                onChanged: (item) {},
                labelText: Strings.selectMaterial,
                hintText: Strings.selectMaterial,
              ),
            ),
          ],
        ),
        gap(space: 10),
        dottedDivider(),
        gap(space: 10),
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                  child: PrimaryButton(
                title: Strings.view,
                color: Colours.greenLight,
                leading: Icon(
                  Icons.remove_red_eye,
                  color: Colours.white,
                  size: 20,
                ),
                onTap: () {
                  openFabricDetailsPopup(onDone: (){});
                },
                isFullWidth: false,
                radius: 15,
              )),
            ),
          ],
        ),
      ],
    );
  }
}