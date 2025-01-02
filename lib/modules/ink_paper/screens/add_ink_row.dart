import 'package:jog_inventory/common/utils/date_time_picker.dart';
import 'package:jog_inventory/common/utils/validation.dart';
import 'package:jog_inventory/common/widgets/dotted_border.dart';
import 'package:jog_inventory/modules/ink_paper/controllers/add_ink_row.dart';
import 'package:jog_inventory/modules/ink_paper/modles/add_row.dart';
import 'package:jog_inventory/modules/ink_paper/widgets/add_row_ink.dart';
import '../../../common/exports/main_export.dart';

class AddInkRowScreen extends StatefulWidget {
  const AddInkRowScreen({super.key});

  @override
  State<AddInkRowScreen> createState() => _AddInkRowScreenState();
}

class _AddInkRowScreenState extends State<AddInkRowScreen> {
  var controller = AddInkRowController.getController();

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: "Add Ink Row",
      body: body,
      bottomNavBar: bottomNavBar(),
    );
  }

  Widget body(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        padding: AppPadding.pagePadding,
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              ...displayList<InkRowDataItem>(
                  items: controller.items, builder: addedItemTileWidget),
            ],
          ),
        ),
      ),
    );
  }

  /// item
  Widget addedItemTileWidget(InkRowDataItem item, int index) {
    return Container(
      margin: AppPadding.pagePadding,
      decoration: containerDecoration(),
      child: Column(
        children: [
          gap(space: 10),
          // Color
          Container(
            padding: AppPadding.inner,
            child: Row(
              children: [
                Text(
                  "Color",
                  style: appTextTheme.titleMedium,
                ),
                gap(),
                Expanded(
                  child: PrimaryFieldMenu<String>(
                    validation: validation.validateEmptyField,
                    initialItems: [
                      DropDownItem<String>(
                        id: inkColors.indexWhere((va) => va == item.inkColor),
                        title: item.inkColor!,
                        key: item.inkColor!,
                        value: item.inkColor,
                      ),
                    ],
                    items: [
                      ...List.generate(
                        inkColors.length,
                        (i) => DropDownItem<String>(
                          id: i,
                          title: inkColors[i],
                          key: inkColors[i],
                          value: inkColors[i],
                        ),
                      )
                    ],
                    allowSearch: true,
                    onChanged: (val) {
                      item.inkColor = val?.firstOrNull?.value;
                    },
                    hintText: "Color",
                  ),
                ),
                gap(space: 100),
                Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        controller.items.remove(item);
                      },
                      child: Icon(Icons.delete_outlined,
                          size: 25, color: Colours.red),
                    )),
              ],
            ),
          ),
          divider(),
          Container(
              padding: AppPadding.inner,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Date
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: DateTimePickerField(
                            validation: validation.validateEmptyField,
                            initialDateTime:
                                ParseData.toDateTime(item.receiptDate),
                            onChanged: (String? date) {
                              item.receiptDate = date;
                            },
                            hintText: "",
                            labelText: "Receipt Date"),
                      ),
                      gap(space: 10),
                      Expanded(
                          child: TextFieldWithLabel(
                        labelText: "Supplier",
                        validation: validation.validateEmptyField,
                        initialValue: item.supplier,
                        onChanged: (data) {
                          item.supplier = data;
                        },
                      ))
                    ],
                  ),
                  gap(space: 10),

                  /// PO
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFieldWithLabel(
                          labelText: "PO",
                          validation: validation.validateEmptyField,
                          initialValue: item.po,
                          onChanged: (data) {
                            item.po = data;
                          },
                        ),
                      ),
                      gap(space: 10),
                      Expanded(
                          child: TextFieldWithLabel(
                        labelText: "IM",
                        validation: validation.validateEmptyField,
                        initialValue: item.imSupplier,
                        onChanged: (data) {
                          item.imSupplier = data;
                        },
                      ))
                    ],
                  ),
                  gap(space: 10),

                  /// rolls
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFieldWithLabel(
                          labelText: "No.",
                          validation: validation.validateEmptyField,
                          inputFormatters: inputFormatters(allowInt: true),
                          initialValue: "${item.rollNo ?? 0}",
                          onChanged: (data) {
                            item.rollNo = int.tryParse(data);
                          },
                        ),
                      ),
                      gap(space: 10),
                      Expanded(
                          child: TextFieldWithLabel(
                        labelText: "In Stock (ml)",
                            inputFormatters: inputFormatters(allowInt: true,allowDouble: true),
                        validation: validation.validateEmptyField,
                        initialValue: "${item.inStockMl}",
                        onChanged: (data) {
                          item.inStockMl = int.tryParse(data);
                        },
                      )),
                      gap(space: 10),
                      Expanded(
                          child: TextFieldWithLabel(
                        labelText: "Price (l/tbh)",
                            inputFormatters: inputFormatters(allowInt: true,allowDouble: true),
                        validation: validation.validateEmptyField,
                        initialValue: "${item.priceLb}",
                        onChanged: (data) {
                          item.priceLb = int.tryParse(data);
                        },
                      ))
                    ],
                  ),
                  gap(space: 10),

                  /// used balance used date
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFieldWithLabel(
                          labelText: "Used Ml",
                          validation: validation.validateEmptyField,
                          inputFormatters: inputFormatters(allowInt: true,allowDouble: true),
                          initialValue: "${item.usedMl ?? ""}",
                          onChanged: (data) {
                            item.usedMl = (data);
                          },
                        ),
                      ),
                      gap(space: 10),
                      Expanded(
                          child: TextFieldWithLabel(
                        labelText: "Bal.",
                            inputFormatters: inputFormatters(allowInt: true,allowDouble: true),
                        validation: validation.validateEmptyField,
                        initialValue: "${item.inkBalanceMl}",
                        onChanged: (data) {
                          item.inkBalanceMl = (data);
                        },
                      )),
                      gap(space: 10),
                      Expanded(
                          child: TextFieldWithLabel(
                        labelText: "Used value",
                        inputFormatters: inputFormatters(allowInt: true),
                        validation: validation.validateEmptyField,
                        initialValue: "${item.used}",
                        onChanged: (data) {
                          item.used = (data);
                        },
                      ))
                    ],
                  ),
                  gap(space: 10),
                ],
              )),
          // bottom
          gap(space: 10)
        ],
      ),
    );
  }

  Widget bottomNavBar() {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: Container(
              color: Colours.white,
              child: InkWell(
                onTap: () {
                  openAddRowInkSheet(onChange: (items) {
                    controller.items.addAll(items);
                  });
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
                        child: Text("Add Row",
                            style: appTextTheme.titleSmall
                                ?.copyWith(color: Colours.green)))),
              ),
            ),
          ),
          if (controller.items.length > 0) ...[
            gap(),
            Expanded(
                child: PrimaryButton(
                    title: "Submit",
                    onTap: controller.submit,
                    isBusy: controller.isBusy.value))
          ]
        ],
      ),
    );
  }
}
