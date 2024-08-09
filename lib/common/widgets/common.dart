import '../exports/main_export.dart';

Widget textWithDivider(String text) {
  return Row(
    children: [
      Expanded(child: Divider()),
      gap(space: 10),
      Text(
        text,
        style: TextStyle(color: Colors.black38, fontSize: 16),
      ),
      gap(space: 10),
      Expanded(child: Divider()),
    ],
  );
}

Widget checkBoxTile(String title, bool isSelected) {
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              color: isSelected ? Colours.bgGrey : Colors.transparent),
        ),
        height: 25,
        width: 25,
        child: isSelected
            ? Icon(
                Icons.check,
                color: Colours.primary,
              )
            : null,
      ),
      gap(),
      Flexible(
          child: Text(
        title,
        style: appTextTheme.bodyMedium,
      )),
    ],
  );
}
