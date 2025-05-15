import 'package:auto_route/auto_route.dart';
import 'package:farming_market/Features/AuthenticationFeature/Data/Repositories/AuthController.dart';
import 'package:farming_market/Features/CartFeature/Domain/Order.dart';
import 'package:farming_market/Features/_SharedData/TextIcon.dart';
import 'package:farming_market/Router/MyRoutes.gr.dart';
import 'package:farming_market/utils/Extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderOverviewWidget extends ConsumerWidget {
  final Order order;

  const OrderOverviewWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
        child: InkWell(
      onTap: () =>
          context.router.push(DealerCustomerSingleOrderRoute(order: order)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextIconWidget(
                icon: Icons.date_range,
                text: Text(order.orderTime.toRegularDateWithTime(),
                    style: Theme.of(context).textTheme.headlineMedium)),
            Text("عدد المنتجات المطلوبة: ${order.products.length}"),
            Text("اسم صاحب الطلب: ${order.customerInfo.name}"),
            Text("اسم التاجر: ${order.dealerOverview.dealerName}"),
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  onPressed: () => context.router.push(ChatRoute(
                      otherID: order.getOtherId(ref
                          .read(authControllerProvider)
                          .requireValue!
                          .user!
                          .uid),
                      otherName: order.getOtherName(ref
                          .read(authControllerProvider)
                          .requireValue!
                          .name))),
                  icon: const Icon(Icons.message)),
            )
          ],
        ),
      ),
    ));
  }
}
