import 'package:auto_route/auto_route.dart';
import 'package:farming_market/Features/AuthenticationFeature/Data/Repositories/AuthController.dart';
import 'package:farming_market/Features/AuthenticationFeature/Domain/User/UserRole.dart';
import 'package:farming_market/Features/CartFeature/Domain/Order.dart';
import 'package:farming_market/Features/CartFeature/Presentation/Notifiers/OrdersNotifiers.dart';
import 'package:farming_market/Features/CartFeature/Presentation/_Widgets/OrderProductWidget.dart';
import 'package:farming_market/utils/Resouces/ThemeManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/Resouces/ColorManager.dart';
import '../../../utils/Resouces/ValuesManager.dart';

@RoutePage()
class DealerCustomerSingleOrderView extends ConsumerWidget {
  final Order order;

  const DealerCustomerSingleOrderView({super.key, required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تفاصيل الطلب"),
      ),
      backgroundColor: ColorManager.surface,
      body: Container(
        height: double.infinity,
        decoration: ThemeManager.scaffoldBackground,
        child: Padding(
          padding: const EdgeInsets.all(PaddingValuesManager.p20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: order.products.length,
                  itemBuilder: (context, index) => OrderProductWidget(
                      cartProduct: order.products.elementAt(index)),
                ),
                const Divider(),
                getSummary(context),
                const SizedBox(
                  height: 20,
                ),
                if (ref
                            .watch(authControllerProvider)
                            .requireValue
                            .runtimeType ==
                        Dealer &&
                    order.state == null)
                  Column(
                    children: [
                      getContactInfo(ref, context),
                      getDealerButtons(ref, context)
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getSummary(BuildContext context) => Card(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("الملخص", style: Theme.of(context).textTheme.titleLarge),
                const Divider(),
                Text(
                  "حالة الطلب: ${order.stateString}",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text("عدد المنتجات المطلوبة: ${order.products.length}"),
                Text("التكلفة الكلية: ${order.totalWithDiscount}")
              ],
            ),
          ),
        ),
      );

  Widget getContactInfo(WidgetRef ref, BuildContext context) => Card(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("بيانات تواصل الزبون",
                    style: Theme.of(context).textTheme.titleLarge),
                const Divider(),
                Text("اسم الزبون: ${order.customerInfo.name}"),
                Text("رقم التواصل: ${order.customerInfo.phoneNumber}"),
                Text("الموقع: ${order.customerInfo.address}"),
                Text("وسيلة الاستلام: ${order.deliveryString}"),
              ],
            ),
          ),
        ),
      );

  Widget getDealerButtons(WidgetRef ref, BuildContext context) =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        ElevatedButton(
            onPressed: () async {
              var result = await ref
                  .read(dealerCustomerOrdersProvider.notifier)
                  .setOrderState(true, order);
              if (result && context.mounted) {
                context.router.maybePop();
              }
            },
            child: const Text("قبول الطلب")),
        ElevatedButton(
            onPressed: () async {
              var result = await ref
                  .read(dealerCustomerOrdersProvider.notifier)
                  .setOrderState(false, order);
              if (result && context.mounted) {
                context.router.maybePop();
              }
            },
            style: ThemeManager.getElevatedButtonThemeRisk().style,
            child: const Text("رفض الطلب"))
      ]);
}
