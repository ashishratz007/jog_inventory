import 'package:jog_inventory/common/utils/date_time_picker.dart';
import 'package:jog_inventory/common/utils/validation.dart';
import 'package:jog_inventory/common/widgets/dotted_border.dart';
import 'package:jog_inventory/modules/ink_paper/controllers/add_ink_row.dart';
import 'package:jog_inventory/modules/ink_paper/controllers/add_paper_row.dart';
import 'package:jog_inventory/modules/ink_paper/modles/add_row.dart';
import 'package:jog_inventory/modules/ink_paper/widgets/add_row_ink.dart';
import '../../../common/exports/main_export.dart';

class AddPaperRowScreen extends StatefulWidget {
  const AddPaperRowScreen({super.key});

  @override
  State<AddPaperRowScreen> createState() => _AddPaperRowScreenState();
}

class _AddPaperRowScreenState extends State<AddPaperRowScreen> {
  var controller = AddPaperRowController.getController();

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: "Add Paper Row",
      body: body,
      bottomNavBar: bottomNavBar(),
    );
  }

  Widget body(BuildContext context) {
    return SingleChildScrollView(
      padding: AppPadding.pagePadding,
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            ...displayList<DigitalPaperRowData>(
                items: controller.items, builder: addedItemTileWidget),
          ],
        ),
      ),
    );
  }


  /// item
  Widget addedItemTileWidget(DigitalPaperRowData item, int index) {
    return Container(
      margin: AppPadding.pagePadding,
      decoration: containerDecoration(),
      child: Column(
        children: [
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
                            item.rollNo = (data);
                          },
                        ),
                      ),
                      gap(space: 10),
                      Expanded(
                          child: TextFieldWithLabel(
                            labelText: "In Stock",
                            inputFormatters: inputFormatters(allowInt: true,allowDouble: true),
                            validation: validation.validateEmptyField,
                            initialValue: "${item.inStock}",
                            onChanged: (data) {
                              item.inStock = (data);
                            },
                          )),
                      gap(space: 10),
                      Expanded(
                          child: TextFieldWithLabel(
                            labelText: "Paper size",
                            inputFormatters: inputFormatters(allowInt: true,allowDouble: true),
                            validation: validation.validateEmptyField,
                            initialValue: "${item.paperSize}",
                            onChanged: (data) {
                              item.paperSize = (data);
                            },
                          ))
                    ],
                  ),
                  gap(space: 10),
                  /// price
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFieldWithLabel(
                          labelText: "Price lb",
                          validation: validation.validateEmptyField,
                          inputFormatters: inputFormatters(allowInt: true),
                          initialValue: "${item.priceLb ?? 0}",
                          onChanged: (data) {
                            item.priceLb = (data);
                          },
                        ),
                      ),
                      gap(space: 10),
                      Expanded(
                          child: TextFieldWithLabel(
                            labelText: "Price Yads",
                            inputFormatters: inputFormatters(allowInt: true,allowDouble: true),
                            validation: validation.validateEmptyField,
                            initialValue: "${item.priceYads}",
                            onChanged: (data) {
                              item.priceYads = (data);
                            },
                          )),
                      gap(space: 10),
                      Expanded(
                          child: TextFieldWithLabel(
                            labelText: "Used Yads",
                            inputFormatters: inputFormatters(allowInt: true,allowDouble: true),
                            validation: validation.validateEmptyField,
                            initialValue: "${item.usedYads}",
                            onChanged: (data) {
                              item.usedYads = (data);
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
                          labelText: "Paper bal",
                          validation: validation.validateEmptyField,
                          inputFormatters: inputFormatters(allowInt: true,allowDouble: true),
                          initialValue: "${item.paperBalance ?? ""}",
                          onChanged: (data) {
                            item.paperBalance = (data);
                          },
                        ),
                      ),
                      gap(space: 10),
                      Expanded(
                          child: TextFieldWithLabel(
                            labelText: "Used value",
                            inputFormatters: inputFormatters(allowInt: true,allowDouble: true),
                            validation: validation.validateEmptyField,
                            initialValue: "${item.usedValue}",
                            onChanged: (data) {
                              item.usedValue = (data);
                            },
                          )),
                      gap(space: 10),
                      Expanded(
                          child: DateTimePickerField(
                            validation: validation.validateEmptyField,
                            initialDateTime: DateTime.tryParse("${item.usedDate}"),
                            onChanged: (data) {
                              item.usedDate = (data);
                            },
                            labelText: "Used date",
                            hintText: "Used date",
                          ),

                      )
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
    return Obx(()=> Container(
        color: Colours.white,
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  openAddPaperSheet(onChange: (items) {
                    controller.items.value = items;

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
            if(controller.items.length > 0)
              ...[
              gap(),
                Expanded(
                    child: PrimaryButton(
                        title: "Submit",
                        onTap: controller.submit,
                        isBusy: controller.isBusy.value))
            ]
          ],
        ),
      ),
    );
  }
}
