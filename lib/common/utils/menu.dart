import '../exports/main_export.dart';

// class MenuItem {
//   String title;
//   Widget? icon;
//   Function() onTap;
//   MenuItem({required this.title, required this.onTap});
// }

Widget popupMenu(BuildContext context,
    {Widget? menuIcon, required List<MenuItem> items}) {
  return PopupMenuButton<MenuItem>(
    // Set the background color of the menu
    color: Colors.white,
    icon: menuIcon,
    itemBuilder: (context) => [
      ...items
          .map((e) => PopupMenuItem(
                onTap: (){
                  e.onTap!(e.value);
                },
                value: e,
                child: Row(
                  children: [
                    if (e.icon != null) e.icon!,
                    gap(space: 10),
                    Text(e.title)
                  ],
                ),
              ))
          .toList(),
    ],
  );
}
