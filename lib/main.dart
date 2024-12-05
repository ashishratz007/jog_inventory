import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:jog_inventory/firebase_options.dart';
import 'package:jog_inventory/services/tab_view_navigator.dart';
import 'common/client/firebase.dart';
import 'common/exports/main_export.dart';
import 'services/notifications/firebase_notification_setup.dart';

void main() async {
  setSafeAreaColor();

  /// initialize hive internal storage
  await storage.onInit();

  /// setup firebase
  await FirebaseCreds.init();

  /// Firebase notification
  if (!(config.isIOS && !config.isReleaseMode)) {
    await firebaseApi.initNotifications();
    FirebaseMessaging.onBackgroundMessage(_backgroundNotification);
  }

  /// dio client which will make our api calls
  dioClient.Init();

  runApp(const JogInventory());
}

@pragma("vm:entry-point")
Future<void> _backgroundNotification(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
            seedColor: Colours.primary,
            primary: Colours.black,
            onSurface: Colours.black,
          ),
          useMaterial3: true,
        ),
        initialRoute: AppRoutesString.splash,
        // initialRoute: globalData.authToken == null
        //     ? AppRoutesString.login
        //     : AppRoutesString.home,
        getPages: getRoutes,
        navigatorObservers: [mainNavigationService],
        onReady: () {
          config.phoneWidth = Get.width;
        },
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.linear(config.isTablet
                    ? 1.2
                    : 1.0)), // Set your desired text scale factor
            child: child!,
          );
        },
      ),
    );
  }
}

DatePickerThemeData datePickerTheme() {
  return DatePickerThemeData(
      todayBackgroundColor:
          WidgetStateProperty.all(Colours.secondary.withOpacity(0.8)),
      dayStyle: appTextTheme.titleMedium,
      todayBorder: BorderSide(color: Colours.white),
      backgroundColor: Colours.white,
      dayBackgroundColor:
          WidgetStateProperty.all(Colours.primary.withOpacity(0.2)),
      surfaceTintColor: Colours.white,
      rangePickerHeaderForegroundColor: Colors.white,
      // dayForegroundColor: MaterialStateProperty.all(Colors.white),
      headerBackgroundColor: Colours.secondary,
      headerHeadlineStyle:
          appTextTheme.titleMedium?.copyWith(color: Colours.white),
      headerHelpStyle: appTextTheme.titleLarge?.copyWith(color: Colours.white),
      headerForegroundColor: Colours.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(color: Colours.secondary)),
      cancelButtonStyle: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(color: Colours.white)),
          ),
          backgroundColor: WidgetStateProperty.all(Colors.white)),
      confirmButtonStyle: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(color: Colours.white)),
          ),
          backgroundColor: WidgetStateProperty.all(Colours.white)));
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
