abstract class AppRoutesString {
  static const splash = "/";
  static const walkThrough = "/walk_through";
  static const login = "/login";
  static const register = "/register";
  static const dashboard = "/home";
  // static const tabHome = "/tab_home";


  /// material
  static const materialDetailById = "${dashboard}/material_detail";
  static const assetsDetailById = "${dashboard}/asset_detail";
  static const submit_order = "${materialDetailById}/submit_order";
  static const materialRequestList = "${dashboard}/material_request_list";
  static const materialRequestForm = "${dashboard}/material_request_form";
  static const materialRQFinish = "$materialRequestForm/finish";
  static const materialRQFinishDetail = "$materialRQFinish/detail";
  static const noCodeRequest = "${dashboard}/no_code_request";
  static const noCodeRequestList = "${dashboard}/no_code_request_list";
  static const noCodeRequestDetail = "${noCodeRequestList}/no_code_detail";

  /// forecast
  static const addForecast = "${dashboard}/add_forecast";
  static const forecastList = "${dashboard}/list";
  static const forecastDetail= "${dashboard}/list/detail";

  /// stock in
  static const stockInform = "${dashboard}/stock_in_form";
  static const stockInList= "${dashboard}/stock_in_list";
  static const stockInDetail= "${dashboard}/stock_in_list/detail";

  /// stock in
  static const inkList = "${dashboard}/ink_list";
  static const digitalPaper = "${dashboard}/digital_paper";

}
