abstract class AppRoutesString {
  static const splash = "/";
  static const walkThrough = "/walk_through";
  static const login = "/login";
  static const register = "/register";
  static const home = "/home";


  /// material
  static const materialDetailById = "${home}/material_detail";
  static const submit_order = "${materialDetailById}/submit_order";
  static const materialRequestList = "${home}/material_request_list";
  static const materialRequestForm = "${home}/material_request_form";
  static const materialRQFinish = "$materialRequestForm/finish";
  static const materialRQFinishDetail = "$materialRQFinish/detail";
  static const noCodeRequest = "${home}/no_code_request";
  static const noCodeRequestList = "${home}/no_code_request_list";
  static const noCodeRequestDetail = "${noCodeRequestList}/no_code_detail";

  /// forecast
  static const addForecast = "${home}/add_forecast";

  /// stock in
  static const stockInform = "${home}/stock_in_form";

}
