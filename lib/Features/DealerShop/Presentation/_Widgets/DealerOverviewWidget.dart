import 'package:auto_route/auto_route.dart';
import 'package:farming_market/Features/DealerShop/Domain/DealerOverview.dart';
import 'package:farming_market/Router/MyRoutes.gr.dart';
import 'package:flutter/material.dart';

class DealerOverviewWidget extends StatelessWidget {
  final DealerOverview dealerOverview;

  const DealerOverviewWidget({super.key, required this.dealerOverview});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
          onTap: () => context.router
              .push(SingleDealerShopRoute(dealerOverview: dealerOverview)),
          child: Center(
              child: SizedBox(
            height: 100,
            child: Center(
              child: Text(dealerOverview.dealerName,
                  style: Theme.of(context).textTheme.titleLarge),
            ),
          ))),
    );
  }
}
