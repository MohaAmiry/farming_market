import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/Providers/SvgProvider.dart';
import '../utils/Resouces/AssetsManager.dart';
import '../utils/Resouces/ValuesManager.dart';

/*

@RoutePage()
class CustomerNavigationScaffoldView extends ConsumerWidget {
  const CustomerNavigationScaffoldView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoTabsScaffold(
      routes: const [
        CustomerQuotesRoute(),
        HistoryRoute(),
        CustomerProfileRoute()
      ],
      bottomNavigationBuilder: (context, tabsRouter) => BottomNavigationBar(
        currentIndex: tabsRouter.activeIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          tabsRouter.setActiveIndex(value);
        },
        items: [
          _getDestination("My Quotes", ImageAssetsManager.myOrders, ref),
          _getDestination("History", ImageAssetsManager.history, ref),
          _getDestination("Profile", ImageAssetsManager.profile, ref),
        ],
      ),
    );
  }
}

@RoutePage()
class CompanyNavigationScaffoldView extends ConsumerWidget {
  const CompanyNavigationScaffoldView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoTabsScaffold(
      routes: const [
        CompanyAcceptedQuotesRoute(),
        HistoryRoute(),
        CompanyProfileRoute()
      ],
      bottomNavigationBuilder: (context, tabsRouter) => BottomNavigationBar(
        currentIndex: tabsRouter.activeIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          tabsRouter.setActiveIndex(value);
        },
        items: [
          _getDestination("Accepted", ImageAssetsManager.myOrders, ref),
          _getDestination("History", ImageAssetsManager.history, ref),
          _getDestination("Profile", ImageAssetsManager.profile, ref),
        ],
      ),
    );
  }
}

@RoutePage()
class AdminNavigationScaffoldView extends ConsumerWidget {
  const AdminNavigationScaffoldView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoTabsScaffold(
      routes: const [
        AdminPendingRequestsRoute(),
        AdminDashboardRoute(),
        AdminProfileRoute()
      ],
      bottomNavigationBuilder: (context, tabsRouter) => BottomNavigationBar(
        currentIndex: tabsRouter.activeIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          tabsRouter.setActiveIndex(value);
        },
        items: [
          _getDestination("Requests", ImageAssetsManager.reportDetails, ref),
          _getDestination("Dashboard", ImageAssetsManager.adminDashboard, ref),
          _getDestination("Profile", ImageAssetsManager.profile, ref),
        ],
      ),
    );
  }
}

BottomNavigationBarItem _getDestination(
        String label, String path, WidgetRef ref) =>
    BottomNavigationBarItem(
        icon: SizedBox(
            width: AppSizeManager.s20,
            height: AppSizeManager.s20,
            child: ref.watch(SvgLoaderProvider(path, colored: true))),
        label: label);


 */
