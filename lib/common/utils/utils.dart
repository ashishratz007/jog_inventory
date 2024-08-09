import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:jog_inventory/common/exports/main_export.dart';
import 'package:path/path.dart' as path;

String getMediaUrl(String mediaPath) {
  return config.mediaUrl + mediaPath;
}

/// All string actions
class _StingActions {
  bool isNullOrEmpty(String? value) {
    return (value == null || value == "");
  }

  bool isNumber(String value) {
    int? newV = int.tryParse(value);
    return newV != null;
  }
}

var stringActions = _StingActions();

/// [gap] constant gap between two widget
Widget gap({double? space}) => Gap(space ?? 20);

Future<File?> pickFile() async {
  FilePickerResult? result =
      await FilePicker.platform.pickFiles(allowMultiple: false,type: FileType.image,);

  if (result != null) {
    File file = File(result.files.single.path!);
    return file;
  } else {
    throw "User canceled the picker";
  }
}

Future<List<File>> pickFiles({int limit = 6}) async {
  try {
    // Pick files
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true, // Allow multiple file selection
      type: FileType.image, // Only pick images
    );

    if (result != null) {
      List<PlatformFile> pickedFiles = result.files;

      // Debug: Log number of files picked
      print("Number of files picked: ${pickedFiles.length}");

      if (pickedFiles.length > limit) {
        // Notify the user that the limit was exceeded
        errorSnackBar(message: "Limit exceeded. Please select up to $limit files.");
        throw "Limit exceeded. Please select up to $limit files.";
      }

      // Convert PlatformFile to File
      List<File> files = pickedFiles
          .where((image) => image.path != null) // Ensure path is not null
          .map((image) => File(image.path!))
          .toList();

      return files;
    } else {
      throw "User canceled the picker";
    }
  } catch (e) {
    // Handle any unexpected errors
    print("Error picking files: $e");
    rethrow; // Optional: rethrow the exception to handle it further up the call stack
  }
}


Widget chooseFileButton(
  BuildContext context, {
  required void Function(File) onFilePick,
}) {
  return PrimaryBorderButton(
      // padding: EdgeInsets.only(left: 1, right: 10, top: 8,bottom: 8),
      isFullWidth: false,
      title: "Choose File",
      onTap: () async {
        try {
          var file = await pickFile();
          if (file != null) onFilePick(file);
        } catch (e) {
          /// TODO:
        }
      });
}

abstract final class ParseData {
  static String? string(value) {
    return value ?? null;
  }

  /// parse double
  static double? toDouble(value) {
    if (value == null) return null;
    return double.tryParse("$value");
  }

  // integer
  static int? toInt(value) {
    if (value == null) return null;
    return int.tryParse("$value");
  }

  /// parse bool
  static bool toBool(value) {
    if (value == null) return false;
    if (value is String) {
      if (value == "True" || value == "true" || value == "1") {
        return true;
      } else {
        return false;
      }
    }
    if (value == 1 || value == true) return true;
    return false;
  }

  /// parse List
  static List<T> toList<T>(
    List? items, {
    required T Function(dynamic) itemBuilder,
  }) {
    if (items == null) return [];
    List<T> newItems = <T>[];
    items.forEach((item) {
      var newItem = itemBuilder(item);
      newItems.add(newItem);
    });
    return newItems;
  }

  static Map stringToMap(String value) {
    String trimmedString = value.substring(1, value.length - 1).trim();

    Map<String, String> result = {};
    List<String> keyValuePairs = trimmedString.split(', ');
    for (String pair in keyValuePairs) {
      List<String> parts = pair.split(': ');
      if (parts.length == 2) {
        result[parts[0]] = parts[1];
      }
    }
    return result;
  }

  /// [toDate] parse date to local and then convert it to string
  static String? toDateString(String value) {
    if (value.isNotEmpty) {
      return DateTime.tryParse(value)?.toLocal().toString();
    }
    return null;
  }

  static DateTime? toDateTime(String? value) {
    if ((value??"").isNotEmpty) {
      return DateTime.tryParse(value!)?.toLocal();
    }
    return null;
  }
}

abstract final class LaunchUrl {
  static Future launch(String url) async {
    var uri = Uri.parse('https://flutter.dev');
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      print(e);

      /// TODO:
    }
  }
}

double multiplyDouble(double num1, double num2, {int afterPoint = 2}) {
  var total = num1 * num2;
  return double.parse(total.toStringAsFixed(afterPoint));
}

