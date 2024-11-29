import 'package:jog_inventory/common/constant/enums.dart';
import 'package:jog_inventory/common/exports/main_export.dart';
import 'package:jog_inventory/services/tab_view_navigator.dart';

class _Permission {
  /// check the permission for the user
  bool hasPermission(PageType type) {
    switch (type) {
      case PageType.materialRq:
        {
          return _hasMaterialRqPerm();
        }
      case PageType.forCast:
        {
          return _hasForCastPerm();
        }
      case PageType.noCodeRq:
        {
          return _hasNoCodeRqPerm();
        }
      case PageType.stockIn:
        {
          return _hasStockInPerm();
        }
    }
    return false;
  }

  bool _hasMaterialRqPerm() {
    // TODO
    return false;
  }

  bool _hasForCastPerm() {
    // TODO
    return false;
  }

  bool _hasNoCodeRqPerm() {
    // TODO
    return false;
  }

  bool _hasStockInPerm() {
    // TODO
    return false;
  }

  Future<void> showPermissionPopup(
      String message, Function() onComplete) async {
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: Text('Permission Required',style: appTextTheme.titleSmall?.copyWith(color: Colours.black)),
        content: Text(message,style: appTextTheme.labelMedium?.copyWith(color: Colours.greyLight,fontWeight: FontWeight.w500)),
        actions: [
          TextButton(
            onPressed: () async {
              // Optionally open settings if needed
                onComplete();
                mainNavigationService.pop();
            },
            child: Text('Open Settings',style: appTextTheme.titleSmall?.copyWith(color: Colours.blueDark),),
          ),
        ],
      ),
    );
  }
}

var permission = _Permission();
