import 'package:jog_inventory/common/animations/overlay_animation.dart';
import '../exports/main_export.dart';
import 'date_formater.dart';

Future<DateTime?> SelectDateTime(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    useRootNavigator: true,
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(Duration(days: 365)),
  );
  return picked;
}

Widget DateTimePickerField(
  BuildContext context, {
  required String labelText,
  String? hintText,
  TextEditingController? controller,
  EdgeInsets padding =
      const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
  TextStyle? style,
  AutovalidateMode? autovalidateMode,
  DateTime? DateTime,
  bool canRequestFocus = true,
  bool enabled = true,
  FocusNode? focusNode,
  void Function(String?)? onSaved,
  String? Function(String?)? validation,
  void Function(String?)? onChanged,
  TextAlign textAlign = TextAlign.start,
  String? Function(DateTime?)? formatDate,
}) {
  if (formatDate == null) formatDate = dateTimeFormat.yyMMDDFormat;
  // widget
  if (controller == null) controller = TextEditingController();
  return StatefulBuilder(builder: (context, setState) {
    return IgnorePointer(
      ignoring: !enabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            textAlign: TextAlign.start,
            style: appTextTheme.bodyMedium,
          ),
          SizedBox(height: 10),
          Container(
            color: Colors.white,
            child: TextFormField(
              // enabled: false,
              controller: controller,
              autovalidateMode: autovalidateMode,
              style: style,
              onChanged: onChanged,
              onSaved: onSaved,
              readOnly: true,
              decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(),
                  contentPadding: padding,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.3), width: 1.0),
                  ),
                  suffixIcon: Icon(
                    Icons.date_range,
                    size: 25,
                    color: Colors.black54,
                  )),
              validator: validation,
              focusNode: focusNode,
              textAlign: textAlign,
              canRequestFocus: canRequestFocus,
              onTap: () async {
                var selectedDate = await SelectDateTime(context);
                controller!.text = formatDate!(selectedDate) ?? "";
                if (onChanged != null) onChanged(controller.text);
                FocusScope.of(context).unfocus();
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  });
}

Widget monthYearPicker(
  BuildContext context, {
  String? title,
  FocusNode? focusNode,
  int? maxYear,
  int minYear = 2000,
  int? selectedYear,
  int? selectedMonth,
  required Function(int year, int month) onChange,
}) {
  RxInt selectedYearObs = (selectedYear ?? DateTime.now().year).obs;
  if (focusNode == null) {
    focusNode = FocusNode();
  }

  if (maxYear == null) {
    maxYear = DateTime.now().year;
  }

  if (selectedYear == null) {
    selectedYear = DateTime.now().year;
  }

  if (selectedMonth == null) {
    selectedMonth = DateTime.now().month;
  }
  double radius = 10;

  final List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'June',
    'July',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  var dateTimeField = Obx(
    () => SizedBox(
        width: 150,
        child: PrimaryTextField(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 5,right: 5),
              child: Icon(
                Icons.calendar_today_outlined,
                size: 15,
                color: Colours.blueDark,
              ),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(left: 5,right: 5),
              child: Icon(
                Icons.expand_more,
                size: 20,
                color: Colours.blueDark,
              ),
            ),
            style: TextStyle(
                fontSize: 13,
                color: Colours.blueDark,
                fontWeight: FontWeight.w600),
            key: Key(
                "${months[(selectedMonth ?? 1) - 1]}/${selectedYearObs.value}"),
            enabled: false,
            initialValue: title ??
                "${months[(selectedMonth ?? 1) - 1]}/${selectedYearObs.value}")),
  );

  var overlayWidget = Container(
    decoration: BoxDecoration(
      color: Colours.white,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3),
        ),
      ],
    ),
    width: 300,
    child: Column(
      children: [
        Obx(
          () => Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colours.blueDark,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(radius),
                  topLeft: Radius.circular(radius),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      selectedYearObs.value--;
                    },
                    icon: Icon(Icons.arrow_back_ios_rounded,
                        size: 20, color: Colors.white)),
                gap(space: 10),
                Text("${selectedYearObs.value}",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 14)),
                gap(space: 10),
                IconButton(
                    onPressed: () {
                      selectedYearObs.value++;
                    },
                    icon: Icon(Icons.arrow_forward_ios_rounded,
                        size: 20, color: Colors.white)),
              ],
            ),
          ),
        ),
        GridView.builder(
          padding: EdgeInsets.only(left: 5, right: 5, bottom: 30, top: 20),
          shrinkWrap: true, // To make the GridView fit its content
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 35,
            crossAxisCount: 4,
            mainAxisSpacing: 5.0, // Spacing between rows
            crossAxisSpacing: 5.0, // Spacing between columns
            childAspectRatio: 0.5, // Adjust aspect ratio as needed
          ),
          itemCount: months.length,
          itemBuilder: (context, index) {
            var month = months[index];
            return InkWell(
              focusNode: focusNode,
              borderRadius: BorderRadius.circular(8.0),
              onTap: () {
                selectedMonth = index + 1;
                onChange(selectedYearObs.value, selectedMonth ?? 1);
                focusNode?.unfocus();
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color:
                      selectedMonth == (index + 1) ? Colours.primaryText : null,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  month,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color:
                        selectedMonth == (index + 1) ? Colours.blueDark : null,
                  ),
                ),
              ),
            );
          },
        )
      ],
    ),
  );
  return OverlayAnimationWidget(
      focusNode: focusNode, overlayWidget: overlayWidget, child: dateTimeField);
}
