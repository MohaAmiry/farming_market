import 'package:dart_mappable/dart_mappable.dart';
import 'package:farming_market/Features/CartFeature/Domain/CartProduct.dart';
import 'package:farming_market/Features/DealerShop/Domain/DealerOverview.dart';
import 'package:farming_market/Features/DealerShop/Domain/Product.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

part 'CartDealer.mapper.dart';

@MappableClass()
class CartDealerDTO with CartDealerDTOMappable {
  final String dealerOverview;
  final IList<CartProductDTO> products;
  final bool takeFromStore;
  final bool? state;

  const CartDealerDTO(
      {required this.dealerOverview,
      required this.takeFromStore,
      required this.products,
      this.state});

  CartDealer toCartDealerWithOverview(
          DealerOverview overview, List<ProductDTO> fetchedProducts) =>
      CartDealer(
          takeFromStore: takeFromStore,
          dealerOverview: overview,
          products: products
              .mapIndexedAndLast((index, item, isLast) =>
                  item.toCartProductWithDealerOverview(
                      fetchedProducts.elementAt(index), overview))
              .toIList());

  static const fromMap = CartDealerDTOMapper.fromMap;
}

@MappableClass()
class CartDealer with CartDealerMappable {
  final DealerOverview dealerOverview;
  final IList<CartProduct> products;
  final bool takeFromStore;
  final bool? state;

  const CartDealer(
      {required this.dealerOverview,
      required this.takeFromStore,
      required this.products,
      this.state});

  double get totalRaw => products.fold(
        0.0,
        (previousValue, element) => previousValue + element.totalRaw,
      );

  double get totalWithDiscount => products.fold(
        0.0,
        (previousValue, element) => previousValue + element.totalWithDiscount,
      );

  CartDealerDTO toDTO() => CartDealerDTO(
      takeFromStore: takeFromStore,
      dealerOverview: dealerOverview.dealerId,
      products: products.map((element) => element.toDTO()).toIList());

  List<CartProductDTO> get cartProductDTOs =>
      products.map((element) => element.toDTO()).toList();

  CartDealer addProduct(Product product, int amount) {
    return copyWith(
        products: products.replaceFirstWhere(
            (item) => item.product.productId == product.productId,
            (item) => item == null
                ? CartProduct(
                    product: product,
                    discount: product.discount,
                    amount: amount)
                : item.copyWith(amount: amount),
            addIfNotFound: true));
  }

  CartDealer removeProduct(Product product) {
    var productIndex = products.indexWhere(
        (element) => element.product.productId == product.productId);
    if (productIndex < 0) return this;

    return copyWith(products: products.removeAt(productIndex));

    /*
    if (products.elementAt(productIndex).amount == 1) {
    }
    return copyWith(
        products: products.replace(
      productIndex,
      products
          .elementAt(productIndex)
          .copyWith(amount: products.elementAt(productIndex).amount - 1),
    ));

     */
  }
}
