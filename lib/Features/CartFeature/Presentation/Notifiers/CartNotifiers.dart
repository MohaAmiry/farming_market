import 'package:farming_market/Features/AuthenticationFeature/Data/Repositories/AuthController.dart';
import 'package:farming_market/Features/_SharedData/AbstractDataRepository.dart';
import 'package:farming_market/utils/Extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../DealerShop/Domain/Product.dart';
import '../../Domain/Cart.dart';

part 'CartNotifiers.g.dart';

@riverpod
class CustomerCart extends _$CustomerCart {
  @override
  Stream<Cart> build() {
    return ref
        .read(repositoryClientProvider)
        .cartRepository
        .getCustomerCartStream(
            ref.read(authControllerProvider).requireValue!.user!.uid);
  }

  Future<bool> addToCart(Product product, int amount) async {
    var result = await ref.operationPipeLine(
        func: () => ref
            .read(repositoryClientProvider)
            .cartRepository
            .addProductToCart(
                product,
                ref.read(authControllerProvider).requireValue!.user!.uid,
                amount));
    if (result.hasError) return false;
    return true;
  }

  Future<bool> removeFromCart(String productId, String dealerId) async {
    var result = await ref.operationPipeLine(
        func: () => ref
            .read(repositoryClientProvider)
            .cartRepository
            .removeProductFromCart(
                state.requireValue.cartDealers
                    .firstWhere((element) =>
                        element.dealerOverview.dealerId == dealerId)
                    .products
                    .firstWhere(
                        (element) => element.product.productId == productId)
                    .product,
                ref.read(authControllerProvider).requireValue!.user!.uid));
    if (result.hasError) return false;
    return true;
  }

  void setTakeFromStore(bool toState, String dealerId) {
    ref.operationPipeLine(
        func: () => ref
            .read(repositoryClientProvider)
            .cartRepository
            .setTakeFromStore(
                toState, dealerId, state.requireValue.customerId));
  }

  Future<bool> confirmCart() async {
    var result = await ref.operationPipeLine(
        func: () => ref
            .read(repositoryClientProvider)
            .cartRepository
            .confirmCustomerCart(state.requireValue));
    if (result.hasError) return false;
    return true;
  }
}
