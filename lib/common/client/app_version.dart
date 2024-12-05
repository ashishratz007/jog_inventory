import 'package:jog_inventory/common/base_model/base_model.dart';
import 'package:jog_inventory/common/constant/enums.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../exports/common.dart';

class _VersionUpdateCheck {

  /// popup
  Future<void> _updateApp() async {
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
                _redirectToStore();
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

  static Future<void> _redirectToStore() async {
    // get bundle id hen navigate to the play or app store
    String bundleId = await _getPackageName() ?? "";
    String appId = "6636480918";
    String playStoreUrl =
        'https://play.google.com/store/apps/details?id=${bundleId}';
    String appStoreUrl = 'https://apps.apple.com/app/$appId';

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

  static Future<String> _getPackageName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // This will return the package name (Android) or bundle ID (iOS)
    return packageInfo.packageName;
  }

  /// for checking the version locally and on the server side
  static Future<String> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // This will return the package name (Android) or bundle ID (iOS)
    return packageInfo.version;
  }

  static Future<String> _checkVersion() async {
      var data = await _VersionInfo.getVersion();
      return data.version!;
  }

  Future<UpdateStatus> _compareVersion() async {
    /// getting version from the sources
    // server side version
    List<int> serverParts =
        (await _checkVersion()).split('.').map(int.parse).toList();
    // local version
    List<int> appParts =
        (await _getAppVersion()).split('.').map(int.parse).toList();

    if (serverParts[0] > appParts[0] ||
        (serverParts[0] == appParts[0] && serverParts[1] > appParts[1])) {
      return UpdateStatus.forceUpdate;
    } else if (serverParts[2] > appParts[2]) {
      return UpdateStatus.update;
    } else {
      return UpdateStatus.updated;
    }
  }

  // main function it will be access from the home page
  Future<void> checkForVersion() async {
    UpdateStatus status = await _compareVersion();
    switch (status) {
      case UpdateStatus.updated:
        {
          return;
        }
      case UpdateStatus.forceUpdate:
        {
          return _updateApp();
        }
      case UpdateStatus.update:
        {
          return _updateApp();
        }
    }
  }
}

var checkAppVersion = _VersionUpdateCheck();

class _VersionInfo extends BaseModel {
  @override
  String get endPoint => "/api/version";

  String? version;
  DateTime? updatedAt;

  _VersionInfo({this.version, this.updatedAt});

  factory _VersionInfo.fromJson(Map<dynamic, dynamic> json) {
    return _VersionInfo(
      version: ParseData.string(json['version']),
      updatedAt: ParseData.toDateTime(json['updated_at']??DateTime.now().toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'updated_at': DateTime.now().toString(), // Convert DateTime to string
    };
  }

  static Future<_VersionInfo> getVersion() async {
    // check in cache
    var version = storage.configBox.get(appKeys.version, defaultValue: null);
    if (version != null) {
      var data = _VersionInfo.fromJson(version ?? {});
      if (!isExpired(data.updatedAt!) && data.version != null) {
        return data;
      }
    }

    // making request
    var resp = await _VersionInfo().create(data: {});
    var data =
        _VersionInfo.fromJson((resp.data['data'] as List).firstOrNull ?? {});

    // updating cache
    storage.configBox.put(appKeys.version, data.toJson());
    return data;
  }
}
