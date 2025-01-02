import 'package:jog_inventory/common/utils/bottom_sheet.dart';
import 'package:jog_inventory/common/utils/date_time_picker.dart';
import 'package:jog_inventory/common/utils/validation.dart';
import 'package:jog_inventory/modules/ink_paper/modles/add_row.dart';
import '../../../common/exports/main_export.dart';




openAddRowInkSheet({required Function(List<InkRowDataItem>) onChange}) {
  showAppBottomSheet(
      Get.context!,
      _AddInkScreen(
        onChange: onChange,
      ),
      title: "Add rows");
}

openAddPaperSheet({required Function(List<DigitalPaperRowData>) onChange}) {
  showAppBottomSheet(Get.context!, _AddPaperScreen(onChange: onChange,),
      title: "Add Paper Row");
}

List<String> inkColors = [
  "Yellow",
  "Orange",
  "Neon Yellow",
  "Neon Red",
  "Cyan",
  "Magenta",
  "Green",
  "Cyan",
  "BLACK"
];

class _AddInkScreen extends StatefulWidget {
  final Function(List<InkRowDataItem>) onChange;
  const _AddInkScreen({required this.onChange, super.key});

  @override
  State<_AddInkScreen> createState() => _AddInkScreenState();
}

class _AddInkScreenState extends State<_AddInkScreen> {
  var formKey = GlobalKey<FormState>();
  InkRowDataItem rowItem = InkRowDataItem();
  int noOfRows = 0;
  int startNo = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Material(
        child: Form(
          key: formKey,
          child: Container(
            padding: AppPadding.pagePadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: DateTimePickerField(
                            validation: validation.validateEmptyField,
                            onChanged: (String? date) {
                              rowItem.receiptDate = date;
                            },
                            hintText: "",
                            labelText: "Receipt Date")),
                    gap(space: 10),
                    Expanded(
                        child: TextFieldWithLabel(
                      validation: validation.validateEmptyField,
                      onChanged: (String? val) {
                        rowItem.supplier = val;
                      },
                      labelText: "Supplier",
                      hintText: "Supplier",
                    )),
                  ],
                ),
                gap(space: 10),
                Row(
                  children: [
                    Expanded(
                        child: TextFieldWithLabel(
                            validation: validation.validateEmptyField,
                            onChanged: (String? val) {
                              rowItem.po = val;
                            },
                            hintText: "PO",
                            labelText: "PO")),
                    gap(space: 10),
                    Expanded(
                        child: TextFieldWithLabel(
                      validation: validation.validateEmptyField,
                      onChanged: (String? val) {
                        rowItem.imSupplier = val;
                      },
                      labelText: "IM",
                      hintText: "IM",
                    )),
                  ],
                ),
                gap(space: 10),
                Row(
                  children: [
                    Expanded(
                        child: TextFieldWithLabel(
                            validation: validation.validateEmptyField,
                            inputFormatters: inputFormatters(allowInt: true,allowDouble: false),
                            onChanged: (String? val) {
                              rowItem.rollNo = int.tryParse(val ?? "");
                            },
                            hintText: "Rolls Start No.",
                            labelText: "Rolls Start No.")),
                    gap(space: 10),
                    Expanded(
                        child: PrimaryFieldMenuWithLabel<String>(
                      items: [
                        DropDownItem<String>(
                          id: 1,
                          title: "1000",
                          key: "1000",
                          value: "1000",
                        ),
                      ],
                      allowSearch: true,
                      validation: validation.validateEmptyField,
                      onChanged: (item) {
                        rowItem.inStockMl =
                            int.tryParse(item?.firstOrNull?.value ?? "");
                      },
                      labelText: "In Stock",
                      hintText: "In Stock",
                    )),
                  ],
                ),
                gap(space: 10),
                Row(
                  children: [
                    Expanded(
                        child: PrimaryFieldMenuWithLabel<String>(
                            validation: validation.validateEmptyField,
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
                            onChanged: (item) {
                              rowItem.inkColor = item?.firstOrNull?.value;
                            },
                            hintText: "Color",
                            labelText: "Color")),
                    gap(space: 10),
                    Expanded(
                        child: TextFieldWithLabel(
                      validation: validation.validateEmptyField,
                      inputFormatters: inputFormatters(allowInt: true,allowDouble: true),
                      onChanged: (String? val) {
                        rowItem.priceLb = int.tryParse(val ?? "");
                      },
                      labelText: "Price",
                      hintText: "Price ",
                    )),
                  ],
                ),
                gap(space: 10),
                Row(
                  children: [
                    Expanded(
                        child: TextFieldWithLabel(
                      validation: validation.validateEmptyField,
                          inputFormatters: inputFormatters(allowInt: true,allowDouble: true),
                      onChanged: (String? val) {
                        rowItem.inkBalanceMl = (val ?? "");
                      },
                      hintText: "Ink Bal",
                      labelText: "Ink Bal",
                    )),
                    gap(space: 10),
                    Expanded(
                        child: TextFieldWithLabel(
                      validation: validation.validateEmptyField,
                          inputFormatters: inputFormatters(allowInt: true,allowDouble: true),
                      onChanged: (String? val) {
                        rowItem.used = val;
                      },
                      labelText: "Used",
                      hintText: "Used",
                    )),
                  ],
                ),
                gap(space: 10),
                Row(
                  children: [
                    Expanded(
                        child: TextFieldWithLabel(
                            validation: validation.validateEmptyField,
                            inputFormatters: inputFormatters(allowInt: true,allowDouble: true),
                            onChanged: (item) {
                              rowItem.inkBalanceMl = item;
                            },
                            hintText: "Ink Bal.",
                            labelText: "Ink Bal.")),
                    gap(space: 10),
                    Expanded(
                        child: TextFieldWithLabel(
                      validation: validation.validateEmptyField,
                          inputFormatters: inputFormatters(allowInt: false,allowDouble: true),
                      onChanged: (item) {
                        rowItem.usedMl = item;
                      },
                      labelText: "Used Ml",
                      hintText: "Used Ml",
                    )),
                  ],
                ),
                gap(space: 10),
                Row(
                  children: [
                    Expanded(
                        child: DateTimePickerField(
                            validation: validation.validateEmptyField,
                            onChanged: (String? date) {
                              rowItem.usedDate = date;
                            },
                            hintText: "",
                            labelText: "Used Date")),
                    gap(space: 10),
                    Expanded(
                      child: PrimaryFieldMenuWithLabel<int>(
                        items: List.generate(
                            50,
                            (index) => DropDownItem<int>(
                                  id: index,
                                  title: "${index +1}",
                                  key: "${index+1}",
                                  value: index +1,
                                )),
                        allowSearch: true,
                        validation: validation.validateEmptyField,
                        onChanged: (item) {
                          noOfRows = item?.firstOrNull?.value ?? 0;
                        },
                        labelText: "No. of Rows",
                        hintText: "No. of Rows",
                      ),
                    ),
                  ],
                ),
                gap(space: 30),
                PrimaryButton(
                    title: "Update Rows",
                    onTap: () {
                      if (formKey.currentState?.validate() ?? false) {
                        var items = <InkRowDataItem>[];
                        print(noOfRows);
                        for (var i = 0; i < noOfRows; i++) {
                          var item = rowItem;
                          item.rollNo = (rowItem.rollNo ?? 0) + i;
                          items.add(item);
                        }
                        widget.onChange.call(items);
                        mainNavigationService.back(context);
                      }
                    },
                    radius: 10,
                    color: Colours.greenLight),
                gap(),

