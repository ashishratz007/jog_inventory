import 'package:jog_inventory/common/base_model/base_model.dart';
import '../../../common/exports/common.dart';

class UserLoginModel extends BaseModel {
  @override
  String get endPoint => 'api/login';

  /// login data
  String? email;
  String? password;

  /// static variables
  static const authTokenKey = "auth_token_key";
  static const userLoginCreds = "auth_token_credentials";
  static const userLoginInfo = "auth_login_info";

  UserLoginModel({this.email, this.password});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      // 'device_token': firebaseApi.FCMToken,
    };
  }

  UserLoginModel.fromJson(Map<dynamic, dynamic> data)
      : this.email = data['email'],
        this.password = data['password'];

  static Future storeToken(token) async {
    await storage.userBox.put(authTokenKey, token);
  }

  /// token
  static String? getToken() {
    return storage.userBox.get(authTokenKey, defaultValue: null);
  }

  static removeToken() {
    storage.userBox.delete(authTokenKey);
  }

  /// save user login info like email password ( credentials )
  static storeUserCreds(UserLoginModel info) async {
    var data = info.toJson();
    await storage.userBox.put(userLoginCreds, data);
  }

  /// get user info if saved (credentials)
  static UserLoginModel? getUserCreds() {
    var info = storage.userBox.get(userLoginCreds, defaultValue: null);
    // storage.userBox.delete(userInfo);
    if (info != null) {
      return UserLoginModel.fromJson(info);
    }
    return null;
  }


  /// store user data
  static storeUserInfo(UserInfoModel info) async {
    var data = info.toJson();
    await storage.userBox.put(userLoginInfo, data);
  }

  /// get user info if saved
  static UserInfoModel? getUserInfo() {
    var info = storage.userBox.get(userLoginInfo, defaultValue: null);
    // storage.userBox.delete(userInfo);
    if (info != null) {
      return UserInfoModel.fromJson(info);
    }
    return null;
  }

  static Future logoutUser() async {
    await storage.userBox.clear();
    // await UserLoginModel().create(url: "/Api/Logout");
  }
}



class UserLoginResponse {

  String? accessToken;
  String? tokenType;
  String? message;
  int? status;
  UserInfoModel? employee;


  UserLoginResponse(
      {this.accessToken,
        this.tokenType,
        this.message,
        this.status,
        this.employee});

  UserLoginResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    tokenType = json['token_type'];
    message = json['message'];
    status = json['status'];
    employee = json['employee'] != null
        ? UserInfoModel.fromJson(json['employee'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['token_type'] = tokenType;
    data['message'] = message;
    data['status'] = status;
    if (employee != null) {
      data['employee'] = employee!.toJson();
    }
    return data;
  }
}

class UserInfoModel {
  int? employeeId;
  String? employeeName;
  String? employeeEmail;
  String? employeeTel;
  int? employeePositionId;
  int? customerId;
  String? employeePassword;
  String? employeeAuth;
  String? employeeImage;
  int? employeeLoginStat;
  String? employeeLoginTime;
  String? employeeLastLogin;
  String? cookieStart;
  int? employeeStat;
  String? magnifierMode;

  UserInfoModel(
      {this.employeeId,
        this.employeeName,
        this.employeeEmail,
        this.employeeTel,
        this.employeePositionId,
        this.customerId,
        this.employeePassword,
        this.employeeAuth,
        this.employeeImage,
        this.employeeLoginStat,
        this.employeeLoginTime,
        this.employeeLastLogin,
        this.cookieStart,
        this.employeeStat,
        this.magnifierMode});

  UserInfoModel.fromJson(Map<dynamic, dynamic> json) {
    employeeId = json['employee_id'];
    employeeName = json['employee_name'];
    employeeEmail = json['employee_email'];
    employeeTel = json['employee_tel'];
    employeePositionId = json['employee_position_id'];
    customerId = json['customer_id'];
    employeePassword = json['employee_password'];
    employeeAuth = json['employee_auth'];
    employeeImage = json['employee_image'];
    employeeLoginStat = json['employee_login_stat'];
    employeeLoginTime = json['employee_login_time'];
    employeeLastLogin = json['employee_last_login'];
    cookieStart = json['cookie_start'];
    employeeStat = json['employee_stat'];
    magnifierMode = json['magnifier_mode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employee_id'] = employeeId;
    data['employee_name'] = employeeName;
    data['employee_email'] = employeeEmail;
    data['employee_tel'] = employeeTel;
    data['employee_position_id'] = employeePositionId;
    data['customer_id'] = customerId;
    data['employee_password'] = employeePassword;
    data['employee_auth'] = employeeAuth;
    data['employee_image'] = employeeImage;
    data['employee_login_stat'] = employeeLoginStat;
    data['employee_login_time'] = employeeLoginTime;
    data['employee_last_login'] = employeeLastLogin;
    data['cookie_start'] = cookieStart;
    data['employee_stat'] = employeeStat;
    data['magnifier_mode'] = magnifierMode;
    return data;
  }
}
