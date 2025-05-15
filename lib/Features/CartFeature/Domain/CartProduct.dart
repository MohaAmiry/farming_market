import 'package:dart_mappable/dart_mappable.dart';
import 'package:farming_market/Features/DealerShop/Domain/DealerOverview.dart';
import 'package:farming_market/Features/DealerShop/Domain/Product.dart';

part 'CartProduct.mapper.dart';

@MappableClass()
class CartProductDTO with CartProductDTOMappable {
  final String productId;
  final double discount;
  final int amount;

  const CartProductDTO(
      {required this.productId, required this.discount, required this.amount});

  CartProduct toCartProductWithDealerOverview(
          ProductDTO product, DealerOverview dealerOverview) =>
      CartProduct(
          product: product.toProduct(dealerOverview),
          discount: discount,
          amount: amount);
}

@MappableClass()
class CartProduct with CartProductMappable {
  final Product product;
  final double discount;
  final int amount;

  const CartProduct(
      {required this.product, required this.discount, required this.amount});

  double get totalRaw => amount * product.price;

  double get totalWithDiscount => (amount * product.price) * (1.0 - discount);

  CartProductDTO toDTO() => CartProductDTO(
      productId: product.productId, discount: discount, amount: amount);
}
