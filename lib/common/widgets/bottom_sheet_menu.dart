import 'package:jog_inventory/services/tab_view_navigator.dart';

import '../exports/main_export.dart';

Future<MenuItem?> showActionMenu(
  BuildContext context, {
  required List<MenuItem> items,
  required String title,
  MenuItem? selectedItem,
      Key? key
}) async {
  return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return _MenuSheetWidget(
          key: key,
          title: title,
          items: items,
          selectedItems: [if(selectedItem != null) selectedItem],
        );
      });
}

class _MenuSheetWidget extends StatefulWidget {
  final String title;
  final List<MenuItem> items;
  final List<MenuItem>? selectedItems;
  const _MenuSheetWidget({required this.title, required this.items, this.selectedItems, super.key});

  @override
  State<_MenuSheetWidget> createState() => _MenuSheetWidgetState();
}

class _MenuSheetWidgetState extends State<_MenuSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.pagePaddingAll,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.title,style: appTextTheme.titleMedium),
          gap(),
          displayListBuilder<MenuItem>(items: widget.items, builder: (item,index){
            return  menuItemTile(item, index);
          },showGap: true),

        ],
      ),
    );
  }

 Widget menuItemTile(MenuItem item, int index){
    return InkWell(
      onTap: (){
       mainNavigationService.pop(result: item);
        if(item.onTap != null){
          item.onTap!(item.value);
        }
      },
      child: Container(
        padding: EdgeInsets.only(top: 5,bottom: 5),
        child: Row(
          children: [
            item.icon??SizedBox(),
            gap(),
            Text(item.title,style: appTextTheme.labelMedium?.copyWith(fontWeight: FontWeight.w500,color: Colors.black87.withOpacity(0.8) )),
          ],
        ),
      ),
    );
  }
}
