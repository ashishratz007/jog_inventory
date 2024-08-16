import '../exports/main_export.dart';

Widget PrimaryTextField(
    {String? hintText,
    Key? key,
    EdgeInsets padding = AppPadding.textFieldPadding,
    TextStyle? style,
    void Function()? onTap,
    AutovalidateMode? autovalidateMode,
    TextEditingController? controller,
    bool canRequestFocus = true,
    bool allowShadow = false,
    bool? enabled,
    FocusNode? focusNode,
    double radius = 5,
    double fontSize = 15,
    double? height,
    Widget? suffixIcon,
    Widget? prefixIcon,
    int maxLines = 1,
    TextInputAction textInputAction = TextInputAction.next,
    String? initialValue,
    Color? borderColor,
    void Function(String)? onChanged,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
    void Function(String)? onFieldSubmitted,
    bool obscureText = false,
    bool readOnly = false,
    bool autofocus = false,
    Color? fillColor,
    Color? focusColor,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    int? maxLength,
    int? minLines,
    TextAlign textAlign = TextAlign.start}) {
  // widget
  if (fillColor == null) fillColor = Colours.white;
  // focusNode ??= FocusNode();
  return Container(
    key: key,
    height: height,
    decoration: BoxDecoration(
        boxShadow:allowShadow? containerShadow():null,
      borderRadius: BorderRadius.circular(radius)
    ),
    child: TextFormField(
        enabled: enabled,
        initialValue: initialValue,
        controller: controller,
        autovalidateMode: autovalidateMode,
        style: style ?? appTextTheme.bodyMedium,
        maxLines: maxLines,
        decoration: InputDecoration(
            counterText: "",
            fillColor: fillColor,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(fontSize: fontSize, color: Colors.black54),
            contentPadding: padding,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: BorderSide(
                  color: borderColor ?? Colours.border, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: BorderSide(
                  color: borderColor ?? Colours.border, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: BorderSide(
                  color: focusColor ?? Colours.primary, width: 1.0),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              gapPadding: 0,
              borderSide: BorderSide(color: Colors.red, width: 1.0),
            ),
            // focusedErrorBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(radius),
            //   borderSide: BorderSide(
            //       color: borderColor ?? Colors.grey.withOpacity(0.3), width: 1.0),
            // ),
            prefixIconConstraints: BoxConstraints(),
            suffixIconConstraints: BoxConstraints(),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon),
        focusNode: focusNode,
        textAlign: textAlign,
        // canRequestFocus: canRequestFocus,
        onTap: onTap,
        onChanged: onChanged,
        onSaved: onSaved,
        obscureText: obscureText,
        readOnly: readOnly,
        validator: validator,
        autofocus: autofocus,
        maxLength: maxLength,
        minLines: maxLines,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        onFieldSubmitted: onFieldSubmitted,
        textInputAction: textInputAction),
  );
}

Widget TextFieldWithLabel(
    {Key? key,
    required String labelText,
    Color? labelColor,
    String? labelHintText,
    Color? labelHintTextColor,
    double? fontSize,
    String? hintText,
    Color? fillColor,
    int maxLines = 1,
    bool hintToNExtLine = false,
    bool allowShadow = false,
    Widget? prefixIcon,
    EdgeInsets padding = AppPadding.textFieldPadding,
    TextStyle? style,
    Color? borderColor,
    double? height,
    void Function()? onTap,
    AutovalidateMode? autovalidateMode,
    TextEditingController? controller,
    bool canRequestFocus = true,
    bool? enabled,
    double radius = 5,
    Widget? suffixIcon,
    String? initialValue,
    FocusNode? focusNode,
    void Function(String)? onChanged,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
    void Function(String)? onFieldSubmitted,
    bool obscureText = false,
    bool readOnly = false,
    bool autofocus = false,
    bool showTitle = true,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    int? maxLength,
    int? minLines,
    TextAlign textAlign = TextAlign.start}) {
  labelHintTextColor ??= Colours.greyLight;
  // widget
  return Column(
    key: key,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (showTitle) ...[
        RichText(
          maxLines: 1,
          text: TextSpan(
            style: appTextTheme.bodyMedium?.copyWith(
                fontSize: fontSize, color: Colors.black87.withOpacity(0.7)),
            children: [
              TextSpan(
                  text: labelText,
                  style: appTextTheme.bodyMedium?.copyWith(
                      fontSize: fontSize,
                      color: labelColor ?? Colors.black87.withOpacity(0.7))),
              if (labelHintText != null && !hintToNExtLine)
                TextSpan(
                  text: "  (${labelHintText})",
                  style: TextStyle(
                      color: labelHintTextColor, fontSize: fontSize ?? 12),
                ),
              if (validator != null)
                TextSpan(
                    text: "  *",
                    style: appTextTheme.bodyMedium
                        ?.copyWith(fontSize: 18, color: Colors.grey)),
            ],
          ),
        ),
        if (hintToNExtLine)
          Text(
            "${labelHintText}",
            style:
                TextStyle(color: labelHintTextColor, fontSize: fontSize ?? 12),
          ),
        SizedBox(height: 10)
      ],
      PrimaryTextField(
          allowShadow: allowShadow,
          maxLines: maxLines,
          enabled: enabled,
          controller: controller,
          autovalidateMode: autovalidateMode,
          style: style ?? appTextTheme.bodyMedium,
          hintText: hintText,
          padding: padding,
          focusNode: focusNode,
          textAlign: textAlign,
          canRequestFocus: canRequestFocus,
          onTap: onTap,
          radius: radius,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          initialValue: initialValue,
          onChanged: onChanged,
          onSaved: onSaved,
          obscureText: obscureText,
          readOnly: readOnly,
          validator: validator,
          autofocus: autofocus,
          maxLength: maxLength,
          minLines: maxLines,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          onFieldSubmitted: onFieldSubmitted,
          height: height,
          borderColor: borderColor,
          fillColor: fillColor),
    ],
  );
}
