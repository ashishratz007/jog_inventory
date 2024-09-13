import 'package:device_info_plus/device_info_plus.dart';
import 'package:jog_inventory/common/exports/common.dart';

enum NewVersionStatus {
  newVersion,
  forceUpdate,
  noChange,
}

class _AppVersion {
  Future<NewVersionStatus> checkAppVersion(String serverAppVersion) async {
    String? currentVersion;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (config.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      currentVersion = androidInfo.version.codename;
    } else if (config.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      currentVersion = iosInfo.systemVersion;
    }

    // Convert versions to a comparable format
    List<int> currentVersionParts =
        currentVersion?.split('.').map(int.parse).toList() ?? [1, 0, 0];
    List<int> serverVersionParts =
        serverAppVersion.split('.').map(int.parse).toList();

    // Compare the versions
    for (int i = 0; i < serverVersionParts.length; i++) {
      if (serverVersionParts[i] > currentVersionParts[i]) {
        if (i == 0) {
          return NewVersionStatus.forceUpdate; // Major version update
        } else {
          return NewVersionStatus.newVersion; // Minor version update
        }
      } else if (serverVersionParts[i] < currentVersionParts[i]) {
        break;
      }
    }

    // If no update is required
    return NewVersionStatus.noChange;
  }

  void checkForUpdate() async {
    String serverAppVersion = "2.1.0"; // Example server version

    NewVersionStatus status = await checkAppVersion(serverAppVersion);

    if (status == NewVersionStatus.forceUpdate) {
      print("Force update required!");
    } else if (status == NewVersionStatus.newVersion) {
      print("A new version is available.");
    } else {
      print("No update needed.");
    }
  }
}

var appVersion = _AppVersion();
