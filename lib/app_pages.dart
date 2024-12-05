import 'package:jog_inventory/modules/auth/bindings/bindings.dart';
import 'package:jog_inventory/modules/forecast/models/detail.dart';
import 'package:jog_inventory/modules/forecast/screens/addforecast_screen.dart';
import 'package:jog_inventory/modules/forecast/screens/detail.dart';
import 'package:jog_inventory/modules/forecast/screens/list.dart';
import 'package:jog_inventory/modules/home/screens/home.dart';
import 'package:jog_inventory/modules/material/models/material_request_detail.dart';
import 'package:jog_inventory/modules/material/screens/asset_detail.dart';
import 'package:jog_inventory/modules/material/screens/finish_material_rq.dart';
import 'package:jog_inventory/modules/material/screens/finished_material_detail.dart';
import 'package:jog_inventory/modules/material/screens/material_request_form.dart';
import 'package:jog_inventory/modules/material/screens/material_request_list.dart';
import 'package:jog_inventory/modules/material/screens/material_scan_details.dart';
import 'package:jog_inventory/modules/material/screens/submit_order.dart';
import 'package:jog_inventory/modules/no_code/screens/no_code_detail.dart';
import 'package:jog_inventory/modules/no_code/screens/no_code_request_form.dart';
import 'package:jog_inventory/modules/no_code/screens/no_code_rq_list.dart';
import 'package:jog_inventory/modules/stock_in/screens/detail.dart';
import 'package:jog_inventory/modules/stock_in/screens/form.dart';
import 'package:jog_inventory/modules/stock_in/screens/list.dart';
import 'package:jog_inventory/splash.dart';
import 'common/exports/main_export.dart';

List<GetPage<dynamic>> getRoutes = [
  GetPage(
    name: AppRoutesString.splash,
    page: () => SplashScreen(),
  ),

  GetPage(
      name: AppRoutesString.login,
      page: () => LoginScreen(),
      bindings: [AuthBindings()]),

  GetPage(
    name: AppRoutesString.dashboard,
    page: () => DashBoardScreen(),
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
    name: AppRoutesString.assetsDetailById,
    page: () => AssetsDetailScreen(),
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
  GetPage(
    name: AppRoutesString.materialRQFinish,
    page: () => FinishMaterialRQScreen(),
    bindings: [
      ///
    ],
  ),
  GetPage(
    name: AppRoutesString.materialRQFinishDetail,
    page: () => FinishedMaterialDetailScreen(),
    bindings: [
      ///
    ],
  ),

  /// no code list
  GetPage(
    name: AppRoutesString.noCodeRequest,
    page: () => NoCodeRequestFormScreen(),
    bindings: [
      ///
    ],
  ),

  GetPage(
    name: AppRoutesString.noCodeRequestList,
    page: () => NoCodeRqListScreen(),
    bindings: [
      ///
    ],
  ),

  GetPage(
    name: AppRoutesString.noCodeRequestDetail,
    page: () => NoCodeDetailScreen(),
    bindings: [
      ///
    ],
  ),

  /// forecast
  GetPage(
    name: AppRoutesString.addForecast,
    page: () => AddForecastScreen(),
    bindings: [
      ///
    ],
  ),

  /// stock in
  GetPage(
    name: AppRoutesString.stockInform,
    page: () => StockInFromScreen(),
    bindings: [
      ///
    ],
  ),
  GetPage(
    name: AppRoutesString.stockInList,
    page: () => StockInListPage(),
    bindings: [
      ///
    ],
  ),
  GetPage(
    name: AppRoutesString.stockInDetail,
    page: () => StockInDetailScreen(),
    bindings: [
      ///
    ],
  ),

  /// Forecast
  GetPage(
    name: AppRoutesString.forecastList,
    page: () => ForecastListScreen(),
    bindings: [
      ///
    ],
  ),
  GetPage(
    name: AppRoutesString.forecastDetail,
    page: () => ForecastDetailScreen(),
    bindings: [
      ///
    ],
  ),
];

Map<String, WidgetBuilder> get routeBuilders {
  Map<String, WidgetBuilder> routeData = {};
  getRoutes.forEach((page) {
    if (page.name == AppRoutesString.dashboard) {
      var data = GetPage(
        name: AppRoutesString.dashboard,
        page: () => HomeScreen(),
        bindings: [
          ///
        ],
      );
      routeData.addAll(
        AppPage(
          name: data.name,
          page: data.page,
          argument: data.arguments,
          bindings: [
            ...data.bindings,
            if (data.binding != null) data.binding!,
          ],
        ),
      );
    } else {
      routeData.addAll(
        AppPage(
          name: page.name,
          page: page.page,
          argument: page.arguments,
          bindings: [
            ...page.bindings,
            if (page.binding != null) page.binding!,
          ],
        ),
      );
    }
  });
  return routeData;
}
