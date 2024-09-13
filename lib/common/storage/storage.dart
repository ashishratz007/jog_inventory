

import '../exports/main_export.dart';

class _Storage {
  late Box configBox;
  late Box userBox;
  late Box dataBox;

  Future onInit() async {
    if(!config.isWeb){
      final appDocumentDir = await getApplicationDocumentsDirectory();
      await Hive.initFlutter(appDocumentDir.path);
    }

    /// open all required box
    configBox = await Hive.openBox('config_box');
    userBox = await Hive.openBox('user_box');
    dataBox = await Hive.openBox('data_box');
  }

  /// close all box
  void closeBoxes() async {
    await configBox.close();
    await userBox.close();
    await dataBox.close();
  }

  /// close all box
  void deleteBoxes() async {
    await configBox.deleteFromDisk();
    await userBox.deleteFromDisk();
    await dataBox.deleteFromDisk();
  }



  /// to identify test user
  bool get isTestUser  {
   return configBox.get(appKeys.testUser,defaultValue: false);
  }

  void setTestUser({required bool isTestUser}) async {
    await configBox.put(appKeys.testUser, isTestUser);
  }

}

final storage = _Storage();
