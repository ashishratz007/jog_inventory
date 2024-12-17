import 'package:jog_inventory/common/utils/bottom_sheet.dart';
import 'package:jog_inventory/common/utils/error_message.dart';
import 'package:jog_inventory/modules/material/models/material_request.dart';
import 'package:jog_inventory/modules/no_code/models/no_code_item.dart';
import '../../../common/exports/main_export.dart';

openUpdateStockDataBottomSheet() {
  showAppBottomSheet(Get.context!, _ViewUpdateStockDataScreen(),title: "Update Used Stock");
}

class _ViewUpdateStockDataScreen extends StatefulWidget {
  const _ViewUpdateStockDataScreen();

  @override
  State<_ViewUpdateStockDataScreen> createState() =>
      _ViewUpdateStockDataScreenState();
}

class _ViewUpdateStockDataScreenState
    extends State<_ViewUpdateStockDataScreen> {
  RxBool isLoading = false.obs;

  Map<String, NoCodeDataSummaryModel> usedDataMap = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// title
            Container(
              color: Colours.secondary,
              padding: EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'December',
                    style: appTextTheme.labelMedium
                        ?.copyWith(color: Colours.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            gap(),
            Obx(
              () => Visibility(
                visible: isLoading.value,
                child: listLoadingEffect(count: 6),
              ),
            ),

            /// data list
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: [
                  gridView()
                ],
              ),
            ),

            ///
            gap(),
            SafeAreaBottom(context),
            SafeAreaBottom(context),
            SafeAreaBottom(context),
          ],
        ),
      ),
    );
  }

  Widget gridView() {
    return  GridView.builder(
      padding: EdgeInsets.only(left: 5, right: 5, bottom: 0, top: 20),
      shrinkWrap: true, // To make the GridView fit its content
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: 90,
        crossAxisCount: 3,
        mainAxisSpacing: 5.0, // Spacing between rows
        crossAxisSpacing: 5.0, // Spacing between columns
        childAspectRatio: 0.5, // Adjust aspect ratio as needed
      ),
      itemCount: 31,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: !((index % 2) == 0)? Colours.white : Colours.bgGrey.withOpacity(0.6),
                borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                Text("${index+1}",style: appTextTheme.labelMedium),
                gap(space: 10),
                SizedBox(
                    height: 40,
                    child: PrimaryTextField(
                      padding: EdgeInsets.only(left: 10,right: 10)
                    ))
              ],
            ));
      },
    );
  }
}