                /// bottom
                SafeAreaBottom(context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AddPaperScreen extends StatefulWidget {
  final Function(List<DigitalPaperRowData>) onChange;
  const _AddPaperScreen({required this.onChange, super.key});

  @override
  State<_AddPaperScreen> createState() => _AddPaperScreenState();
}

class _AddPaperScreenState extends State<_AddPaperScreen> {
  var formKey = GlobalKey<FormState>();
  DigitalPaperRowData rowItem = DigitalPaperRowData();
  int noOfRows = 0;
  int startNo = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Form(
        key: formKey,
        child: Container(
          padding: AppPadding.pagePadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                      child:DateTimePickerField(
                          validation: validation.validateEmptyField,
                          onChanged: (String? date) {
                            rowItem.receiptDate = date;
                          },
                          hintText: "Receipt Date",
                          labelText: "Receipt Date")),
                  gap(space: 10),
                  Expanded(
                      child: TextFieldWithLabel(
                        validation: validation.validateEmptyField,
                        onChanged: (String? val) {
                          rowItem.supplier = val;
                        },
                    labelText: "Supplier",
                    hintText: "Supplier",
                  )),
                ],
              ),
              gap(space: 10),
              Row(
                children: [
                  Expanded(
                      child: TextFieldWithLabel(
                          validation: validation.validateEmptyField,
                          onChanged: (String? val) {
                            rowItem.po = val;
                          },
                          hintText: "PO",
                          labelText: "PO")),
                  gap(space: 10),
                  Expanded(
                      child:TextFieldWithLabel(
                        validation: validation.validateEmptyField,
                        onChanged: (String? val) {
                          rowItem.imSupplier = val;
                        },
                    labelText: "IM",
                    hintText: "IM",
                  )),
                ],
              ),
              gap(space: 10),
              Row(
                children: [
                  Expanded(
                      child: TextFieldWithLabel(
                          validation: validation.validateEmptyField,
                          onChanged: (String? val) {
                            rowItem.rollNo = val;
                          },
                          hintText: "Rolls Start No.",
                          inputFormatters: inputFormatters(allowInt: true,allowDouble: false),
                          labelText: "Rolls Start No.")),
                  gap(space: 10),
                  Expanded(
                      child: TextFieldWithLabel(
                        validation: validation.validateEmptyField,
                        onChanged: (String? val) {
                          rowItem.inStock = val;
                        },
                    labelText: "In Stock",
                    hintText: "In Stock",
                        inputFormatters: inputFormatters(allowInt: true,allowDouble: true),
                  )),
                ],
              ),
              gap(space: 10),
              Row(
                children: [
                  Expanded(
                      child: TextFieldWithLabel(
                          validation: validation.validateEmptyField,
                          onChanged: (String? val) {
                            rowItem.paperSize = val;
                          },
                          hintText: "Paper Size",
                          labelText: "Paper Size")),
                  gap(space: 10),
                  Expanded(
                      child:TextFieldWithLabel(
                        validation: validation.validateEmptyField,
                        onChanged: (String? val) {
                          rowItem.priceLb = val;
                        },
                    labelText: "Price Lb",
                    hintText: "Price ",
                        inputFormatters: inputFormatters(allowInt: true,allowDouble: true),
                  )),
                ],
              ),
              gap(space: 10),
              Row(
                children: [
                  Expanded(
                      child: TextFieldWithLabel(
                          validation: validation.validateEmptyField,
                          onChanged: (String? val) {
                            rowItem.priceYads = val;
                          },
                          hintText: "Price yds",
                          inputFormatters: inputFormatters(allowInt: true,allowDouble: true),
                          labelText: "Price yds")),
                  gap(space: 10),
                  Expanded(
                      child: TextFieldWithLabel(
                        validation: validation.validateEmptyField,
                        onChanged: (String? val) {
                          rowItem.usedYads = val;
                        },
                    labelText: "Used yds",
                    hintText: "Used yds",
                        inputFormatters: inputFormatters(allowInt: true,allowDouble: true),
                  )),
                ],
              ),
              gap(space: 10),
              Row(
                children: [
                  Expanded(
                      child: TextFieldWithLabel(
                          validation: validation.validateEmptyField,
                          inputFormatters: inputFormatters(allowInt: true,allowDouble: true),
                          onChanged: (String? val) {
                            rowItem.paperBalance = val;
                          },
                          hintText: "Paper Bal.",
                          labelText: "Paper Bal.")),
                  gap(space: 10),
                  Expanded(
                      child: DateTimePickerField(
                        validation: validation.validateEmptyField,
                        onChanged: (String? date) {
                          rowItem.usedDate = date;
                        },
                    labelText: "Used date",
                    hintText: "Used date",
                  )),
                ],
              ),
              gap(space: 10),
              Row(
                children: [
                  Expanded(
                      child: TextFieldWithLabel(
                          validation: validation.validateEmptyField,
                          inputFormatters: inputFormatters(allowInt: true,allowDouble: true),
                          onChanged: (String? val) {
                            rowItem.usedValue = val;
                          },
                          hintText: "Used value",
                          labelText: "Used value")),
                  gap(space: 10),
                  Expanded(
                      child: PrimaryFieldMenuWithLabel<int>(
                        items: List.generate(
                            50,
                                (index) => DropDownItem<int>(
                              id: index,
                              title: "${index +1}",
                              key: "${index+1}",
                              value: index +1,
                            )),
                        validation: validation.validateEmptyField,
                        onChanged: (item) {
                          noOfRows = item?.firstOrNull?.value ?? 0;
                        },
                    labelText: "No. of Rows",
                    hintText: "No. of Rows",
                  )),
                ],
              ),
              gap(space: 30),
              PrimaryButton(
                  title: "Update Rows",
                  onTap: () {
                    if (formKey.currentState?.validate() ?? false) {
                      var items = <DigitalPaperRowData>[];
                      print(noOfRows);
                      for (var i = 0; i < noOfRows; i++) {
                        var item = rowItem;
                        item.rollNo = "${(int.tryParse((rowItem.rollNo ?? "0"))??0) + i}";
                        items.add(item);
                      }
                      widget.onChange.call(items);
                      mainNavigationService.back(context);
                    }
                  },
                  radius: 10,
                  color: Colours.greenLight),

              /// bottom
              SafeAreaBottom(context)
            ],
          ),
        ),
      ),
    );
  }
}
