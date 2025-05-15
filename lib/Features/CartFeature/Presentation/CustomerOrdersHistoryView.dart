import 'package:auto_route/annotations.dart';
import 'package:farming_market/Features/CartFeature/Presentation/Notifiers/CustomerOrdersNotifiers.dart';
import 'package:farming_market/Features/CartFeature/Presentation/_Widgets/OrderOverviewWidget.dart';
import 'package:farming_market/Features/SplashFeature/ErrorView.dart';
import 'package:farming_market/Features/SplashFeature/LoadingView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/Resouces/ColorManager.dart';
import '../../../utils/Resouces/ThemeManager.dart';
import '../../../utils/Resouces/ValuesManager.dart';

@RoutePage()
class CustomerOrdersHistoryView extends ConsumerWidget {
  const CustomerOrdersHistoryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الطلبات المنتهية"),
      ),
      backgroundColor: ColorManager.surface,
      body: Container(
        height: double.infinity,
        decoration: ThemeManager.scaffoldBackground,
        child: Padding(
          padding: const EdgeInsets.all(PaddingValuesManager.p20),
          child: ref.watch(customerOrdersHistoryProvider(true)).when(
                data: (data) => ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) =>
                      OrderOverviewWidget(order: data.elementAt(index)),
                ),
                error: (error, stackTrace) => ErrorView(error: error),
                loading: () => const LoadingView(),
              ),
        ),
      ),
    );
  }
}
