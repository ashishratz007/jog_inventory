
import '../exports/main_export.dart';

rotateIcon(RxDouble _rotationAngle, {Widget? icon}) {
  return Obx(
    () => AnimatedRotation(
      turns: _rotationAngle.value,
      duration: Duration(seconds: 1),
      child: icon ??
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 40,
            color: Colors.blue,
          ),
    ),
  );
}
