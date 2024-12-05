import 'package:jog_inventory/services/tab_view_navigator.dart';

import '../exports/main_export.dart';

void showAppBottomSheet(
  BuildContext context,
  Widget body, {
  String? title,
  Color? bgColor,
}) async {
  if (config.isTablet) {
    showDialog(
        context: context,
        builder: (context) => Material(
            type: MaterialType.transparency,
            child: Container(
                margin: EdgeInsets.only(
                    left: 100, right: 100, bottom: 150, top: 150),
                decoration: BoxDecoration(
                    color: Colours.white,
                    borderRadius: BorderRadius.circular(10)),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            size: 30,
                          )),
                      gap(),
                      body,
                    ],
                  ),
                ))));
  } else
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
              color: bgColor ?? Colours.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              )),
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
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          mainNavigationService.pop();
                        },
                        child: Icon(
                          Icons.close,
                          size: 25,
                          color: Colours.blackLite,
                        ),
                      ),
                      if (title != null) ...[
                        Expanded(
                            child: Text(title,
                                style: appTextTheme.titleSmall,
                                textAlign: TextAlign.center)),
                        gap(space: 25)
                      ]
                    ],
                  ),
                ),
              ),
              gap(),
              Flexible(child: body)
            ],
          ),
        );
      },
    );
}
