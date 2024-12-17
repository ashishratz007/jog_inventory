import 'package:jog_inventory/common/utils/bottom_sheet.dart';
import '../../../common/exports/main_export.dart';

openAddRowInkSheet() {
  showAppBottomSheet(Get.context!, _UpdatePaperScreen(), title: "Add rows");
}

class _UpdatePaperScreen extends StatefulWidget {
  const _UpdatePaperScreen({super.key});

  @override
  State<_UpdatePaperScreen> createState() => _UpdatePaperScreenState();
}

class _UpdatePaperScreenState extends State<_UpdatePaperScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.pagePadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                  child: PrimaryFieldMenuWithLabel<String>(
                      items: [],
                      allowSearch: true,
                      onChanged: (item) {},
                      hintText: "Receipt Date",
                      labelText: "Receipt Date")),
              gap(space: 10),
              Expanded(
                  child: PrimaryFieldMenuWithLabel<String>(
                items: [],
                allowSearch: true,
                onChanged: (item) {},
                labelText: "Supplier",
                hintText: "Supplier",
              )),
            ],
          ),
          gap(space: 10),
          Row(
            children: [
              Expanded(
                  child: PrimaryFieldMenuWithLabel<String>(
                      items: [],
                      allowSearch: true,
                      onChanged: (item) {},
                      hintText: "PO",
                      labelText: "PO")),
              gap(space: 10),
              Expanded(
                  child: PrimaryFieldMenuWithLabel<String>(
                items: [],
                allowSearch: true,
                onChanged: (item) {},
                labelText: "IM",
                hintText: "IM",
              )),
            ],
          ),
          gap(space: 10),
          Row(
            children: [
              Expanded(
                  child: PrimaryFieldMenuWithLabel<String>(
                      items: [],
                      allowSearch: true,
                      onChanged: (item) {},
                      hintText: "Rolls Start No.",
                      labelText: "Rolls Start No.")),
              gap(space: 10),
              Expanded(
                  child: PrimaryFieldMenuWithLabel<String>(
                items: [],
                allowSearch: true,
                onChanged: (item) {},
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
                      items: [],
                      allowSearch: true,
                      onChanged: (item) {},
                      hintText: "Paper Size",
                      labelText: "Paper Size")),
              gap(space: 10),
              Expanded(
                  child: PrimaryFieldMenuWithLabel<String>(
                items: [],
                allowSearch: true,
                onChanged: (item) {},
                labelText: "Price ",
                hintText: "Price ",
              )),
            ],
          ),
          gap(space: 10),
          Row(
            children: [
              Expanded(
                  child: PrimaryFieldMenuWithLabel<String>(
                      items: [],
                      allowSearch: true,
                      onChanged: (item) {},
                      hintText: "Price yds",
                      labelText: "Price yds")),
              gap(space: 10),
              Expanded(
                  child: PrimaryFieldMenuWithLabel<String>(
                items: [],
                allowSearch: true,
                onChanged: (item) {},
                labelText: "Used yds",
                hintText: "Used yds",
              )),
            ],
          ),
          gap(space: 10),
          Row(
            children: [
              Expanded(
                  child: PrimaryFieldMenuWithLabel<String>(
                      items: [],
                      allowSearch: true,
                      onChanged: (item) {},
                      hintText: "Paper Bal.",
                      labelText: "Paper Bal.")),
              gap(space: 10),
              Expanded(
                  child: PrimaryFieldMenuWithLabel<String>(
                items: [],
                allowSearch: true,
                onChanged: (item) {},
                labelText: "Used yds",
                hintText: "Used yds",
              )),
            ],
          ),
          gap(space: 10),
          Row(
            children: [
              Expanded(
                  child: PrimaryFieldMenuWithLabel<String>(
                      items: [],
                      allowSearch: true,
                      onChanged: (item) {},
                      hintText: "Used value",
                      labelText: "Used value")),
              gap(space: 10),
              Expanded(
                  child: PrimaryFieldMenuWithLabel<String>(
                items: [],
                allowSearch: true,
                onChanged: (item) {},
                labelText: "No. of Rows",
                hintText: "No. of Rows",
              )),
            ],
          ),
          gap(space: 30),
          PrimaryButton(
              title: "Update Rows",
              onTap: () {},
              radius: 10,
              color: Colours.greenLight),

          /// bottom
          SafeAreaBottom(context)
        ],
      ),
    );
  }
}
