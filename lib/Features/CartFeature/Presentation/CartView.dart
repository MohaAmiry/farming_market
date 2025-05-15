import 'package:auto_route/auto_route.dart';
import 'package:farming_market/Features/CartFeature/Domain/Cart.dart';
import 'package:farming_market/Features/CartFeature/Presentation/Notifiers/CartNotifiers.dart';
import 'package:farming_market/Features/CartFeature/Presentation/_Widgets/CartDealerWidget.dart';
import 'package:farming_market/Features/SplashFeature/ErrorView.dart';
import 'package:farming_market/Features/SplashFeature/LoadingView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/Resouces/ColorManager.dart';
import '../../../utils/Resouces/ThemeManager.dart';
import '../../../utils/Resouces/ValuesManager.dart';

@RoutePage()
class CartView extends ConsumerWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("العربة الحالية"),
      ),
      backgroundColor: ColorManager.surface,
      body: Container(
        decoration: ThemeManager.scaffoldBackground,
        child: Padding(
          padding: const EdgeInsets.all(PaddingValuesManager.p20),
          child: ref.watch(customerCartProvider).when(
                data: (data) => SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => const Divider(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => CartDealerWidget(
                          cartDealer: data.cartDealers.elementAt(index),
                        ),
                        itemCount: data.cartDealers.length,
                      ),
                      getSummary(context, data),
                      ElevatedButton(
                          onPressed: () async {
                            var result = await ref
                                .read(customerCartProvider.notifier)
                                .confirmCart();
                            if (result && context.mounted) {
                              context.router.maybePop();
                            }
                          },
                          child: const Text("تأكيد الطلب")),
                      const SizedBox(height: 25)
                    ],
                  ),
                ),
                error: (error, stackTrace) => ErrorView(error: error),
                loading: () => const LoadingView(),
              ),
        ),
      ),
    );
  }

  Widget getSummary(BuildContext context, Cart cart) => Card(
          child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "الملخص",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              "المجموع: ${cart.totalWithDiscount} ر.س",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: ColorManager.secondary),
            )
          ]),
        ),
      ));
}
