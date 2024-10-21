import 'package:jog_inventory/common/utils/date_time_picker.dart';
import 'package:jog_inventory/common/utils/dotted_border.dart';
import 'package:jog_inventory/common/utils/validation.dart';
import 'package:jog_inventory/modules/forecast/controllers/form.dart';
import 'package:jog_inventory/modules/forecast/models/forecast_item.dart';
import 'package:jog_inventory/modules/forecast/widgets/add_fabric.dart';
import 'package:jog_inventory/modules/material/models/search.dart';
import '../../../common/exports/main_export.dart';

class AddForecastScreen extends StatefulWidget {
  const AddForecastScreen({super.key});

  @override
  State<AddForecastScreen> createState() => _AddForecastScreenState();
}

class _AddForecastScreenState extends State<AddForecastScreen> {
  ForecastFormController get controller =>
      ForecastFormController.getController();

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => CustomAppBar(
        title: "Forecast form",
        body: body,
        // trailingButton: SizedBox(
        //     child: TextBorderButton(
        //   title: 'Reset',
        //   trailing: Icon(
        //     Icons.refresh,
        //     color: Colours.white,
        //   ),
        //   borderColor: Colours.white,
        //   color: Colours.white,
        //   onTap: () {
        //     /// Todo
        //   },
        // )),
        bottomNavBar: !controller.canEdit.value? null : bottomNavBar(),
      ),
    );
  }

  Widget body(BuildContext context) {
    return shimmerEffects(
        isLoading: controller.isLoading.value,
        child: SingleChildScrollView(
          padding: AppPadding.pagePadding,
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                forecastDetailWidget(),
                gap(),

                /// date
                selectDateWidget(),
                gap(),

                displayItems(),

                /// safe area bottom
                gap(),
                safeAreaBottom(context),
              ],
            ),
          ),
        )
    );
  }

  /// forecast code
  Widget forecastDetailWidget() {
    return Container(
        padding: AppPadding.inner,
        decoration: BoxDecoration(
            color: Colours.greyLight.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Forecast code",
                    style: appTextTheme.labelMedium
                        ?.copyWith(color: Colors.grey.shade700)),
                gap(space: 10),
                Text(
                    controller.forecastDetail?.forecastHead.firstOrNull
                            ?.forecastCode ??
                        controller.usedCode,
                    style: appTextTheme.labelMedium),
              ],
            ),
            if (controller.isUpdate.value) ...[
              gap(space: 10),
              Row(
                children: [
                  Text("Order code",
                      style: appTextTheme.labelMedium
                          ?.copyWith(color: Colors.grey.shade700)),
                  gap(space: 10),
                  Text(controller.forecastDetail?.forecastHead.firstOrNull?.forecastOrder??"_", style: appTextTheme.labelMedium),
                ],
              ),
              gap(space: 10),
              Row(
                children: [
                  Text("Date",
                      style: appTextTheme.labelMedium
                          ?.copyWith(color: Colors.grey.shade700)),
                  gap(space: 10),
                  Text(controller.forecastDetail?.forecastHead.firstOrNull?.forecastDate??"_", style: appTextTheme.labelMedium),
                ],
              ),
            ]
          ],
        ));
  }

  Widget selectDateWidget() {
    return Visibility(
      visible: !controller.isUpdate.value,
      child: Row(
        children: [
          Expanded(
            child: PrimaryFieldMenuWithLabel<OrderCodeData>(
                items: [],
                allowSearch: true,
                allowMultiSelect: false,
                validate: (val) {
                  if (val == null) {
                    validation.validateEmptyField(null);
                  } else {
                    return null;
                  }
                },
                searchApi: searchCodesMenuItems,
                fromApi: () async {
                  return searchCodesMenuItems("");
                },
                onChanged: (value) {
                  controller.orderCode = value?.firstOrNull?.value;
                },
                labelText: Strings.orderCode,
                hintText: "Select"),
          ),
          gap(space: 10),
          Expanded(
            child: DateTimePickerField(
                labelText: "Date",
                validation: validation.validateEmptyField,
                onChanged: (value) {},
                onSaved: (String? value) {
                  controller.formData.forecastDate = value;
                }),
          ),
        ],
      ),
    );

    return Container(
      padding: AppPadding.inner,
      decoration: BoxDecoration(
        color: Colours.white,
        border: Border.all(color: Colours.primaryBlueBg),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          gap(space: 10),
          Text("Date", style: appTextTheme.titleMedium),
          gap(),
          Expanded(
            child: DateTimePickerField(
                validation: validation.validateEmptyField,
                onChanged: (value) {},
                onSaved: (String? value) {}),
          ),
          gap(space: 10),
        ],
      ),
    );
  }

  Widget displayItems() {
    return Obx(() => displayListBuilder<ForeCastFormItem>(
        items: controller.items,
        builder: (item, index) => itemTileWidget(item),
        showGap: true));
  }

  Widget itemTileWidget(ForeCastFormItem item) {
    return Container(
      padding: AppPadding.inner,
      decoration: BoxDecoration(
        color: Colours.white,
        border: Border.all(color: Colours.primaryBlueBg),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.material.catNameEn ?? "",
                  style: appTextTheme.titleSmall
                      ?.copyWith(color: Colours.primaryText)),
              Visibility(
                visible: controller.canEdit.value,
                child: IconButton(
                    onPressed: () {
                      controller.items.remove(item);
                    },
                    icon:
                        Icon(Icons.delete_outlined, size: 25, color: Colours.red)),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              displayTitleSubtitle("Color", item.color.fabricColor ?? "_"),
              displayTitleSubtitle("Type", "Fabrics"),
              displayTitleSubtitle("Bal", "${ formatDecimal(item.balance??"_")} kg"),
            ],
          ),
          gap(space: 10),
          Row(
            children: [
              Text("Forecast",
                  style: appTextTheme.titleSmall
                      ?.copyWith(color: Colours.greyLight)),
              gap(),
              Expanded(
                  child: PrimaryTextField(
                      radius: 10,
                      hintText: "in kgs",
                      initialValue: item.forecast,
                      enabled: controller.canEdit.value,
                      validator: validation.validateEmptyField,
                      onSaved: (val) {
                        item.forecast = val;
                      }))
            ],
          ),
          gap(space: 10),
        ],
      ),
    );
  }

  Widget displayTitleSubtitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: appTextTheme.titleSmall?.copyWith(color: Colours.greyLight)),
        gap(space: 10),
        Text(
          subtitle,
          style: appTextTheme.titleSmall?.copyWith(),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget addForecastButton() {
    return DottedBorderContainer(
        gap: 2,
        borderWidth: 1,
        borderColor: Colours.green,
        borderRadius: BorderRadius.circular(200),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButtonWidget(
                onTap: () {
                  openForeCastAddFabricPopup(controller.addItems);
                },
                color: Colours.green,
                title: "Add forecast",
                trailing: Icon(
                  Icons.add,
                  color: Colours.green,
                )),
          ],
        ));
  }

  Widget bottomNavBar() {
    return Obx(
      () => Container(
        color: Colours.white,
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  openForeCastAddFabricPopup(controller.addItems);
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
                        child: Text("Add Forecast",
                            style: appTextTheme.titleSmall
                                ?.copyWith(color: Colours.green)))),
              ),
            ),
            gap(),
            Expanded(
              child: PrimaryButton(
                  isEnable: controller.items.length > 0,
                  title: controller.isUpdate.value? "Update" : "Submit",
                  isBusy: controller.isBusy.value,
                  onTap: controller.submitForm,
                  radius: 10,
                  color: Colours.greenLight),
            )
          ],
        ),
      ),
    );
  }
}
