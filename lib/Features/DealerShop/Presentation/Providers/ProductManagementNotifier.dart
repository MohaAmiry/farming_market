import 'package:farming_market/Features/AuthenticationFeature/Data/Repositories/AuthController.dart';
import 'package:farming_market/Features/_SharedData/AbstractDataRepository.dart';
import 'package:farming_market/utils/Extensions.dart';
import 'package:farming_market/utils/SharedOperations.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../ExceptionHandler/MessageEmitter.dart';
import '../../Domain/Product.dart';
import 'ImagePickerNotifier.dart';

part 'ProductManagementNotifier.g.dart';

@riverpod
class ProductManagerNotifier extends _$ProductManagerNotifier
    with SharedUserOperations {
  @override
  ProductDTO build() {
    return ProductDTO.withDealerOverview(
        ref.read(authControllerProvider).requireValue!.user!.uid);
  }

  void setEditProduct(ProductDTO product) {
    state = state.copyWith(
        dealerOverview: product.dealerOverview,
        inStock: product.inStock,
        name: product.name,
        price: product.price,
        productId: product.productId,
        images: product.images);
  }

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  void setDiscount(String discount) {
    state = state.copyWith(discount: double.parse(discount) / 100);
  }

  void setPrice(String price) {
    state = state.copyWith(price: double.tryParse(price) ?? -1);
  }

  void setStock(String stock) =>
      state = state.copyWith(inStock: int.parse(stock));

  Future<bool> setImages() async {
    var result = await AsyncValue.guard(
        () => ref.read(imagePickerNotifierProvider.notifier).pickImages());
    if (result.hasError) {
      ref
          .read(messageEmitterProvider.notifier)
          .setFailed(message: Exception(result.error.toString()));
      return false;
    }
    state = state.copyWith(images: result.requireValue.toIList());
    return true;
  }

  Future<bool> addProduct() async {
    if (!validateProduct()) {
      return false;
    }
    var result = await ref.operationPipeLine(
        func: () => ref
            .read(repositoryClientProvider)
            .productsRepository
            .addProduct(state));

    if (result.hasError) return false;
    return true;
  }

  Future<bool> removeProduct(String productId) async {
    var result = await ref.operationPipeLine(
        func: () => ref
            .read(repositoryClientProvider)
            .productsRepository
            .removeProduct(productId));
    if (result.hasError) return false;
    return true;
  }

  Future<bool> updateProduct(bool changedImages) async {
    if (!validateProduct()) {
      return false;
    }

    var result = await ref.operationPipeLine(
        func: () => ref
            .read(repositoryClientProvider)
            .productsRepository
            .updateProduct(
                changedImages ? state : state.copyWith(images: IList())));
    if (result.hasError) {
      return false;
    }
    return true;
  }

  bool validateProduct() {
    if (state.name.isEmpty) {
      ref
          .read(messageEmitterProvider.notifier)
          .setFailed(message: Exception("الأسم فارغ"));
      return false;
    }

    if (state.discount > 1 || state.discount < 0) {
      ref
          .read(messageEmitterProvider.notifier)
          .setFailed(message: Exception("الخصم غير صحيح"));
      return false;
    }

    if (state.price < 1) {
      ref
          .read(messageEmitterProvider.notifier)
          .setFailed(message: Exception("تم ادخال سعر خاطئ"));
      return false;
    }
    if (state.images.isEmpty) {
      ref
          .read(messageEmitterProvider.notifier)
          .setFailed(message: Exception("يجب إضافة صورة على الأقل"));
      return false;
    }
    return true;
  }
}
