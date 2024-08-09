
import 'package:jog_inventory/common/constant/enums.dart';
import '../exports/main_export.dart';


void showSnackBar(
    {required String title,
    required String message,
    SnackBarType type = SnackBarType.message}) {
  Get.snackbar(
    borderColor: type.titleColor,
    borderWidth: 1,
    snackStyle: SnackStyle.FLOATING,
    padding: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 15),
    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
    titleText: SizedBox(),
    messageText: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        type.icon,
        gap(),
        Expanded(
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: appTextTheme.titleSmall?.copyWith(color: type.titleColor,fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
    duration: Duration(seconds: 2),
    title,
    message,
    colorText: type.titleColor,
    backgroundColor: type.bgColor,
  );
  // throw Exception({
  //   "user": globalData.activeUser?.username ?? "_",
  //   "user_id": globalData.activeUser?.id ?? "_",
  //   "error": message,
  //   "trace" : trace
  // });
}

void deleteItemPopup(
  BuildContext context, {
  required Future Function(BuildContext) onDelete,
  Function()? onComplete,
  String? title,
  String? subTitle,
  String? buttonText,
  Color? buttonColor,
}) {
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
        child: _DeleteItemBody(
          onDelete,
          title: title,
          subTitle: subTitle,
          buttonText: buttonText,
          onComplete: onComplete,
          buttonColor: buttonColor,
        ),
      );
    },
  );
}

class _DeleteItemBody extends StatelessWidget {
  Future Function(BuildContext) onDelete;
  String? title;
  String? subTitle;
  String? buttonText;
  Color? buttonColor;
  Function()? onComplete;
  _DeleteItemBody(this.onDelete,
      {this.title, this.subTitle, this.buttonText,this.buttonColor, this.onComplete, super.key});
  RxBool isBusy = false.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            padding: AppPadding.pagePaddingAll,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.warning,
                      size: 25,
                      color:buttonColor ?? Colours.blueDark,
                    ),
                    gap(space: 10),
                    Text(
                      title ?? "Delete Item",
                      style: appTextTheme.titleMedium?.copyWith(
                        color: Colours.blueDark,
                      ),
                    )
                  ],
                ),
                gap(),
                Text(
                  subTitle ?? "Are you sure you want to delete this item?",
                  style: appTextTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.normal),
                ),
                gap(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: PrimaryBorderButton(
                        bgColor: Colours.bgColor,
                          title: appStrings.cancel,
                          onTap: () {
                            Get.back();
                          },
                          isFullWidth: false),
                    ),
                    gap(space: 30),
                    Expanded(
                      child: Obx(
                        () => PrimaryButton(
                          title: buttonText ?? appStrings.delete,
                          color: buttonColor??Colours.red,
                          isBusy: isBusy.value,
                          onTap: () async {
                            isBusy.value = true;
                            try {
                              await onDelete(context);
                              Get.back();
                              if (onComplete != null) onComplete!();
                            } catch (e) {}
                            isBusy.value = false;
                          },
                          isFullWidth: false,
                        ),
                      ),
                    )
                  ],
                )
              ],
            )),
      ],
    );
  }
}

errorSnackBar(
    {String? title,
    required String message,
    SnackBarType type = SnackBarType.error}) {
  showSnackBar(title: title ?? "Error", message: message, type: type);
}

successSnackBar(
    {String? title,
    required String message,
    SnackBarType type = SnackBarType.success}) {
  showSnackBar(title: title ?? "Success", message: message, type: type);
}

infoSnackBar(
    {String? title,
    required String message,
    SnackBarType type = SnackBarType.info}) {
  showSnackBar(title: title ?? "Info", message: message, type: type);
}

messageSnackBar(
    {String? title,
    required String message,
    SnackBarType type = SnackBarType.message}) {
  showSnackBar(title: title ?? "Info", message: message, type: type);
}
