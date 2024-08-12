
import 'package:jog_inventory/modules/auth/controllers/login_controller.dart';
import '../../../common/exports/main_export.dart';

class LoginScreen extends GetView<AuthController> {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colours.white,
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /// header
                    header(),
                    /// form
                    loginForm()
                  ],
                ),
              ),
            )));
  }

  /// page header
  Widget header() {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          width: Get.width,
          child: Image.asset(
            'assets/images/login.png',
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            top: 0,
            child: Container(
              color: Colors.black.withOpacity(0.6),
            )),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          top: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding:
                    EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black,
                      width: 3
                    ),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(color: Colors.white38, blurRadius: 3)
                    ]),
                height: 130,
                width: 130,
                child: Image.asset('assets/images/logo.png',height: 100,width: 100,),
              ),
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 30,
          decoration: BoxDecoration(
              color: Colours.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              )
          ),
        ))

      ],
    );
  }

  /// form fields
  Widget loginForm() {
    return Form(
      key: controller.formKey,
      child: Container(
        padding: AppPadding.formPadding,
        width: Get.width,
        decoration: BoxDecoration(
          color: Colours.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gap(space: 10),
            // title sub tile
            Container(
              padding: EdgeInsets.only(left: 15,right: 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  displayAssetsWidget(AppIcons.boxes,height: 25,width: 25),
                  gap(space: 10),
                  Text(
                    appStrings.loginTitle,
                    style: appTextTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            /// fields
            gap(space: 30),
            PrimaryTextField(
                hintText: 'Email',
                initialValue: controller.userLogin.email,
                validator: (String? str) {
                  if (stringActions.isNullOrEmpty(str)) {
                    return "Email cannot be empty";
                  } else
                    return null;
                },
                onChanged: (String? value) {
                  controller.userLogin.email = value;
                }),

            SizedBox(height: 20),

            /// password
            Obx(
              () => PrimaryTextField(
                  hintText: 'Password',
                  initialValue: controller.userLogin.password,
                  obscureText: !controller.showPassword.value,
                  suffixIcon: IconButton(
                      onPressed: () {
                        controller.showPassword.value =
                            !controller.showPassword.value;
                      },
                      icon: Icon(
                        Icons.remove_red_eye,
                        size: 20,
                        color: controller.showPassword.value? Colours.blueAccent:Colors.black,
                      )),
                  validator: (String? str) {
                    if (stringActions.isNullOrEmpty(str)) {
                      return "Password cannot be empty";
                    } else
                      return null;
                  },
                  onChanged: (String? value) {
                    controller.userLogin.password = value;
                  }),
            ),
            SizedBox(height: 30),

            /// remember me and forgot password
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    onTap: controller.toggleRememberMe,
                    child: Row(
                      children: [
                        !controller.rememberMe.value
                            ? Icon(
                          Icons.check_box,
                          color: Colours.blueDark,
                          size: 30,
                        )
                            : Icon(
                          Icons.check_box_outline_blank,
                          color: Colours.blueDark,
                          size: 30,
                        ),
                        SizedBox(width: 10),
                        Text(
                          appStrings.rememberMe,
                          style: appTextTheme.labelMedium,
                        )
                      ],
                    ),
                  ),
                  Text(appStrings.forgotPassword,
                      style: appTextTheme.labelMedium
                          ?.copyWith(color: Colours.primary))
                ],
              ),
            ),
            SizedBox(height: 80),

            Obx(
              () => PrimaryButton(
                title: appStrings.signIn,
                onTap: controller.onFormSubmit,
                isBusy: controller.isBusy.value,
              ),
            ),
            Gap(30)
          ],
        ),
      ),
    );
  }
}
