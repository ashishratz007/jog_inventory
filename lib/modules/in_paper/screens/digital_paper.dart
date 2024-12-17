import 'package:jog_inventory/common/utils/custom_expansion_tile.dart';
import 'package:jog_inventory/common/utils/date_formater.dart';
import 'package:jog_inventory/common/utils/date_time_picker.dart';
import 'package:jog_inventory/common/utils/filter_widget.dart';
import 'package:jog_inventory/common/widgets/dotted_border.dart';
import 'package:jog_inventory/modules/in_paper/controllers/digital_paper.dart';
import 'package:jog_inventory/modules/in_paper/modles/digital_paper.dart';
import 'package:jog_inventory/modules/in_paper/widgets/add_row_ink.dart';
import 'package:jog_inventory/modules/in_paper/widgets/stock_data.dart';
import 'package:jog_inventory/modules/in_paper/widgets/upadte_stock.dart';
import 'package:jog_inventory/modules/in_paper/widgets/update_paper_data.dart';

import '../../../common/exports/main_export.dart';

class DigitalPaperScreen extends StatefulWidget {
  const DigitalPaperScreen({super.key});

  @override
  State<DigitalPaperScreen> createState() => _DigitalPaperScreenState();
}

class _DigitalPaperScreenState extends State<DigitalPaperScreen> {
  @override
  DigitalPaperController controller = DigitalPaperController.getController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomAppBar(
        title: "Digital Paper List",
        body: body,
        trailingButton: selectButton(),
        bottomNavBar: controller.enableSelect.value ? bottomNavBar() : null,
      ),
    );
  }

  Widget body(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        child: Container(
          padding: AppPadding.pagePadding,
          child: Column(
            children: [
              /// header with filter
              head(),
              gap(),
              if (!controller.isLoading.value) ...displayItems(),
              if (controller.isLoading.value) listLoadingEffect(),

              ///Bottom
              SafeAreaBottom(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomNavBar() {
    return Container(
      color: Colours.white,
      child: Row(
        children: [
          Expanded(
            child: PrimaryButton(
                title: "Delete",
                leading: Icon(
                  Icons.delete_outline,
                  color: Colours.red,
                ),
                onTap: () {
                  /// TODO
                },
                radius: 10,
                textColor: Colours.red,
                color: Colours.redBg),
          ),
          gap(),
          Expanded(
            child: Obx(
              () => PrimaryButton(
                isEnable: controller.selected.length > 0,
                title: "Update",
                onTap: () {
                  openUpdatePaperSheet(context,
                      items: controller.items
                          .where(
                              (item) => controller.selected.contains(item.id))
                          .toList());
                },
                radius: 10,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget head() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /// stock data
            TextBorderButton(
                onTap: () {
                  openStockDataBottomSheet();
                },
                title: Strings.stockData,
                color: Colours.primary,
                borderColor: Colours.primary),
            Expanded(child: SizedBox()),

            /// button
            InkWell(
              onTap: () {
                openAddRowInkSheet();
              },
              child: DottedBorderContainer(
                  borderColor: Colours.green,
                  padding: AppPadding.inner,
                  gap: 2,
                  borderWidth: 1.5,
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(10),
                  // ),
                  borderRadius: BorderRadius.circular(10),
                  child: Center(
                      child: Text("+ Add Row",
                          style: appTextTheme.titleSmall
                              ?.copyWith(color: Colours.green)))),
            ),

            /// select all
            Obx(
              () => Visibility(
                visible: controller.enableSelect.value,
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: IconButton(
                    onPressed: () {
                      if (controller.selected.length ==
                          controller.controllers.length) {
                        controller.selected.clear();
                      } else {
                        List.generate(controller.controllers.length,
                            (index) => controller.selected.add(index));
                      }
                    },
                    icon: (controller.selected.length ==
                            controller.controllers.length)
                        ? Icon(
                            Icons.library_add_check_outlined,
                            color: Colours.secondary,
                            size: 30,
                          )
                        : Icon(
                            Icons.check_box_outline_blank,
                            color: Colours.secondary,
                            size: 30,
                          ),
                  ),
                ),
              ),
            )
          ],
        ),
        gap(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: 180,
                child: DateTimePickerField(
                  formatDate: dateTimeFormat.mmYYFormat,
                  initialDateTime: DateTime.now(),
                  lastDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  onChanged: (String? date) {
                    var data = ParseData.toDateTime(date);
                    if (data != null) controller.selectedDate = data;
                    controller.getInkListData();
                  },
                )),
            Row(
              children: [
                Text("Collapse", style: appTextTheme.labelMedium),
                Obx(
                  () => Transform.scale(
                    scale:
                        0.6, // Adjust the scale to change the size (height and width)
                    child: Switch(
                      activeColor: Colours.primary,
                      value: controller.isCollapsed.value,
                      onChanged: (value) {
                        controller.isCollapsed.value = value;
                        controller.toggleCollapse(controller.isCollapsed.value);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        gap(),
        FilterWidget<String>(
          selectedItem: controller.colorFilter.value,
          items: [
            FilterItem(
                id: 1,
                title: '100',
                key: '100',
                isSelected: false,
                value: "100"),
            FilterItem(
                id: 2,
                title: '200',
                key: '200',
                isSelected: false,
                value: "200"),
          ],
          onChange: (FilterItem<String>? selectedItem) {
            if (selectedItem == null) {
              controller.colorFilter.value =
                  FilterItem<String>(id: 0, title: '', key: '');
            } else {
              controller.colorFilter.value = selectedItem;
            }
            controller.getInkListData();
          },
        ),
      ],
    );
  }

  Widget selectButton() {
    return SizedBox(
      height: 35,
      child: Obx(
        () => PrimaryButton(
            padding: EdgeInsets.only(left: 16, right: 16),
            radius: 10,
            textSize: 14,
            color: Colours.white.withOpacity(0.3),
            isFullWidth: false,
            title: controller.enableSelect.value ? "Cancel" : "Select",
            onTap: () {
              controller.enableSelect.value = !controller.enableSelect.value;
            }),
      ),
    );
  }

  List<Widget> displayItems() {
    return displayList<DigitalPaperModel>(
        items: controller.items, builder: itemTileWidget, showGap: true);
  }

  Widget itemTileWidget(
    DigitalPaperModel item,
    int index,
  ) {
    return CustomExpandedTile(
      controller: controller.controllers[index],
      head: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Row(
                children: [
                  Text("Size"),
                  gap(),
                  Text("${item.paperSize ?? "_"}"),
                ],
              ),
              Expanded(child: SizedBox()),
              Obx(
                () => Row(
                  children: [
                    if (controller.enableSelect.value)
                      IconButton(
                        onPressed: () {
                          // if(item.inkBalanceMl?.trim() == "0" || item.inkBalanceMl?.trim() == ""){
                          //   errorSnackBar(message: "Paper bal is 0");
                          //   return;
                          // }
                          if (controller.selected.contains(item.id)) {
                            controller.selected.remove(item.id);
                          } else {
                            controller.selected.add(item.id!);
                          }
                        },
                        icon: (controller.selected.contains(item.id))
                            ? Icon(
                                Icons.check_box,
                                color: Colours.secondary,
                              )
                            : Icon(
                                Icons.check_box_outline_blank,
                                color: Colours.secondary,
                              ),
                      )
                    else ...[
                      Icon(
                        Icons.edit,
                        size: 24,
                        color: Colors.grey,
                      ),
                      gap(),
                      Icon(
                        Icons.delete_outline,
                        size: 24,
                        color: Colours.red,
                      )
                    ],
                  ],
                ),
              ),
            ],
          )),
      children: [
        displayChildren([
          ["Po", "${item.po ?? "_"}"],
          ["Supplier", "${item.supplier ?? "_"}"]
        ]),
        gap(),
        displayChildren([
          ["No.", "${item.rollNo ?? "_"}"],
          ["Date", "${item.receiptDate ?? "_"}"]
        ]),
        gap(),
        displayChildren([
          ["IM", "${item.imSupplier ?? "_"}"],
          ["Price (yads)", "1450"]
        ]),
        gap(),
        displayChildren([
          ["Used", "0"],
          ["In Stock", "${item.inStock ?? "_"}"]
        ]),
      ],
      bottom: DottedBorderContainer(
        borderRadius: BorderRadius.circular(10),
        borderColor: Colours.border,
        child: Container(
          decoration: BoxDecoration(
            color: Colours.border.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Used yads",
                    style: appTextTheme.labelSmall,
                  ),
                  gap(space: 40),
                  Text(
                    "Used on",
                    style: appTextTheme.labelSmall,
                  )
                ],
              ),
              gap(space: 20),
              divider(color: Colors.white, thickness: 1.2),
              gap(space: 10),
              Row(
                children: [
                  Text(
                    "${item.usedYads ?? "_"}",
                    style: appTextTheme.labelSmall,
                  ),
                  gap(space: 40),
                  Text(
                    "${item.usedDate}",
                    style: appTextTheme.labelSmall
                        ?.copyWith(color: Colours.primary),
                  ),
                  Expanded(child: SizedBox()),
                  PrimaryButton(
                      title: "Update",
                      onTap: () {
                        openUpdateStockDataBottomSheet();
                      },
                      isFullWidth: false,
                      radius: 15)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget displayChildren(List<List<String>> items) {
    return Row(
      children: [
        Expanded(flex: 3, child: displayTitle(items[0])),
        // Expanded(child: SizedBox()),
        Expanded(flex: 5, child: displayTitle(items[1], isTrailing: true)),
      ],
    );
  }

  Widget displayTitle(List<String> items, {bool isTrailing = false}) {
    return Row(
      children: [
        Expanded(
            flex: isTrailing ? 3 : 1,
            child: Text(items[0], style: appTextTheme.labelSmall)),
        gap(space: 10),
        Expanded(
            flex: isTrailing ? 5 : 2,
            child: Text(
              items[1],
              style:
                  appTextTheme.labelSmall?.copyWith(color: Colours.greyLight),
            )),
      ],
    );
  }
}
