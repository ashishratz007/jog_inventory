
import 'package:jog_inventory/modules/auth/models/user_login.dart';

class _GlobalData {
  String? get authToken => UserLoginModel.getToken();
  // bool get alreadyLoggedIn => authToken != null;

  // String? get authToken => UserLoginModel.getToken();
  //
  // UserModel? get activeUser => UserModel.getActiveUserFromCache();

  UserInfoModel? get activeUser => UserLoginModel.getUserInfo();
}

var globalData = _GlobalData();