List<Widget> displayList<T>({
  required List? items,
  required Widget Function(T, int index) builder,
  bool showGap = false,
  double space = 10,
  double spaceLast = 10,
}) {
  if (items == null) return [];
  List<Widget> widgetItems = [];

  for (var i = 0; i < items.length; i++) {
    widgetItems.add(builder(items[i], i));

    /// adding gap
    if (showGap) {
      widgetItems.add(gap(space: space));
    }
  }
  if (spaceLast > 0) widgetItems.add(gap(space: spaceLast));
  return widgetItems;
}

Widget displayListBuilder<T>({
  required List? items,
  required Widget Function(T, int index) builder,
  bool showGap = false,
  bool shrinkWrap = true,
  ScrollController? scrollController,
  ScrollPhysics physics = const NeverScrollableScrollPhysics(),
  double space = 10,
  double spaceLast = 0,
}) {
  var widgetItems = displayList<T>(
      items: items,
      builder: builder,
      space: space,
      showGap: showGap,
      spaceLast: spaceLast);
  return ListView(
    shrinkWrap: shrinkWrap,
    physics: physics,
    children: widgetItems,
    controller: scrollController,
  );
}

Widget safeAreaBottom(context) {
  return gap(space: SafeAreaBottomValue(context) + keyboardHeight(context));
}

Widget safeAreaTop(context) {
  return gap(space: SafeAreaTopValue(context));
}

double SafeAreaBottomValue(context) {
  return MediaQuery.viewPaddingOf(context).bottom;
}

double SafeAreaTopValue(context) {
  return MediaQuery.viewPaddingOf(context).top;
}

double keyboardHeight(context){
  return MediaQuery.of(context).viewInsets.bottom;
}

class _ColorManager {
  final List<Color> colors = [
    // Colors.indigo,
    Colors.red,
    Colors.green,
    Colors.orange,
    // Colors.blue,
    Colors.yellow,
    Colors.purple,
    // Colors.cyan,
    Colors.amber,
  ];

  Color getColorFromString(String input) {
    // Get the hash code of the input string
    int hashCode = input.hashCode;

    // Ensure the hash code is positive
    hashCode = hashCode & 0x7FFFFFFF;

    // Use the hash code to determine the index in the color list
    int index = hashCode % colors.length;

    // Return the color at the calculated index
    return colors[index];
  }
}

var colorManager = _ColorManager();

formatNumber(String number) {
  return NumberFormat("#,##0.00").format(double.parse(number));
}

String encodeBase64(String value) {
  List<int> bytes = utf8.encode(value);
  String base64Encoded = base64Encode(bytes);
  return base64Encoded;
}

bool isImage(String file) {
  final fileExtension = path.extension(file).toLowerCase();
  bool isImage = ['.png', '.jpg', '.jpeg', '.gif', '.bmp', '.webp']
      .contains(fileExtension);
  return isImage;
}

addFrameCallBackFunction({required Function() onDone}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    onDone();
  });
}

getKeyBoardStatus(BuildContext context, {required Function(double) onDone}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    var height = MediaQuery.of(context).viewInsets.bottom;
    onDone(height);
  });
}

Widget displayLogoWidget({
  double? height,
  double? width,
}) {
  return Image.asset(
    'assets/images/logo.png',
    height: height,
    width: width,
  );
}

Widget displayAssetsWidget(
  String path, {
  double? height,
  double? width,
      BoxFit?fit,
}) {
  return Image.asset(
    path,
    height: height,
    width: width,
    fit:fit ,
  );
}

BoxDecoration containerDecoration(
    {Color? color,
    double radius = 10,
    double borderWidth = 1.5,
    Gradient? gradient,
    Color? borderColor,
      List<BoxShadow>?boxShadow,
    DecorationImage? image}) {
  return BoxDecoration(
    color: color ?? Colors.white,
    borderRadius: BorderRadius.circular(radius),
    gradient: gradient,

    border:
        Border.all(color: borderColor ?? Colours.bgGrey, width: borderWidth),
    image: image,
    boxShadow: boxShadow
  );
}

String getOrdinalSuffix(int number) {
  if (number <= 0) {
    return number.toString(); // Handle non-positive numbers
  }

  switch (number % 100) {
    case 11:
    case 12:
    case 13:
      return "${number}th";
    default:
      switch (number % 10) {
        case 1:
          return "${number}st";
        case 2:
          return "${number}nd";
        case 3:
          return "${number}rd";
        default:
          return "${number}th";
      }
  }
}

List<int> getPast20Years() {
  int currentYear = DateTime.now().year;
  return List<int>.generate(20, (index) => currentYear - index);
}

void hideKeyboard(BuildContext context) {
  WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  SystemChannels.textInput.invokeMethod('TextInput.hide');
}
