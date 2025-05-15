import 'package:dart_mappable/dart_mappable.dart';
import 'package:farming_market/Features/CartFeature/Domain/Order.dart';
import 'package:farming_market/Features/DealerShop/Domain/Product.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../DealerShop/Domain/DealerOverview.dart';
import 'CartDealer.dart';
import 'CartProduct.dart';

part 'Cart.mapper.dart';

@MappableClass()
class CartDTO with CartDTOMappable {
  final String customerId;
  final IList<CartDealerDTO> cartDealers;

  const CartDTO({required this.customerId, required this.cartDealers});

  factory CartDTO.empty(String customerId) =>
      CartDTO(customerId: customerId, cartDealers: IList());

  static get firebaseCustomerId => "customerId";

  Cart toCart(List<DealerOverview> dealersOverviews,
      List<List<ProductDTO>> dealersProducts) {
    List<CartDealer> cartConvertedDealers = [];
    for (int i = 0; i < dealersOverviews.length; i++) {
      cartConvertedDealers.add(cartDealers
          .elementAt(i)
          .toCartDealerWithOverview(
              dealersOverviews.elementAt(i), dealersProducts.elementAt(i)));
    }
    return Cart(
        customerId: customerId, cartDealers: cartConvertedDealers.toIList());
  }

  List<CartProductDTO> reduceOrderedProducts() {
    return cartDealers
        .map((element) => element.products)
        .reduce((value, element) => value.addAll(element))
        .toList();
  }

  List<OrderDTO> toOrdersDTOs() => cartDealers
      .map((element) => OrderDTO(
          takeFromStore: element.takeFromStore,
          orderId: "",
          orderTime: DateTime.now(),
          dealerId: element.dealerOverview,
          customerId: customerId,
          products: element.products.toList()))
      .toList();

  static const fromMap = CartDTOMapper.fromMap;
}

@MappableClass()
class Cart with CartMappable {
  final String customerId;
  final IList<CartDealer> cartDealers;

  const Cart({required this.customerId, required this.cartDealers});

  double get totalRaw => cartDealers.fold(
      0, (previousValue, element) => previousValue + element.totalRaw);

  double get totalWithDiscount => cartDealers.fold(
      0, (previousValue, element) => previousValue + element.totalWithDiscount);

  List<OrderDTO> toOrdersDTOs() => cartDealers
      .map((element) => OrderDTO(
          takeFromStore: element.takeFromStore,
          orderId: "",
          orderTime: DateTime.now(),
          dealerId: element.dealerOverview.dealerId,
          customerId: customerId,
          products: element.cartProductDTOs))
      .toList();

  CartDTO toDTO() => CartDTO(
      customerId: customerId,
      cartDealers: cartDealers.map((element) => element.toDTO()).toIList());

  List<CartProduct> reduceOrderedProducts() {
    return cartDealers
        .map((element) => element.products)
        .reduce((value, element) => value.addAll(element))
        .toList();
  }

  Cart copyWithNewDealer(Product product, int amount) {
    return copyWith(
        cartDealers: cartDealers.add(CartDealer(
            takeFromStore: false,
            dealerOverview: product.dealerOverview,
            products: IList([
              CartProduct(
                  product: product, discount: product.discount, amount: amount)
            ]))));
  }

  Cart copyWithNewProduct(Product product, int dealerIndex, int amount) {
    return copyWith(
        cartDealers: cartDealers.replace(dealerIndex,
            cartDealers.elementAt(dealerIndex).addProduct(product, amount)));
  }

  Cart copyWithRemoveProduct(Product product, int dealerIndex) {
    var updatedCart = copyWith(
        cartDealers: cartDealers.replace(dealerIndex,
            cartDealers.elementAt(dealerIndex).removeProduct(product)));
    return updatedCart.cartDealers.elementAt(dealerIndex).products.isEmpty
        ? updatedCart.copyWith(
            cartDealers: updatedCart.cartDealers.removeAt(dealerIndex))
        : updatedCart;
  }
}
