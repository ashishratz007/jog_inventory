import 'package:jog_inventory/modules/auth/bindings/bindings.dart';
import 'common/exports/main_export.dart';

List<GetPage<dynamic>> getRoutes = [
  GetPage(
      name: AppRoutesString.login,
      page: () => LoginScreen(),
      bindings: [AuthBindings()]),
  GetPage(
    name: AppRoutesString.home,
    page: () => Container(),
    bindings: [
      ///
    ],
  ),
];
