import 'package:auto_route/auto_route.dart';
import 'package:farming_market/Features/CartFeature/Presentation/Notifiers/OrdersNotifiers.dart';
import 'package:farming_market/Features/CartFeature/Presentation/_Widgets/OrderOverviewWidget.dart';
import 'package:farming_market/Features/SplashFeature/ErrorView.dart';
import 'package:farming_market/Features/SplashFeature/LoadingView.dart';
import 'package:farming_market/Router/MyRoutes.gr.dart';
import 'package:farming_market/utils/Resouces/ColorManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/Resouces/ThemeManager.dart';
import '../../../utils/Resouces/ValuesManager.dart';

@RoutePage()
class DealerAllOrdersView extends ConsumerWidget {
  const DealerAllOrdersView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("طلبات الزبائن"),
        actions: [
          IconButton(
              onPressed: () =>
                  context.router.push(const DealerOrdersHistoryRoute()),
              icon: const Icon(Icons.history))
        ],
      ),
      backgroundColor: ColorManager.surface,
      body: Container(
        height: double.infinity,
        decoration: ThemeManager.scaffoldBackground,
        child: Padding(
            padding: const EdgeInsets.all(PaddingValuesManager.p20),
            child: ref.watch(dealerCustomerOrdersProvider).when(
                data: (data) => ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) =>
                        OrderOverviewWidget(order: data.elementAt(index))),
                error: (error, stackTrace) => ErrorView(error: error),
                loading: () => const LoadingView())),
      ),
    );
  }
}
