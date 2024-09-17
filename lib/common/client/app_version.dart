import 'package:package_info_plus/package_info_plus.dart';
import '../exports/common.dart';

class _VersionUpdateCheck {
  Future<void> updateApp() async {
    await Future.delayed(Duration(seconds: 1));
    // you also have some options to customize our Alert Dialog
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          titlePadding: EdgeInsets.only(top: 30, bottom: 10),
          contentPadding: EdgeInsets.zero,
          title: Text('New Update Available',
              textAlign: TextAlign.center, style: appTextTheme.titleMedium),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Update your app',
                      textAlign: TextAlign.center,
                      style: appTextTheme.labelSmall
                          ?.copyWith(color: Colours.blackLite),
                    ),
                  ),
                ],
              ),
              gap(space: 15),
              Divider(height: 1, color: Colours.greyLight),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: EdgeInsets.only(left: 20, right: 20),
          actions: [
            if (false)
              TextButton(
                onPressed: () {
                  //TODO
                },
                child: Text('Later',
                    style: appTextTheme.labelMedium
                        ?.copyWith(color: Colours.greyLight)),
              ),
            TextButton(
              onPressed: () {
                redirectToStore();
              },
              child: Text('Update now',
                  style: appTextTheme.labelMedium
                      ?.copyWith(color: Colours.primaryText)),
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> redirectToStore() async {
    // get bundle id hen navigate to the play or app store
    String bundleId = await getPackageName() ?? "";
    String playStoreUrl =
        'https://play.google.com/store/apps/details?id=${bundleId}';
    String appStoreUrl = 'https://apps.apple.com/app/$bundleId';

    if (config.isAndroid) {
      if (await canLaunchUrl(Uri.parse(playStoreUrl))) {
        await launchUrl(Uri.parse(playStoreUrl));
      } else {
        throw 'Could not launch Play Store';
      }
    } else if (config.isIOS) {
      if (await canLaunchUrl(Uri.parse(appStoreUrl))) {
        await launchUrl(Uri.parse(appStoreUrl));
      } else {
        throw 'Could not launch App Store';
      }
    }
  }

  static Future<String?> getPackageName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // This will return the package name (Android) or bundle ID (iOS)
    return packageInfo.packageName;
  }
}

var checkAppVersion = _VersionUpdateCheck();
