
class _GlobalData {
  String? authToken = "";
  // bool get alreadyLoggedIn => authToken != null;

  // String? get authToken => UserLoginModel.getToken();
  //
  // UserModel? get activeUser => UserModel.getActiveUserFromCache();
}

var globalData = _GlobalData();
