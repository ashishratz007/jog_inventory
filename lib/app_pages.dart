import 'package:jog_inventory/modules/auth/bindings/bindings.dart';
import 'package:jog_inventory/modules/home/screens/home.dart';
import 'package:jog_inventory/modules/material/models/material_request_detail.dart';
import 'package:jog_inventory/modules/material/screens/material_request_form.dart';
import 'package:jog_inventory/modules/material/screens/material_request_list.dart';
import 'package:jog_inventory/modules/material/screens/material_scan_details.dart';
import 'package:jog_inventory/modules/material/screens/submit_order.dart';
import 'common/exports/main_export.dart';

List<GetPage<dynamic>> getRoutes = [
  GetPage(
      name: AppRoutesString.login,
      page: () => LoginScreen(),
      bindings: [AuthBindings()]),

  GetPage(
    name: AppRoutesString.home,
    page: () => HomeScreen(),
    bindings: [
      ///
    ],
  ),

  GetPage(
    name: AppRoutesString.materialDetailById,
    page: () => MaterialRequestDetailScreen(),
    bindings: [
      ///
    ],
  ),

  GetPage(
    name: AppRoutesString.submit_order,
    page: () => SubmitOrderScreen(),
    bindings: [
      ///
    ],
  ),


  GetPage(
    name: AppRoutesString.materialRequestList,
    page: () => MaterialRequestListScreen(),
    bindings: [
      ///
    ],
  ),

  GetPage(
    name: AppRoutesString.materialRequestForm,
    page: () => MaterialRequestFormScreen(),
    bindings: [
      ///
    ],
  ),
];
