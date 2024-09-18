import 'package:jog_inventory/common/constant/enums.dart';

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
}

var permission = _Permission();
