import 'package:jog_inventory/common/constant/values.dart';
import 'package:jog_inventory/common/exports/common.dart';
import 'package:jog_inventory/common/utils/bottom_sheet.dart';
import 'package:jog_inventory/services/tab_view_navigator.dart';

openInkPaperFilterPopup(BuildContext context,
    {String? selectedMonth,
    String? selectedYear,
    FilterItem<String>? filter,
    required void Function(
            {String? selectedMonth,
            String? selectedYear,
            required FilterItem<String>? colorFilter})
        onChanged}) {
  showAppBottomSheet(
      context,
      _FilterDateColorScreen(
        selectedMonth: selectedMonth,
        selectedYear: selectedYear,
        filter: filter,
        onChanged: onChanged,
      ),
      title: "Filter by");
}

class _FilterDateColorScreen extends StatefulWidget {
  final String? selectedMonth;
  final String? selectedYear;
  final FilterItem<String>? filter;
  final void Function(
      {String? selectedMonth,
      String? selectedYear,
      required FilterItem<String>? colorFilter}) onChanged;
  const _FilterDateColorScreen(
      {this.selectedMonth,
      this.selectedYear,
      this.filter,
      required this.onChanged,
      super.key});

  @override
  State<_FilterDateColorScreen> createState() => _FilterDateColorScreenState();
}

class _FilterDateColorScreenState extends State<_FilterDateColorScreen> {
  List<String> get monthNames => yearMonths(short: true);
  List<FilterItem<String>> _items = List.generate(
      inkColors.length,
      (index) => FilterItem(
          id: index + 1,
          title: inkColors[index],
          key: inkColors[index],
          isSelected: false,
          value: inkColors[index]));
  FilterItem<String>? selectedItem;

  late List<DropDownItem<String>> months = List.generate(
      monthNames.length,
      (index) => DropDownItem(
          id: index + 1,
          title: monthNames[index],
          key: monthNames[index],
          isSelected: false,
          value: "${index + 1}"));
  late DropDownItem<String> selectedMonth;

  List<DropDownItem<String>> years = List.generate(
      20,
      (index) => DropDownItem(
            id: timeNow().year - index,
            title: "${timeNow().year - index}",
            key: "${timeNow().year - index}",
            isSelected: false,
            value: "${timeNow().year - index}",
          ));
  late DropDownItem<String> selectedYear;

  @override
  void initState() {
    selectedItem = widget.filter;
    var year = widget.selectedYear!;
    var month = widget.selectedMonth!;

    /// Year
    selectedYear = DropDownItem(
      id: int.parse(year),
      title: year,
      key: year,
      isSelected: false,
      value: year,
    );

    /// Month
    selectedMonth =
        months.firstWhereOrNull((item) => item.value == month) ?? months.first;

    super.initState();
  }

  void _handleSelection(FilterItem<String>? item) {
    selectedItem = item;
    selectedItem?.onTap?.call();
    setState(() {});
  }

  bool isSelected(FilterItem<String> item) => selectedItem?.id == item.id;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Date",
              style: appTextTheme.titleMedium,
            ),
            gap(space: 10),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: SecondaryFieldMenu<String>(
                    borderRadius: 20,
                    items: months,
                    selectedItem: selectedMonth,
                    onChanged: (DropDownItem<String>? item) {
                      selectedMonth = item ?? months.first;
                    },
                    hintText: Strings.selectType,
                  ),
                ),
                gap(space: 10),
                Expanded(
                  flex: 2,
                  child: SecondaryFieldMenu(
                    borderRadius: 20,
                    items: years,
                    selectedItem: selectedYear,
                    onChanged: (DropDownItem<String>? item) {
                      selectedYear = item ?? years.first;
                    },
                    hintText: Strings.selectType,
                  ),
                ),
                gap(space: 10),
                // Expanded(child: SizedBox()),
                Expanded(flex: 3, child: SizedBox()),
              ],
            ),
            gap(),
            Text(
              "Color",
              style: appTextTheme.titleMedium,
            ),
            gap(space: 10),
            Wrap(spacing: 10, runSpacing: 10, children: [
              ..._items.map((item) {
                return isSelected(item)
                    ? Container(
                        // margin: const EdgeInsets.only(right: 5),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: Colours.primary,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              item.title,
                              style: appTextTheme.labelMedium?.copyWith(
                                  color: Colours.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                selectedItem = null;
                                setState(() {});
                                _handleSelection(null);
                              },
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 24,
                              ),
                            )
                          ],
                        ),
                      )
                    : GestureDetector(
                        onTap: () => _handleSelection(item),
                        child: Container(
                          // margin: const EdgeInsets.only(right: 5),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colours.border),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            item.title,
                            style: appTextTheme.labelMedium,
                          ),
                        ),
                      );
              })
            ]),
            gap(space: config.isTablet ? 100 : 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PrimaryButton(
                    title: "Cancel",
                    onTap: () {
                      mainNavigationService.back(context);
                    },
                    isFullWidth: false,
                    borderColor: Colours.greyLight,
                    textColor: Colours.greyLight,
                    color: Colours.bgGrey,
                    trailing: Icon(
                      Icons.close,
                      size: 20,
                      color: Colours.greyLight,
                    )),
                gap(space: 10),
                PrimaryButton(
                    title: "Apply",
                    onTap: () {
                      widget.onChanged(
                          selectedYear: selectedYear.value,
                          selectedMonth: selectedMonth.value,
                          colorFilter: selectedItem);
                      mainNavigationService.back(context);
                    },
                    isFullWidth: false,
                    color: Colours.greenLight,
                    trailing: Icon(
                      Icons.check,
                      size: 23,
                      color: Colours.white,
                    )),
              ],
            ),

            ///
            SafeAreaBottom(context)
          ],
        ),
      ),
    );
  }
}
