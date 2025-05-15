import 'package:farming_market/Features/CartFeature/Domain/CartDealer.dart';
import 'package:farming_market/Features/CartFeature/Presentation/Notifiers/CartNotifiers.dart';
import 'package:farming_market/Features/CartFeature/Presentation/_Widgets/CartProductWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartDealerWidget extends ConsumerStatefulWidget {
  final CartDealer cartDealer;

  const CartDealerWidget({super.key, required this.cartDealer});

  @override
  ConsumerState createState() => _CartDealerWidgetState();
}

class _CartDealerWidgetState extends ConsumerState<CartDealerWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.cartDealer.dealerOverview.dealerName,
                style: Theme.of(context).textTheme.titleMedium),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.cartDealer.products.length,
              itemBuilder: (context, index) => CartProductWidget(
                  cartProduct: widget.cartDealer.products.elementAt(index)),
            ),
            Text("طريقة الاستلام",
                style: Theme.of(context).textTheme.titleMedium),
            switchTakeFromStore()
          ],
        ),
      ),
    );
  }

  Widget switchTakeFromStore() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Radio(
                value: true,
                groupValue: widget.cartDealer.takeFromStore,
                onChanged: (value) => ref
                    .read(customerCartProvider.notifier)
                    .setTakeFromStore(
                        value!, widget.cartDealer.dealerOverview.dealerId),
              ),
              const Text(
                'اخذ من المتجر',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Radio(
                  value: false,
                  groupValue: widget.cartDealer.takeFromStore,
                  onChanged: (value) => ref
                      .read(customerCartProvider.notifier)
                      .setTakeFromStore(
                          value!, widget.cartDealer.dealerOverview.dealerId)),
              const Text(
                'توصيل',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      );

  Widget getSummary(WidgetRef ref) => Column(children: [
        const Text("الملخص"),
        Text("المجموع: ${widget.cartDealer.totalWithDiscount}")
      ]);
}
