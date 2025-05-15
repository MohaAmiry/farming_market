import 'package:auto_route/auto_route.dart';
import 'package:farming_market/Features/CartFeature/Presentation/Notifiers/OrdersNotifiers.dart';
import 'package:farming_market/utils/Resouces/ColorManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/Resouces/ThemeManager.dart';
import '../../../utils/Resouces/ValuesManager.dart';
import '../../SplashFeature/ErrorView.dart';
import '../../SplashFeature/LoadingView.dart';
import '_Widgets/OrderOverviewWidget.dart';

@RoutePage()
class DealerOrdersHistoryView extends ConsumerWidget {
  const DealerOrdersHistoryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("سجل طلبات الزبائن"),
      ),
      backgroundColor: ColorManager.surface,
      body: Container(
        height: double.infinity,
        decoration: ThemeManager.scaffoldBackground,
        child: Padding(
            padding: const EdgeInsets.all(PaddingValuesManager.p20),
            child: ref.watch(dealerCustomerOrdersHistoryProvider).when(
                data: (data) => ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) =>
                        OrderOverviewWidget(order: data.elementAt(index))),
                error: (error, stackTrace) => ErrorView(error: error),
                loading: () => const LoadingView())),
      ),
    );
  }
}
