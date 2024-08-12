import 'package:jog_inventory/common/constant/enums.dart';
import 'package:jog_inventory/modules/auth/models/user_login.dart';
import '../../../common/exports/main_export.dart';

class AuthController extends GetxController {
  RxBool isBusy = false.obs;
  UserLoginModel userLogin = UserLoginModel();
  var formKey = GlobalKey<FormState>();
  RxBool rememberMe = false.obs;
  RxBool showPassword = false.obs;


  @override
  void onInit() {
    var info = UserLoginModel.getUserCreds();
    if (info != null) userLogin = info;
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
  }

  /// Functions
  toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }

  /// store token to local storage
  void onFormSubmit() async {
    setSafeAreaColor();
    isBusy.value = true;
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();

      try {
        var resp = await userLogin.create();
        /// get login response to display data
        UserLoginResponse loginResponse = UserLoginResponse.fromJson(resp.data);
        var token = loginResponse.accessToken;
        await UserLoginModel.storeToken(token);
        // await UserLoginModel.s(loginResponse.employee!);
        if (rememberMe.value) {
          UserLoginModel.storeUserCreds(userLogin);
        }
        UserLoginModel.storeUserInfo(loginResponse.employee!);
        successSnackBar(message: loginResponse.message??"");
        /// navigate user to login page
        // Get.offAllNamed(AppRoutesString.home);
      } catch (error, trace) {
        showSnackBar(
            title: "Login error", message: "$error", type: SnackBarType.error);
      } finally {
        isBusy.value = false;
      }
    }

    isBusy.value = false;
  }
}
