import 'package:get/get.dart';
import 'package:jog_inventory/modules/material/models/search.dart';
import '../../../common/exports/main_export.dart';

void showSelectCodeMenu<SearchData>(BuildContext context) {
  Rx<TextEditingController> controller = TextEditingController().obs;
  RxBool isLoading = false.obs;
  RxInt selectedIndex = (-1).obs;
  String? error;
  List<DropDownItem<SearchData>> items = [];

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Obx(() {
        return Container(
          color: Colours.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              gap(space: 10),
              Container(
                height: 5,
                width: 100,
                decoration: BoxDecoration(
                  color: Colours.border.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              gap(space: 10),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.close,
                    size: 25,
                    color: Colours.border,
                  ),
                ),
              ),
              Visibility(
                visible: isLoading.value != "",
                child: Stack(
                  children: [
                    StatefulBuilder(builder: (context, setState) {
                      /// get item func
                      getItems(String query) async {
                        if (query.isEmpty) return;
                        selectedIndex.value = -1;
                        isLoading.value = true;
                        try {
                          var data = await SearchOrderModal.searchData(query);
                          if ((data.data?.length ?? 0) > 0) items.clear();
                          data.data?.forEach((item) {
                            SearchData? itemData = item as SearchData?;
                            items.add(DropDownItem<SearchData>(
                                id: item.orderLkrTitleId ?? 0,
                                title: item.orderTitle ?? "_",
                                key: "${item.orderLkrTitleId}",
                                value: itemData));
                          });
                        } catch (e, trace) {
                          error = "";
                        }
                        isLoading.value = false;
                      }

                      if (items.length == 0) getItems("");
                      // if (isLoading.value) {
                      //   return ClipRRect(
                      //     borderRadius: BorderRadius.circular(20),
                      //     child: Container(
                      //         padding: AppPadding.pagePadding,
                      //         height: 250,
                      //         color: Colours.white,
                      //         width: Get.width,
                      //         child: listLoadingEffect(
                      //           count: 3,
                      //         )),
                      //   );
                      // } else
                      {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colours.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              )),
                          constraints: BoxConstraints(
                            maxHeight: Get.height - 200,
                            minHeight: Get.height - 200,
                            minWidth: Get.width,
                          ),
                          padding: EdgeInsets.only(
                              top: 10, bottom: 15, left: 15, right: 15),
                          child: Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      PrimaryTextField(
                                          allowShadow: false,
                                          radius: 10,
                                          controller: controller.value,
                                          onChanged: (value) {
                                            getItems(value);
                                          },
                                          hintText: "Search",
                                          prefixIcon: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Icon(
                                                Icons.search,
                                                color: Colours.greyLight,
                                                size: 25,
                                              ))),

                                      gap(space: 20),

                                      /// no items
                                      Visibility(
                                        visible:
                                            items.length == 0 && error == null,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 15),
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.clean_hands_rounded,
                                                size: 50,
                                                color: Colours.border,
                                              ),
                                              gap(space: 10),
                                              Text(
                                                "No Items",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colours.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                          visible: error != null,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.error,
                                                color: Colours.red,
                                                size: 30,
                                              ),
                                              gap(space: 10),
                                              Text(
                                                  "Error Loading Data.\nTry again!",
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      appTextTheme.titleMedium),
                                              gap(space: 10),
                                              IconButton(
                                                  onPressed: () {
                                                    getItems(
                                                        controller.value.text);
                                                  },
                                                  icon: Icon(Icons.refresh,
                                                      size: 30,
                                                      color: Colours.blue))
                                            ],
                                          )),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: displayList<
                                                DropDownItem<SearchData>>(
                                            items: items,
                                            builder: (item, index) {
                                              return Obx(
                                                () => InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  onTap: () {
                                                    selectedIndex.value = index;
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        left: 5, right: 5),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: index ==
                                                                selectedIndex
                                                                    .value
                                                            ? Colours.blue
                                                                .withOpacity(
                                                                    0.2)
                                                            : null),
                                                    height: 40,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            item.title,
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.7)),
                                                          ),
                                                        ),
                                                        Visibility(
                                                            visible:
                                                                selectedIndex
                                                                        .value ==
                                                                    index,
                                                            child: Radio<bool>(
                                                                value: true,
                                                                groupValue:
                                                                    true,
                                                                onChanged:
                                                                    (value) {}))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),

                                      safeAreaBottom(context)
                                    ],
                                  ),
                                ),
                              ),
                              Obx(
                                () => Visibility(
                                  // visible: selectedIndex.value != -1,
                                  child: PrimaryButton(
                                      isEnable: selectedIndex.value != -1,
                                      title: "Process",
                                      onTap: () {
                                        Get.back();
                                        Get.toNamed(
                                            AppRoutesString.submit_order,
                                            arguments: {});
                                      }),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    }),
                  ],
                ),
              ),
            ],
          ),
        );
      });
    },
  );
}
