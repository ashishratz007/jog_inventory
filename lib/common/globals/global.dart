
import 'package:jog_inventory/modules/auth/models/user_login.dart';

import '../exports/main_export.dart';

class _GlobalData {
  String? get authToken => UserLoginModel.getToken();
  // bool get alreadyLoggedIn => authToken != null;

  // String? get authToken => UserLoginModel.getToken();
  //
  // UserModel? get activeUser => UserModel.getActiveUserFromCache();

  UserInfoModel? get activeUser => UserLoginModel.getUserInfo();

  void logoutUser() {
    Get.offAllNamed(AppRoutesString.login);
  }

}

var globalData = _GlobalData();
