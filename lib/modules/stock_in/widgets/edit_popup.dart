import '../../../common/exports/main_export.dart';

void editStockInItemPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: EdgeInsets.all(10),
        backgroundColor: Colors.transparent,
        // clipBehavior: Clip.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: _EditItem(),
      );
    },
  );
}

class _EditItem extends StatefulWidget {
  const _EditItem({super.key});

  @override
  State<_EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<_EditItem> {
  bool isSelected = false;
  RxBool isBusy = false.obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colours.white,
        ),
        child: SingleChildScrollView(
          padding: AppPadding.pagePaddingAll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              gap(space: 10),
              TextFieldWithLabel(labelText: "New Unit Price :",inputFormatters: [amountFormatter()]),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Update All",
                      style: appTextTheme.labelSmall
                          ?.copyWith(color: Colours.black.withOpacity(0.7),fontSize: 16)),
                  gap(),
                  checkBox(
                      value: isSelected,
                      onchange: (value) {
                        isSelected = value;
                        setState(() {});
                      })
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(() => PrimaryButton(
                      padding: EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 5),
                      title: "Update",
                      onTap: () {},
                      isFullWidth: false,
                      isBusy: isBusy.value))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
