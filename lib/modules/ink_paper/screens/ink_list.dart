import 'package:jog_inventory/common/constant/values.dart';
import 'package:jog_inventory/common/utils/bottom_sheet.dart';
import 'package:jog_inventory/common/utils/custom_expansion_tile.dart';
import 'package:jog_inventory/common/utils/date_formater.dart';
import 'package:jog_inventory/common/utils/date_time_picker.dart';
import 'package:jog_inventory/common/utils/dotted_border.dart';
import 'package:jog_inventory/common/utils/filter_widget.dart';
import 'package:jog_inventory/common/utils/menu.dart';
import 'package:jog_inventory/modules/ink_paper/controllers/ink_List_controller.dart';
import 'package:jog_inventory/modules/ink_paper/modles/ink_model.dart';
import 'package:jog_inventory/modules/ink_paper/widgets/add_row_ink.dart';
import 'package:jog_inventory/modules/ink_paper/widgets/filter_popup.dart';
import 'package:jog_inventory/modules/ink_paper/widgets/stock_data.dart';
import 'package:jog_inventory/modules/ink_paper/widgets/upadte_stock.dart';
import 'package:jog_inventory/modules/ink_paper/widgets/update_ink.dart';
import 'package:jog_inventory/modules/ink_paper/widgets/update_paper_data.dart';
import '../../../common/exports/main_export.dart';

class InkListScreen extends StatefulWidget {
  const InkListScreen({super.key});

  @override
  State<InkListScreen> createState() => _InkListScreenState();
}

class _InkListScreenState extends State<InkListScreen> {
  InkListController controller = InkListController.getController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomAppBar(
        title: "Ink List",
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  controller.deleteInkList(context,
                      remItem: controller.items
                          .where(
                              (item) => controller.selected.contains(item.id))
                          .toList());
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
                  openUpdateInkSheet(context,
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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            /// stock data
            // TextBorderButton(
            //     onTap: () {
            //       openStockDataBottomSheet();
            //     },
            //     title: Strings.stockData,
            //     color: Colours.primary,
            //     borderColor: Colours.primary),
            // Expanded(child: SizedBox()),

            /// button
            InkWell(
              onTap: () {
                mainNavigationService.push(AppRoutesString.addInkRow);
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
            PrimaryButton(
                title: "Filter",
                isFullWidth: false,
                borderColor: Colours.greyLight,
                showBorder: true,
                textColor: Colours.blackLite,
                color: Colours.white,
                leading: Icon(
                  Icons.filter_alt_off,
                  size: 20,
                  color: Colours.blackLite,
                ),
                onTap: () {
                  onchangeFilter(
                      {String? selectedMonth,
                      String? selectedYear,
                      String? inkType,
                      FilterItem<String>? colorFilter}) {
                    /// color filter
                    if (colorFilter == null) {
                      controller.colorFilter.value =
                          FilterItem<String>(id: 0, title: '', key: '');
                    } else {
                      controller.colorFilter.value = colorFilter;
                    }

                    /// date year month
                    controller.selectedMonth =
                        selectedMonth ?? timeNow().month.toString();
                    controller.selectedYear =
                        selectedYear ?? timeNow().year.toString();

                    /// type
                    controller.selectedType =
                        inkType ?? "1000";
                    controller.getInkListData();
                  }

                  // open filter popup
                  openInkPaperFilterPopup(context,
                      onChanged: onchangeFilter,
                      selectedMonth: controller.selectedMonth,
                      selectedYear: controller.selectedYear,
                      inkType: controller.selectedType,
                      isPaper: false,
                      filter: controller.colorFilter.value);
                }),
            Obx(
              () => Row(
                children: [
                  Text("Page",
                      style: appTextTheme.titleSmall?.copyWith(
                          color: Colours.blackLite,
                          fontWeight: FontWeight.w700)),
                  Gap(10),
                  popupMenu(Get.context!,
                      items: [
                        ...List.generate(
                            controller.totalPages.value,
                            (index) => MenuItem(
                                title: '${index + 1}',
                                onTap: (value) {
                                  controller.currentPage.value = index + 1;
                                  controller.getInkListData();
                                },
                                id: index,
                                key: "$index"))
                      ],
                      menuIcon: Container(
                        height: 40,
                        width: 70,
                        decoration: BoxDecoration(
                            color: Colours.white,
                            border: Border.all(color: Colours.border),
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                            child: Text("${controller.currentPage.value}",
                                style: appTextTheme.titleSmall?.copyWith(
                                    color: Colours.blackLite,
                                    fontWeight: FontWeight.w700))),
                      )),
                  Gap(10),
                  Text("of ${controller.totalPages.value}",
                      style: appTextTheme.titleSmall?.copyWith(
                          color: Colours.blackLite,
                          fontWeight: FontWeight.w700)),
                ],
              ),
            )
          ],
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
    return displayList<InkModel>(
        items: controller.items, builder: itemTileWidget, showGap: true);
  }

  Widget itemTileWidget(
    InkModel item,
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
                  Text("Color"),
                  gap(),
                  Text("${item.inkColor ?? "_"}"),
                ],
              ),
              Expanded(child: SizedBox()),
              Obx(
                () => Row(
                  children: [
                    if (controller.enableSelect.value) ...[
                      InkWell(
                        onTap: () {
                          // if(item.inkBalanceMl?.trim() == "0" || item.inkBalanceMl?.trim() == ""){
                          //   errorSnackBar(message: "Ink bal is 0");
                          //   return;
                          // }
                          if (controller.selected.contains(item.id)) {
                            controller.selected.remove(item.id);
                          } else {
                            controller.selected.add(item.id!);
                          }
                        },
                        child: (controller.selected.contains(item.id))
                            ? Icon(
                                Icons.check_box,
                                color: Colours.secondary,
                                size: 22,
                              )
                            : Icon(
                                Icons.check_box_outline_blank,
                                color: Colours.secondary,
                                size: 22,
                              ),
                      ),
                    ] else ...[
                      Icon(
                        Icons.edit,
                        size: 24,
                        color: Colors.grey,
                      ),
                      gap(),
                      InkWell(
                        onTap: () {
                          controller.deleteInkList(context, remItem: [item]);
                        },
                        child: Icon(
                          Icons.delete_outline,
                          size: 24,
                          color: Colours.red,
                        ),
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
          ["IM", "${item.imSupplier ?? "_"}ml"],
          ["Price(l/tbh)", "1450"]
        ]),
        gap(),
        displayChildren([
          ["Used", "0"],
          ["In Stock", "${item.inStockMl ?? "_"}(ml)"]
        ]),
        gap(),
        displayChildren([
          ["Bal.", "${item.inkBalanceMl ?? "_"}(ml)"],
          ["", ""]
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
                    "Used ML",
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
                    "${item.usedMl}",
                    style: appTextTheme.labelSmall,
                  ),
                  gap(space: 40),
                  Text(
                    "${item.receiptDate}",
                    style: appTextTheme.labelSmall
                        ?.copyWith(color: Colours.primary),
                  ),
                  Expanded(child: SizedBox()),
                  PrimaryButton(
                      title: "Update",
                      onTap: () {
                        openUpdateInkSheet(context, items: [item].toList());
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
