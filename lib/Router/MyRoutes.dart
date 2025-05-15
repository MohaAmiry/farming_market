import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'MyRoutes.gr.dart';

part 'MyRoutes.g.dart';

@AutoRouterConfig(replaceInRouteName: "View,Route")
class MyRoutes extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          initial: true,
        ),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: RegisterAsCustomerRoute.page),
        AutoRoute(page: RegisterAsDealerRoute.page),
        AutoRoute(page: ProfileRoute.page),
        AutoRoute(page: EditProfileRoute.page),
        AutoRoute(page: AddProductRoute.page),
        AutoRoute(page: AllDealersOverviewRoute.page),
        AutoRoute(page: SingleDealerShopRoute.page),
        AutoRoute(page: EditProductRoute.page),
        AutoRoute(page: DealerAllOrdersRoute.page),
        AutoRoute(page: DealerCustomerSingleOrderRoute.page),
        AutoRoute(page: DealerOrdersHistoryRoute.page),
        AutoRoute(page: CartRoute.page),
        AutoRoute(page: CustomerOrdersHistoryRoute.page),
        AutoRoute(page: CustomerActiveOrdersRoute.page),
        AutoRoute(page: ChatRoute.page)
      ];
}

class MyObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    log('New route pushed: ${route.settings.name}');
    //log('Current Stack State: ${route.settings.}');
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    log('Tab route visited: ${route.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    log('Tab route re-visited: ${route.name}');
  }
}

@riverpod
RouterConfig<UrlState> myRoutes(MyRoutesRef ref) {
  return MyRoutes().config(
    navigatorObservers: () => [MyObserver()],
  );
}
