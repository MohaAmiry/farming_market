import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:farming_market/Features/DealerShop/Presentation/Providers/ProductManagementNotifier.dart';
import 'package:farming_market/utils/Resouces/ThemeManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/Resouces/ColorManager.dart';
import '../../../utils/Resouces/ValuesManager.dart';
import 'Providers/ImagePickerNotifier.dart';

@RoutePage()
class AddProductView extends ConsumerStatefulWidget {
  const AddProductView({super.key});

  @override
  ConsumerState createState() => _AddProductViewState();
}

class _AddProductViewState extends ConsumerState<AddProductView> {
  TextEditingController nameTextController = TextEditingController();
  TextEditingController priceTextController = TextEditingController();
  TextEditingController stockTextController = TextEditingController();
  TextEditingController discountTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.watch(productManagerNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("إضافة منتج"),
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
                  "إضافة صور",
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
                            child:
                                ref.watch(imagePickerNotifierProvider).isEmpty
                                    ? const Icon(Icons.image,
                                        color: ColorManager.primary20opacity,
                                        size: 150)
                                    : Row(
                                        children: [
                                          for (int i = 0;
                                              i <
                                                  ref
                                                      .watch(
                                                          imagePickerNotifierProvider)
                                                      .length;
                                              i++)
                                            Image.file(
                                              height: 200,
                                              File(ref
                                                  .watch(
                                                      imagePickerNotifierProvider)
                                                  .elementAt(i)
                                                  .path),
                                            )
                                        ],
                                      ),
                          ),
                          ElevatedButton(
                            onPressed: () => ref
                                .read(productManagerNotifierProvider.notifier)
                                .setImages(),
                            style: ThemeManager.getElevatedButtonThemeSmall(
                                    backgroundColor: ColorManager.secondary)
                                .style,
                            child: const Text("إضافة صورة"),
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
                          .addProduct();
                      if (result && context.mounted) {
                        context.maybePop();
                      }
                    },
                    child: const Text("إضافة المنتج"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
