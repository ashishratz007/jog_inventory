import 'package:flutter/material.dart';
import 'package:jog_inventory/common/constant/colors.dart';

enum SnackBarType {
  success,
  error,
  info,
  message;

  Color get bgColor => [
        Color(0xffDCFFE5),
        Color(0xffEEC8C5),
        Color(0xffF9F6DA),
        Color(0xffE0FAFF),
      ][index];

  Color get titleColor => [
        Color(0xff34C759),
        Color(0xffFF3B30),
        Color(0xffFF9500),
        Color(0xff30B0C7),
      ][index];

  Widget get icon => [
        CircleAvatar(
          radius: 12,
          backgroundColor: Color(0xff34C759),
          child: Icon(
            Icons.done,
            size: 18,
            color: Colours.white,
          ),
        ),
        Icon(Icons.error, color: Color(0xffFF3B30), size: 25),
        Icon(Icons.error, color: Color(0xffFF9500), size: 25),
        Icon(Icons.error, color: Color(0xff30B0C7), size: 25),
      ][index];
}

enum VehicleStatusType {
  underReview,
  approved,
  sold,
  rejected,
  archived;

  String get title =>
      ["Under Review", "Approved", "Sold", "Rejected", "Archived"][index];
}
enum ScanBarcodeType {
  assets,
  material,
  ink,
  paper;

  String get key =>
      ["assets", "material","ink","paper"][index];
}

enum FabricMaterialType {
  piece,
  yard,
  kg;

  String get title => ["Piece", "yard", "Kg"][index];

  static String getTitle(int index) {
    return FabricMaterialType.values[index == 0 ? index : (index - 1)].title;
  }
}

enum MaterialRQType {
  Fabric,
  Accessory;

  String get title => ["Fabric", "Accessory"][index];

  static String getTitle(int index) {
    return MaterialRQType.values[index == 0 ? index : (index - 1)].title;
  }
}

enum UpdateStatus { updated, update, forceUpdate }

enum PageType {
  materialRq,
  stockIn,
  forCast,
  noCodeRq;

  String get title => ["materialRq", "stockIn", "forCast", "noCodeRq"][index];

  String get keys => ["materialRq", "stockIn", "forCast", "noCodeRq"][index];

  static String getTitle(int index) {
    return PageType.values[index == 0 ? index : (index - 1)].title;
  }
}
