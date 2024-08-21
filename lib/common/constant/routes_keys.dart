abstract class AppRoutesString {
  static const splash = "/";
  static const walkThrough = "/walk_through";
  static const login = "/login";
  static const register = "/register";
  static const home = "/home";


  /// material
  static const materialDetailById = "${home}/material_detail";
  static const submit_order = "${materialDetailById}/submit_order";
  static const materialRequestList = "/material_request_list";
  static const materialRequestForm = "/material_request_form";
  static const materialRQFinish = "$materialRequestForm/finish";
  static const materialRQFinishDetail = "$materialRQFinish/detail";


}
