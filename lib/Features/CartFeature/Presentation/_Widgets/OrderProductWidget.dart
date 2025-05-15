import 'package:farming_market/Features/CartFeature/Domain/CartProduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/Resouces/ColorManager.dart';
import '../../../_SharedData/TextIcon.dart';

class OrderProductWidget extends ConsumerWidget {
  final CartProduct cartProduct;

  const OrderProductWidget({super.key, required this.cartProduct});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: 100,
                height: 100,
                child: Align(
                    alignment: Alignment.center,
                    child: Image.network(cartProduct.product.images.first))),
            const VerticalDivider(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "اسم المنتج: ${cartProduct.product.name}",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: ColorManager.secondary),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextIconWidget(
                          icon: Icons.monetization_on,
                          text: Text(
                              "السعر: ${cartProduct.product.price.toString()}")),
                      Text("عدد القطع: ${cartProduct.amount}"),
                    ],
                  ),
                  totalCost()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget totalCost() => cartProduct.discount == 0
      ? Text("${cartProduct.totalRaw}")
      : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Prices Section
            Row(
              children: [
                Text(
                  '\$${cartProduct.totalRaw.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                SizedBox(width: 8),
                // Discounted Price
                Text(
                  '${cartProduct.totalWithDiscount.toStringAsFixed(2)}ر.س',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),

            Container(
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                '-${(cartProduct.discount * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
            ),
          ],
        );
}
