import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:farming_market/Features/DealerShop/Domain/Product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/Resouces/ColorManager.dart';
import '../../../utils/Resouces/ThemeManager.dart';
import '../../../utils/Resouces/ValuesManager.dart';
import 'Providers/ImagePickerNotifier.dart';
import 'Providers/ProductManagementNotifier.dart';

@RoutePage()
class EditProductView extends ConsumerStatefulWidget {
  final ProductDTO productDTO;

  const EditProductView({super.key, required this.productDTO});

  @override
  ConsumerState createState() => _EditProductViewState();
}

class _EditProductViewState extends ConsumerState<EditProductView> {
  TextEditingController nameTextController = TextEditingController();
  TextEditingController priceTextController = TextEditingController();
  TextEditingController stockTextController = TextEditingController();
  TextEditingController discountTextController = TextEditingController();
  bool changedImages = false;

  @override
  void initState() {
    super.initState();
    Future(() {
      ref
          .read(productManagerNotifierProvider.notifier)
          .setEditProduct(widget.productDTO);
      nameTextController.text = ref.read(productManagerNotifierProvider).name;
      priceTextController.text =
          ref.read(productManagerNotifierProvider).price.toString();
      stockTextController.text =
          ref.read(productManagerNotifierProvider).inStock.toString();
      discountTextController.text =
          ref.read(productManagerNotifierProvider).discountPercent.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(productManagerNotifierProvider);
    ref.watch(imagePickerNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("تعديل منتج"),
      ),
      backgroundColor: ColorManager.surface,
      body: Container(
        decoration: ThemeManager.scaffoldBackground,
        child: Padding(
          padding: const EdgeInsets.all(PaddingValuesManager.p20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                    controller: nameTextController,
                    onChanged: (value) => ref
                        .read(productManagerNotifierProvider.notifier)
                        .setName(value),
                    decoration: const InputDecoration(
                        helperText: "",
                        labelText: "اسم المنتج",
                        hintText: "اسم المنتج")),
                TextFormField(
                    controller: priceTextController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) => ref
                        .read(productManagerNotifierProvider.notifier)
                        .setPrice(value),
                    decoration: const InputDecoration(
                        helperText: "",
                        labelText: "سعر المنتج",
                        hintText: "سعر المنتج")),
                TextFormField(
                    controller: stockTextController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) => ref
                        .read(productManagerNotifierProvider.notifier)
                        .setStock(value),
                    decoration: const InputDecoration(
                        helperText: "",
                        labelText: "الكمية المتوفرة",
                        hintText: "الكمية المتوفرة")),
                TextFormField(
                    controller: discountTextController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) => ref
                        .read(productManagerNotifierProvider.notifier)
                        .setDiscount(value),
                    decoration: const InputDecoration(
                        helperText: "",
                        labelText: "نسبة الخصم",
                        hintText: "نسبة الخصم")),
                const Divider(),
                Text(
                  "هل ترغب بتعديل الصور؟",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(PaddingValuesManager.p10),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (int i = 0;
                                    i <
                                        ref
                                            .watch(
                                                productManagerNotifierProvider)
                                            .images
                                            .length;
                                    i++)
                                  ref.watch(imagePickerNotifierProvider).isEmpty
                                      ? Image.network(
                                          height: 200,
                                          ref
                                              .watch(
                                                  productManagerNotifierProvider)
                                              .images
                                              .elementAt(i))
                                      : Image.file(
                                          height: 200,
                                          File(ref
                                              .watch(
                                                  productManagerNotifierProvider)
                                              .images
                                              .elementAt(i)),
                                        )
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              var result = await ref
                                  .read(productManagerNotifierProvider.notifier)
                                  .setImages();
                              if (result) {
                                setState(() {
                                  changedImages = true;
                                });
                              }
                            },
                            style: ThemeManager.getElevatedButtonThemeSmall(
                                    backgroundColor: ColorManager.secondary)
                                .style,
                            child: const Text("تعديل الصور"),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      var result = await ref
                          .read(productManagerNotifierProvider.notifier)
                          .updateProduct(changedImages);
                      if (result && context.mounted) {
                        context.maybePop();
                      }
                    },
                    child: const Text("تعديل المنتج"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
