import '../../../common/exports/main_export.dart';

class FilterMaterialList extends StatefulWidget {
  const FilterMaterialList({super.key});

  @override
  State<FilterMaterialList> createState() => _FilterMaterialListState();
}

class _FilterMaterialListState extends State<FilterMaterialList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Strings.searchMaterials,
                style: appTextTheme.titleMedium,
              ),
            ],
          ),
        ),
        selectFilter(),
        gap(),
        titleWidget(),
        gap(),
        /// items tiles
        Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              itemTile(),
              gap(space: 10),
              divider(),
              gap(space: 10),
              itemTile(),
              gap(space: 10),
              divider(),
              gap(space: 10),


            ],
          ),
        ),

        ///
        gap(),
        SafeAreaBottom(context),
      ],
    ));
  }

  Widget selectFilter() {
    return Container(
      padding: AppPadding.inner,
      margin: AppPadding.pagePadding,
      child: Column(
        children: [
          SecondaryFieldMenuWithLabel(
              hintText: "Search for the fabric",
              items: [],
              onChanged: (value) {},
              labelText: Strings.fabric),
          gap(space: 15),
          Row(
            children: [
              Expanded(
                child: SecondaryFieldMenuWithLabel(
                    hintText: Strings.color,
                    items: [],
                    onChanged: (value) {},
                    labelText: Strings.color),
              ),
              gap(space: 15),
              Expanded(
                child: SecondaryFieldMenuWithLabel(
                    hintText: Strings.box,
                    items: [],
                    onChanged: (value) {},
                    labelText: Strings.box),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget titleWidget(){
    return   Container(
      color: Colours.secondary,
      padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              "No.",
              style: appTextTheme.labelMedium
                  ?.copyWith(color: Colours.white),
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              Strings.orderCode,
              style: appTextTheme.labelMedium
                  ?.copyWith(color: Colours.white),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              Strings.material,
              style: appTextTheme.labelMedium
                  ?.copyWith(color: Colours.white),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              Strings.color,
              style: appTextTheme.labelMedium
                  ?.copyWith(color: Colours.white),
              textAlign: TextAlign.center,
            ),
          ),

          Expanded(
            flex: 1,
            child: Text(
              Strings.box,
              style: appTextTheme.labelMedium
                  ?.copyWith(color: Colours.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget itemTile(){
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            "1",
            style: appTextTheme.labelMedium
                ?.copyWith(),
            textAlign: TextAlign.start,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            "EX-1254A",
            style: appTextTheme.labelMedium
                ?.copyWith(color: Colours.primaryText),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            "AK PRO MAX LIGHT",
            style: appTextTheme.labelMedium
                ?.copyWith(color: Colours.blackLite),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            "49ERS",
            style: appTextTheme.labelMedium
                ?.copyWith(color: Colours.blackLite),
            textAlign: TextAlign.center,
          ),
        ),

        Expanded(
          flex: 1,
          child: Text(
            Strings.box,
            style: appTextTheme.labelMedium
                ?.copyWith(color: Colours.blackLite),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
