
import 'dart:io';

import 'package:flutter/material.dart';

Widget displayImage(
    {required String imagePath,
    BoxFit fit = BoxFit.fill,
    double? height,
    double? width}) {
  if (imagePath.contains("http"))
    return Container(
      color: Colors.grey.shade200,
      child: displayNetworkImage(
        imagePath: imagePath,
        width: width,
        fit: fit,
        height: height,
      ),
    );
  else
    return displayAssetImage(
      imagePath: imagePath,
      width: width,
      fit: fit,
      height: height,
    );
}

Widget displayAssetImage(
    {required String imagePath,
    BoxFit fit = BoxFit.fill,
    double? height,
    double? width}) {
  return Builder(
    builder: (context) {
      return Image.asset(
        imagePath,
        fit: fit,
        height: height,
        width: width,
        errorBuilder: (BuildContext context, Object object, StackTrace? trace) {
          return Icon(Icons.error,
              size: ((height??0) < 30) ? ((height ?? 10) * 2): height, color: Colors.red.withOpacity(0.3));
        },
      );
    }
  );
}

Widget displayNetworkImage(
    {required String imagePath,
    BoxFit fit = BoxFit.fill,
    double? height,
    double? width}) {
  return Image.network(
    imagePath,
    fit: fit,
    scale: 0.5,
    height: height,
    width: width,
    errorBuilder: (BuildContext context, Object object, StackTrace? trace) {
      return Icon(Icons.error,
          size: ((height??0) < 30) ? ((height ?? 10) * 2): height, color: Colors.red.withOpacity(0.3));
    },
  );
}

Widget displayFileImage(
    {required File file,
    BoxFit fit = BoxFit.fitWidth,
    double? height,
    double? width}) {
  return Image.file(
    file,
    fit: fit,
    scale: 0.5,
    height: height,
    width: width,
    errorBuilder: (BuildContext context, Object object, StackTrace? trace) {
      return Icon(Icons.error,
          size: ((height??0) < 30) ? ((height ?? 10) * 2) : height, color: Colors.red.withOpacity(0.3));
    },
  );
}
