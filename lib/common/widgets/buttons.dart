
import '../exports/main_export.dart';

Widget PrimaryButton(
    {required String title,
    required void Function() onTap,
    bool isBusy = false,
    bool isFullWidth = true,
    bool isEnable = true,
    Widget? leading,
    Widget? trailing,
    Color? textColor,
    double? textSize,
    EdgeInsets padding =
        const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
    EdgeInsets? margin,
    Color? color,
    double radius = 5}) {
  color ??= Colours.primary;

  Widget buttonBody = Container(
    alignment: Alignment.center,
    margin: margin,
    padding: padding,
    decoration: BoxDecoration(

        /// enable disable color
        color: !isEnable ? Colors.grey.withOpacity(0.4) : color,
        borderRadius: BorderRadius.circular(radius)),
    child: Row(
      mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// leading
        if (leading != null) ...[
          leading,
          Gap(10),
        ],

        /// title
        Flexible(
          child: Text(
            title,
            style: TextStyle(
                fontSize: textSize ?? 16,
                color: textColor ?? Colors.white,
                fontWeight: FontWeight.w700),
            maxLines: 1,
          ),
        ),

        /// trailing
        if (trailing != null) ...[
          Gap(10),
          trailing,
        ],
        if (isBusy) ...[
          SizedBox(width: 10),
          SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ))
        ]
      ],
    ),
  );
  return InkWell(
    onTap: isEnable
        ? () {
            // only allow tap  when button is not busy
            if (!isBusy) onTap();
          }
        : null,
    child: buttonBody,
  );
}

Widget SecondaryButton(
    {required String title,
    required void Function() onTap,
    bool isBusy = false,
    bool isFullWidth = true,
    bool isEnable = true,
    Widget? leading,
    Widget? trailing,
    Color? textColor,
    double? textSize,
    EdgeInsets padding =
        const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
    EdgeInsets? margin,
    Color? color,
    double radius = 5}) {
  color ??= Colours.secondary;

  Widget buttonBody = Container(
    alignment: Alignment.center,
    margin: margin,
    padding: padding,
    decoration: BoxDecoration(

        /// enable disable color
        color: !isEnable ? Colors.grey.withOpacity(0.4) : color,
        borderRadius: BorderRadius.circular(radius)),
    child: Row(
      mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// leading
        if (leading != null) ...[
          leading,
          Gap(10),
        ],

        /// title
        Flexible(
          child: Text(
            title,
            style: TextStyle(
                fontSize: textSize ?? 16,
                color: textColor ?? Colors.white,
                fontWeight: FontWeight.w700),
            maxLines: 1,
          ),
        ),

        /// trailing
        if (trailing != null) ...[
          Gap(10),
          trailing,
        ],
        if (isBusy) ...[
          SizedBox(width: 10),
          SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ))
        ]
      ],
    ),
  );
  return InkWell(
    onTap: isEnable
        ? () {
            // only allow tap  when button is not busy
            if (!isBusy) onTap();
          }
        : null,
    child: buttonBody,
  );
}

Widget IconTextButton(
    {required String title,
    required void Function() onTap,
    Widget? leading,
    Widget? trailing,
    Color? bgColor,
    bool isBusy = false,
    double? width,
    double? height,
    double fontSize = 16,
    Color? textColor,
    double space = 10,
    EdgeInsets padding =
        const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
    EdgeInsets? margin,
    double radius = 30}) {
  textColor ??= Colours.primaryDark;
  bgColor ??= Colors.white;
  return InkWell(
    onTap: isBusy ? null : onTap, // only allow tap  when button is not busy
    child: Container(
      alignment: Alignment.center,
      margin: margin,
      padding: padding,
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(radius)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// leading could be icon or anything else
          if (leading != null) ...[
            leading,
            SizedBox(width: space),
          ],
          Text(title,
              style: TextStyle(
                  fontSize: fontSize,
                  color: textColor,
                  fontWeight: FontWeight.bold)),

          /// trailing could be icon or anything else
          if (trailing != null) ...[
            trailing,
            SizedBox(width: space),
          ],

          /// loading widget
          if (isBusy) ...[
            SizedBox(width: 10),
            SizedBox(
                height: 15,
                width: 15,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ))
          ]
        ],
      ),
    ),
  );
}

Widget PrimaryBorderButton(
    {required String title,
    Color? color,
    Color? bgColor,
    required void Function() onTap,
    bool isBusy = false,
    bool isFullWidth = true,
    Widget? leading,
    Widget? trailing,
    Color? loaderColor,
    Color? borderColor,
    double? textSize,
    EdgeInsets padding =
        const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
    EdgeInsets? margin,
    TextStyle? textStyle,
    double radius = 5}) {
  color ??= Colours.primary;

  Widget buttonBody = Container(
    alignment: Alignment.center,
    margin: margin,
    padding: padding,
    decoration: BoxDecoration(
        border: Border.all(color: borderColor ?? color),
        color: bgColor ?? Colours.primary,
        borderRadius: BorderRadius.circular(radius)),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leading != null) ...[
          leading,
          SizedBox(width: 10),
        ],
        Text(title,
            style: (textStyle ?? appTextTheme.titleMedium?.copyWith(fontSize: textSize))
                ?.copyWith(color: color)),
        if (trailing != null) ...[
          SizedBox(width: 10),
          trailing,
        ],
        if (isBusy) ...[
          SizedBox(width: 10),
          SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: loaderColor ?? Colors.white,
              ))
        ]
      ],
    ),
  );
  return InkWell(
    onTap: isBusy ? null : onTap, // only allow tap  when button is not busy
    child: isFullWidth ? Expanded(child: buttonBody) : buttonBody,
  );
}

Widget TextButtonWidget({
  required Function() onTap,
  required String title,
  Color? color,
  double fontSize = 14,
  FontWeight fontWeight = FontWeight.bold,
  EdgeInsets padding =
      const EdgeInsets.only(left: 0, right: 7, top: 5, bottom: 5),
}) {
  color ??= Colours.secondary;
  return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: Padding(
        padding: padding,
        child: Text(title,
            style: TextStyle(
                fontWeight: fontWeight, fontSize: fontSize, color: color)),
      ));
}

Widget TextBorderButton({
  required Function() onTap,
  required String title,
  Color? color,
  Color? borderColor,
  bool enable = true,
  double fontSize = 14,
  FontWeight fontWeight = FontWeight.bold,
  EdgeInsets padding =
      const EdgeInsets.only(left: 0, right: 7, top: 5, bottom: 5),
}) {
  color ??= Colours.secondary;
  return InkWell(
      onTap:enable? onTap:null,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: !enable?Colours.border: borderColor ?? Colours.secondary, width: 1.5))),
        margin: padding,
        child: Text(title,
            style: TextStyle(
                fontWeight: fontWeight, fontSize: fontSize, color:!enable?Colours.border: color)),
      ));
}
