import 'package:jog_inventory/common/globals/global.dart';

import 'common/client/firebase.dart';
import 'common/exports/main_export.dart';

void main() async {
  setSafeAreaColor();
  /// setup firebase
  await FirebaseCreds.init();
  /// dio client which will make our api calls
  dioClient.Init();

  /// initialize hive
  await storage.onInit();

  runApp(const JogInventory());
}

class JogInventory extends StatelessWidget {
  const JogInventory({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: false,
      splitScreenMode: true,
      child: GetMaterialApp(
        // home: AnimatedLine(),
        debugShowCheckedModeBanner: false,
        title: 'JOG INVENTORY',
        theme: ThemeData(
          splashFactory: InkRipple.splashFactory,
          textTheme: appTextTheme,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              overlayColor:
                  WidgetStateColor.resolveWith((states) => Colours.primaryBg),
            ),
          ),
          buttonTheme: ButtonThemeData(
            splashColor: Colours.primaryBg,
            hoverColor: Colours.bgColor,
            buttonColor: Colours.primary,
            focusColor: Colours.primaryLite,
            textTheme: ButtonTextTheme.normal,
          ),
          primaryColor: Colours.primary,
          dropdownMenuTheme: dropDownMenuTheme(),
          highlightColor: Colours.primary,
          hoverColor: Colours.primaryBg,
          splashColor: Colours.primaryBg,
          hintColor: Colors.black,
          focusColor: Colours.primary,
          datePickerTheme: datePickerTheme(),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.white,
            primary: Colours.primary,
            onSurface: Colours.primary,
          ),
          useMaterial3: true,
        ),
        initialRoute: AppRoutesString.splash,
        // initialRoute: globalData.authToken == null
        //     ? AppRoutesString.login
        //     : AppRoutesString.home,
        getPages: getRoutes,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.linear(
                    1.0)), // Set your desired text scale factor
            child: child!,
          );
        },
      ),
    );
  }
}

DatePickerThemeData datePickerTheme() {
  return DatePickerThemeData(
      todayBorder: BorderSide(color: Colours.primary),
      backgroundColor: Colours.primaryLite,
      dayBackgroundColor: WidgetStateProperty.all(Colors.white),
      surfaceTintColor: Colors.white,
      rangePickerHeaderForegroundColor: Colors.white,
      // dayForegroundColor: MaterialStateProperty.all(Colors.white),
      headerBackgroundColor: Colours.primaryLite,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Colours.primary)),
      cancelButtonStyle: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colours.primary)),
          ),
          backgroundColor: WidgetStateProperty.all(Colors.white)),
      confirmButtonStyle: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colours.primary)),
          ),
          backgroundColor: WidgetStateProperty.all(Colors.white)));
}

DropdownMenuThemeData dropDownMenuTheme() {
  return DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(
          contentPadding:
              EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
          labelStyle: appTextTheme.titleMedium),
      menuStyle: MenuStyle(
        padding: WidgetStateProperty.all(EdgeInsets.all(0)),
      ));
}
