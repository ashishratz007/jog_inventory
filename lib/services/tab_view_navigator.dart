import 'package:jog_inventory/common/exports/common.dart';

class _NavigationService extends NavigatorObserver {
  // Singleton instance
  static final _NavigationService instance = _NavigationService._internal();
  // Private constructor
  _NavigationService._internal();

  // GlobalKey for the navigator
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Push a new route onto the navigation stack
  Future<dynamic> push(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  /// Pop the top-most route off the navigation stack
  void pop([Object? result]) {
    navigatorKey.currentState!.pop(result);
  }

  /// Replace the current route with a new one
  Future<dynamic> pushReplacement(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  /// Clear all routes and push a new route
  Future<dynamic> pushAndRemoveUntil(String routeName,
      {Object? arguments, bool Function(Route<dynamic>)? predicate}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      predicate ?? (route) => false,
      arguments: arguments,
    );
  }

  /// Navigate back to the first route
  void popUntilFirst() {
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  // Override methods from NavigatorObserver (optional for tracking)
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    debugPrint('Pushed route: ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    debugPrint('Popped route: ${route.settings.name}');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    debugPrint(
        'Replaced route: ${oldRoute?.settings.name} with ${newRoute?.settings.name}');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    debugPrint('Removed route: ${route.settings.name}');
  }
}

class MainNavigationService extends GetObserver {
  // Singleton instance
  static final MainNavigationService instance =
      MainNavigationService._internal();

  // Private constructor
  MainNavigationService._internal();

  /// Push a new route onto the navigation stack
  Future<dynamic> push(String routeName, {Object? arguments}) {
    if (config.isTablet) {
      return tabNavigator.push(routeName, arguments: arguments);
    } else {
      return Get.toNamed(
        routeName,
        arguments: arguments,
      )!;
    }
  }

  /// Pop the top-most route off the navigation stack
  void pop({Object? result}) {
    if (config.isTablet) {
      tabNavigator.pop();
    } else {
     Get.back(result:result);
    }
  }

  /// Replace the current route with a new one
  Future<dynamic> pushReplacement(String routeName, {Object? arguments}) {
    if (config.isTablet) {
      return tabNavigator.pushReplacement(routeName, arguments: arguments);
    } else {
      return Get.offNamed(
        routeName,
        arguments: arguments,
      )!;
    }
  }

  // /// Clear all routes and push a new route
  // Future<dynamic> pushAndRemoveUntil(String routeName,
  //     {Object? arguments, bool Function(GetPageRoute)? predicate}) {
  //   return Get.offAllNamed(
  //     routeName,
  //     arguments: arguments,
  //     predicate: predicate ?? (route) => false,
  //   )!;
  // }

  /// Navigate back to the first route
  void popUntilFirst() {
    while (Get.isOverlaysOpen) {
      mainNavigationService.pop();
    }
  }

  /// Override methods from GetObserver for tracking
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    debugPrint('Pushed route: ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    debugPrint('Popped route: ${route.settings.name}');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    debugPrint(
        'Replaced route: ${oldRoute?.settings.name} with ${newRoute?.settings.name}');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    debugPrint('Removed route: ${route.settings.name}');
  }
}

var tabNavigator = _NavigationService.instance;
var mainNavigationService = MainNavigationService.instance;
