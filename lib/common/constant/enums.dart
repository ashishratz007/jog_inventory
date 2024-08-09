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
