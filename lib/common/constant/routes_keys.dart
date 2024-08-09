abstract class AppRoutesString {
  static const splash = "/";
  static const walkThrough = "/walk_through";
  static const login = "/login";
  static const register = "/register";
  static const home = "/home";

  /// vehicle status
  static const addCar = "${home}/add_car";
  static const underReviewCars = "${home}/under_review_cars";
  static const approvedCars = "${home}/approved_cars";
  static const soldCars = "${home}/sold_cars";
  static const rejectedCars = "${home}/rejected_cars";
  static const archivedCars = "${home}/archived_cars";
  static const carDetail = "${home}/car_detail";
  static const carBids = "${soldCars}/car_bids";

}
