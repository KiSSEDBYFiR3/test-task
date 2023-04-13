// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AuthRouter.name: (routeData) {
      final args = routeData.argsAs<AuthRouterArgs>(
          orElse: () => const AuthRouterArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: AuthRouterPage(key: args.key)),
      );
    },
    MainRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainRouterPage(),
      );
    },
    AuthRoute.name: (routeData) {
      final args =
          routeData.argsAs<AuthRouteArgs>(orElse: () => const AuthRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AuthPage(key: args.key),
      );
    },
    ConfirmSMSRoute.name: (routeData) {
      final args = routeData.argsAs<ConfirmSMSRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ConfirmSMSPage(
          key: args.key,
          phoneNumber: args.phoneNumber,
          controller: args.controller,
        ),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainPage(),
      );
    },
  };
}

/// generated route for
/// [AuthRouterPage]
class AuthRouter extends PageRouteInfo<AuthRouterArgs> {
  AuthRouter({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          AuthRouter.name,
          args: AuthRouterArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'AuthRouter';

  static const PageInfo<AuthRouterArgs> page = PageInfo<AuthRouterArgs>(name);
}

class AuthRouterArgs {
  const AuthRouterArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'AuthRouterArgs{key: $key}';
  }
}

/// generated route for
/// [MainRouterPage]
class MainRouter extends PageRouteInfo<void> {
  const MainRouter({List<PageRouteInfo>? children})
      : super(
          MainRouter.name,
          initialChildren: children,
        );

  static const String name = 'MainRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AuthPage]
class AuthRoute extends PageRouteInfo<AuthRouteArgs> {
  AuthRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          AuthRoute.name,
          args: AuthRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const PageInfo<AuthRouteArgs> page = PageInfo<AuthRouteArgs>(name);
}

class AuthRouteArgs {
  const AuthRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'AuthRouteArgs{key: $key}';
  }
}

/// generated route for
/// [ConfirmSMSPage]
class ConfirmSMSRoute extends PageRouteInfo<ConfirmSMSRouteArgs> {
  ConfirmSMSRoute({
    Key? key,
    required String phoneNumber,
    required TextEditingController controller,
    List<PageRouteInfo>? children,
  }) : super(
          ConfirmSMSRoute.name,
          args: ConfirmSMSRouteArgs(
            key: key,
            phoneNumber: phoneNumber,
            controller: controller,
          ),
          initialChildren: children,
        );

  static const String name = 'ConfirmSMSRoute';

  static const PageInfo<ConfirmSMSRouteArgs> page =
      PageInfo<ConfirmSMSRouteArgs>(name);
}

class ConfirmSMSRouteArgs {
  const ConfirmSMSRouteArgs({
    this.key,
    required this.phoneNumber,
    required this.controller,
  });

  final Key? key;

  final String phoneNumber;

  final TextEditingController controller;

  @override
  String toString() {
    return 'ConfirmSMSRouteArgs{key: $key, phoneNumber: $phoneNumber, controller: $controller}';
  }
}

/// generated route for
/// [MainPage]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
