import 'package:jog_inventory/common/exports/common.dart';

class _NavigationService extends NavigatorObserver {
  // Singleton instance
  static final _NavigationService instance = _NavigationService._internal();
  _NavigationService._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Public variables to store the current route and arguments
  String? _currentRoute;
  Object? _currentArguments;

  /// Push a new route onto the navigation stack
  Future<dynamic> push(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  BuildContext? get context => navigatorKey.currentState?.context;

  /// Get arguments from the current route
  Object? get arguments => _currentArguments;


  /// Pop the top-most route off the navigation stack
  void pop([Object? result]) {
    if (AppRoutesString.dashboard == _currentRoute) return;
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
        AppRoutesString.dashboard,
      predicate ?? (route) => false,
      arguments: arguments,
    );
  }

  /// Navigate back to the first route
  void popUntilFirst() {
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  // Override methods from NavigatorObserver to track routes
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _currentRoute = route.settings.name;
    _currentArguments = route.settings.arguments;
    debugPrint('Pushed route: $_currentRoute');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    _currentRoute = previousRoute?.settings.name;
    _currentArguments = previousRoute?.settings.arguments;
    debugPrint('Popped route: $_currentRoute');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _currentRoute = newRoute?.settings.name;
    _currentArguments = newRoute?.settings.arguments;
    debugPrint('Replaced route: $_currentRoute');
  }
}

class MainNavigationService extends GetObserver {
  // Singleton instance
  static final MainNavigationService instance =
      MainNavigationService._internal();

  // Private constructor
  MainNavigationService._internal();

  /// read global or tabview argument
  get arguments {
    if (config.isTablet)
      return tabNavigator.arguments;
    else
      return Get.arguments;
  }
  /// Pop from current context
  void back(BuildContext context, [Object? result]) {
    Navigator.pop(context,result);
  }

  /// Push a new route onto the navigation stack // remove all clear all the behind routes in case of tab
  Future<dynamic> push(String routeName,
      {Object? arguments, bool removeAll = false}) {
    if (config.isTablet) {
      if (removeAll) {
         tabNavigator.pushAndRemoveUntil(routeName, arguments: arguments);
      }{
        return tabNavigator.push(routeName, arguments: arguments);
      }
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
      Get.back(result: result);
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
