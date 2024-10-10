

import 'package:firebase_messaging/firebase_messaging.dart';

import '../../common/exports/common.dart';

/// [handleMessageTap] is used to set tap event when notification icon is tapped
Future<void> handleMessageTap(RemoteMessage? message) async{
  if (message == null) return;
  navigateUserToPage(message.data);

  /// handle tap
  print("On Notification Tap called");
}

void navigateUserToPage(payload) async {
  print("Notification tapped =============================${payload}=============================");
  if (!(payload is Map) && payload.isNotEmpty) {
    Get.offAllNamed(AppRoutesString.splash);
    return;
  }
  String type = payload['type']??"";
  String path = payload['path']??"";
  int tab = int.tryParse(payload['tab'] ?? "0") ?? 0;
  
 if(!config.isAppInitialized) {
    Get.offAllNamed(AppRoutesString.splash);
    /// app takes 2 seconds to load splash so taking 2 seconds delay to perform splash actions
    await Future.delayed(Duration(seconds: 2));
  }

 // return user if not logged in to the device
 if(!config.isUserLoggedIn) return;
 
 /// navigate user to actual page
 switch(type){
   case "":
     /// TODO: handle cases for notification
     return;
 }

}

// void navigateToSplash() {}
