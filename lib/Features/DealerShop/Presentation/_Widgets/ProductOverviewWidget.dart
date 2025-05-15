import 'package:auto_route/auto_route.dart';
import 'package:farming_market/Features/AuthenticationFeature/Data/Repositories/AuthController.dart';
import 'package:farming_market/Features/AuthenticationFeature/Domain/User/UserRole.dart';
import 'package:farming_market/Features/CartFeature/Presentation/Notifiers/CartNotifiers.dart';
import 'package:farming_market/Features/DealerShop/Presentation/Providers/ProductManagementNotifier.dart';
import 'package:farming_market/Features/_SharedData/TextIcon.dart';
import 'package:farming_market/Router/MyRoutes.gr.dart';
import 'package:farming_market/utils/Resouces/ColorManager.dart';
import 'package:farming_market/utils/Resouces/ThemeManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Domain/Product.dart';

class ProductOverviewWidget extends ConsumerWidget {
  final Product product;

  const ProductOverviewWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: InkWell(
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
                      child: Image.network(product.images.first))),
              const VerticalDivider(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "اسم المنتج: ${product.name}",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: ColorManager.secondary),
                    ),
                    Text("التوفر: ${product.inStock}"),
                    price(),
                    const Divider(),
                    Text(
                      "التاجر: ${product.dealerOverview.dealerName}",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    ref.watch(authControllerProvider).value is Dealer
                        ? getDealerButtons(context, ref)
                        : getCustomerButtons(context, ref)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getDealerButtons(BuildContext context, WidgetRef ref) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
              style: ThemeManager.getElevatedButtonThemeSmall().style!.copyWith(
                  foregroundColor:
                      const WidgetStatePropertyAll(ColorManager.secondary)),
              onPressed: () => context.router
                  .push(EditProductRoute(productDTO: product.toDTO())),
              child: const Text("تعديل المنتج")),
          TextButton(
              style: ThemeManager.getElevatedButtonThemeSmall().style!.copyWith(
                  foregroundColor:
                      const WidgetStatePropertyAll(ColorManager.error)),
              onPressed: () => ref
                  .read(productManagerNotifierProvider.notifier)
                  .removeProduct(product.productId),
              child: const Text("حذف المنتج"))
        ],
      );

  Widget getCustomerButtons(BuildContext context, WidgetRef ref) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
              onPressed: product.stocked
                  ? () async {
                      var amount = await amountDialog(context, product);
                      if (amount == null) {
                        return;
                      }
                      ref
                          .read(customerCartProvider.notifier)
                          .addToCart(product, amount);
                    }
                  : null,
              child: const Text("إضافة للسلة"))
        ],
      );

  Future<int?> amountDialog(BuildContext context, Product product) async {
    final TextEditingController amountController = TextEditingController();
    String? errorText;
    return await showDialog<int>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: const Text("عدد الوحدات المراد إضافتها"),
            content: TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    if (int.parse(value) > product.inStock ||
                        int.parse(value) <= 0) {
                      errorText = "الرقم المطلوب غير مناسب!";
                    } else {
                      errorText = null;
                    }
                  });
                },
                decoration: InputDecoration(
                    helperText: "",
                    labelText: "الكمية",
                    hintText: "الكمية",
                    errorText: errorText)),
            actions: [
              TextButton(
                  onPressed: () {
                    var value = int.tryParse(amountController.value.text);
                    if (amountController.value.text.isEmpty ||
                        value == null ||
                        value <= 0 ||
                        value > product.inStock) {
                      setState(() {
                        errorText = "أكتب قيمة مناسبة";
                        return;
                      });
                    } else {
                      setState(() {
                        errorText = null;
                      });
                      context.router.maybePop<int>(
                          int.parse(amountController.value.text));
                    }
                  },
                  child: const Text("تأكيد"))
            ],
          ),
        );
      },
    );
  }

  Widget price() => product.discount == 0
      ? TextIconWidget(
          icon: Icons.monetization_on,
          text: Text("السعر: ${product.price.toString()}"))
      : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextIconWidget(
              icon: Icons.monetization_on,
              text: Text(
                "السعر: ${product.price.toString()}",
                style: const TextStyle(
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ),
            Text(
              '${product.priceAfterDiscount.toStringAsFixed(2)}ر.س',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                '-${(product.discount * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
            ),
          ],
        );
}
