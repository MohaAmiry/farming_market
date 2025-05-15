import 'package:farming_market/Features/CartFeature/Domain/Order.dart';
import 'package:farming_market/Features/DealerShop/Domain/Product.dart';
import 'package:farming_market/Features/_SharedData/AbstractDataRepository.dart';
import 'package:farming_market/utils/FirebaseConstants.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Domain/Cart.dart';
import '../Domain/CartProduct.dart';

class CartRepository extends AbstractRepository {
  final Ref ref;

  CartRepository({required this.ref});

  Future<Cart> getCustomerCart(String customerId) async {
    var result = await firebaseFireStore
        .collection(FirebaseConstants.cartsCollection)
        .doc(customerId)
        .get();
    if (!result.exists) {
      await firebaseFireStore
          .collection(FirebaseConstants.cartsCollection)
          .doc(customerId)
          .set(CartDTO.empty(customerId).toMap());
      return Cart(customerId: customerId, cartDealers: IList());
    }
    var cartDTO = CartDTO.fromMap(result.data()!);
    var dealersOverviews = await ref
        .read(repositoryClientProvider)
        .dealerRepository
        .getDealersOverviewsById(cartDTO.cartDealers
            .map((element) => element.dealerOverview)
            .toList());
    var products = await cartDTO.cartDealers
        .map((dealer) => dealer.products
            .map((product) => ref
                .read(repositoryClientProvider)
                .productsRepository
                .getProductDTOById(product.productId))
            .wait)
        .wait;
    return cartDTO.toCart(dealersOverviews, products);
  }

  Stream<Cart> getCustomerCartStream(String customerId) {
    return firebaseFireStore
        .collection(FirebaseConstants.cartsCollection)
        .doc(customerId)
        .snapshots()
        .asyncMap((event) async {
      if (!event.exists) {
        await firebaseFireStore
            .collection(FirebaseConstants.cartsCollection)
            .doc(customerId)
            .set(CartDTO.empty(customerId).toMap());
        return Cart(customerId: customerId, cartDealers: IList());
      }
      var cartDTO = CartDTO.fromMap(event.data()!);
      var dealersOverviews = await ref
          .read(repositoryClientProvider)
          .dealerRepository
          .getDealersOverviewsById(cartDTO.cartDealers
              .map((element) => element.dealerOverview)
              .toList());
      var products = await cartDTO.cartDealers
          .map((dealer) => dealer.products
              .map((product) => ref
                  .read(repositoryClientProvider)
                  .productsRepository
                  .getProductDTOById(product.productId))
              .wait)
          .wait;
      return cartDTO.toCart(dealersOverviews, products);
    });
  }

  Future<bool> addProductToCart(
      Product product, String customerId, int amount) async {
    var currentCart = await getCustomerCart(customerId);
    var dealerToAddTo = currentCart.cartDealers.indexWhere((element) =>
        element.dealerOverview.dealerId == product.dealerOverview.dealerId);
    if (dealerToAddTo < 0) {
      currentCart = currentCart.copyWithNewDealer(product, amount);
    } else {
      currentCart =
          currentCart.copyWithNewProduct(product, dealerToAddTo, amount);
    }
    await firebaseFireStore
        .collection(FirebaseConstants.cartsCollection)
        .doc(customerId)
        .set(currentCart.toDTO().toMap());
    return true;
  }

  Future<bool> setTakeFromStore(
      bool toState, String dealerId, String customerId) async {
    var currentCart = await getCustomerCart(customerId);
    currentCart = currentCart.copyWith(
        cartDealers: currentCart.cartDealers.replaceFirstWhere(
            (item) => item.dealerOverview.dealerId == dealerId,
            (item) => item!.copyWith(takeFromStore: toState),
            addIfNotFound: false));
    await firebaseFireStore
        .collection(FirebaseConstants.cartsCollection)
        .doc(customerId)
        .update(currentCart.toDTO().toMap());
    return true;
  }

  Future<bool> removeProductFromCart(Product product, String customerId) async {
    var currentCart = await getCustomerCart(customerId);
    var dealerToRemoveFrom = currentCart.cartDealers.indexWhere((element) =>
        element.dealerOverview.dealerId == product.dealerOverview.dealerId);
    if (dealerToRemoveFrom == -1) {
      return true;
    }
    currentCart =
        currentCart.copyWithRemoveProduct(product, dealerToRemoveFrom);
    await firebaseFireStore
        .collection(FirebaseConstants.cartsCollection)
        .doc(customerId)
        .update(currentCart.toDTO().toMap());
    return true;
  }

  Future<bool> confirmCustomerCart(Cart customerCart) async {
    if (customerCart.cartDealers.isEmpty) return true;
    var orders = customerCart.toOrdersDTOs();
    var ordersDocs = await orders
        .map((element) => firebaseFireStore
            .collection(FirebaseConstants.ordersCollection)
            .add(element.toMap()))
        .wait;
    await ordersDocs
        .map(
            (element) => element.update({OrderDTO.firebaseOrderId: element.id}))
        .wait;
    await firebaseFireStore
        .collection(FirebaseConstants.cartsCollection)
        .doc(customerCart.customerId)
        .update(customerCart.copyWith(cartDealers: IList()).toMap());

    await setProductsStock(customerCart.reduceOrderedProducts());
    return true;
  }

  Future<bool> setProductsStock(List<CartProduct> products) async {
    await products
        .map((e) async => await setProductStock(
            e.product.productId, e.product.inStock - e.amount))
        .wait;
    return true;
  }

  Future<bool> setProductStock(String productId, int updatedStock) async {
    await firebaseFireStore
        .collection(FirebaseConstants.productsCollection)
        .doc(productId)
        .update({ProductDTO.firebaseInStock: updatedStock});
    return true;
  }
}
