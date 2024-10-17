import 'package:jog_inventory/common/globals/global.dart';

import '../exports/main_export.dart';

class TransparentPopup extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onRetry;

  const TransparentPopup({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error,
              color: Colors.red,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Get.back();
                onRetry();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

bool isErrorMessageDisplayed = false;
displayErrorMessage(
  BuildContext context, {
  required error,
  required StackTrace trace,
  String? title,
  String? subtitle,
bool barrierDismissible = true,
  required void Function() onRetry,
}) async {
  await showDialog(
    barrierDismissible: barrierDismissible,
    context: context,
    builder: (context) => TransparentPopup(
      title: title ?? 'Error',
      subtitle: subtitle ?? 'Something went wrong. Please try again.',
      onRetry: onRetry,
    ),
  );
  // if (kReleaseMode)
    throw Exception({
      "user": globalData.activeUser?.employeeName ?? "_",
      "user_id": globalData.activeUser?.employeeId ?? "_",
      "error": error,
      "trace": trace,
    });
}
