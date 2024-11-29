import 'package:jog_inventory/services/tab_view_navigator.dart';

import '../exports/main_export.dart';

void showAppBottomSheet(
  BuildContext context,
  Widget body, {
  String? title,
  Color? bgColor,
}) async {
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
