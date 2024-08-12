import 'package:jog_inventory/modules/auth/controllers/login_controller.dart';
import '../../../common/exports/main_export.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}
