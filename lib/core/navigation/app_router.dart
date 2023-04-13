import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/core/di/di.dart';
import 'package:test_task/feature/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:test_task/feature/presentation/pages/auth/auth_page.dart';
import 'package:test_task/feature/presentation/pages/auth/confirm_sms_auth.dart';
import 'package:test_task/feature/presentation/pages/main/main_page.dart';
part 'app_router.gr.dart';

@RoutePage(name: 'AuthRouter')
class AuthRouterPage extends AutoRouter with AutoRouteWrapper {
  AuthRouterPage({super.key});

  /// Оборачиваю роутер в [AuthCubit]
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => diContainer.createAuthCubit(),
      child: this,
    );
  }
}

@RoutePage(name: "MainRouter")
class MainRouterPage extends AutoRouter with AutoRouteWrapper {
  const MainRouterPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => diContainer.createMainCubit(),
      child: this,
    );
  }
}

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: AuthRouter.page, path: '/', children: [
          RedirectRoute(path: '', redirectTo: 'auth'),
          AutoRoute(path: 'auth', page: AuthRoute.page),
          AutoRoute(
            path: 'confirmation',
            page: ConfirmSMSRoute.page,
          ),
        ]),
        AutoRoute(
            page: MainRouter.page,
            path: '/main',
            children: [AutoRoute(path: '', page: MainRoute.page)])
      ];
}
