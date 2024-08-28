import 'package:jog_inventory/common/utils/bottom_sheet.dart';
import '../../../common/exports/main_export.dart';

void openOrderCodePopup(BuildContext context) {
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: SingleChildScrollView(
            padding: AppPadding.inner,
            child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(200, (index) {
                  RxBool isSelected = false.obs;
                  return Obx(
                    () => InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        isSelected.toggle();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: isSelected.value
                                ? Colours.primaryBlueBg
                                : Colours.white,
                            border: Border.all(
                                color: isSelected.value
                                    ? Colours.primary
                                    : Colours.border)),
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                        child: Text("Ex-1234${index}"),
                      ),
                    ),
                  );
                })),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: PrimaryButton(
              title: "Remove selected orders",
              onTap: () {},
              color: Colours.red,
              isEnable: true),
        ),
        safeAreaBottom(context)
      ],
    );
  }
}
