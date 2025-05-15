import 'package:dart_mappable/dart_mappable.dart';
import 'package:farming_market/Features/CartFeature/Domain/CartProduct.dart';
import 'package:farming_market/Features/DealerShop/Domain/DealerOverview.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

part 'Product.mapper.dart';

@MappableClass()
class ProductDTO with ProductDTOMappable {
  final String productId;
  final String name;
  final double price;
  final String dealerOverview;
  final IList<String> images;
  final int inStock;
  final double discount;
  final bool isDeleted;

  const ProductDTO(
      {required this.productId,
      required this.discount,
      required this.name,
      required this.price,
      required this.dealerOverview,
      required this.images,
      required this.inStock,
      required this.isDeleted});

  double get discountPercent => discount * 100;

  static const fromMap = ProductDTOMapper.fromMap;

  static String get firebaseProductId => "productId";

  static String get firebaseImagesLink => "images";

  static String get firebaseDealerOverview => "dealerOverview";

  static String get firebaseInStock => "inStock";

  static String get firebaseIsDeleted => "isDeleted";

  factory ProductDTO.empty() => ProductDTO(
      discount: 0,
      productId: "",
      name: "",
      price: -1,
      dealerOverview: "",
      images: IList(),
      inStock: -1,
      isDeleted: false);

  factory ProductDTO.withDealerOverview(String dealerIdOverview) => ProductDTO(
      discount: 0,
      productId: "",
      name: "",
      price: -1,
      dealerOverview: dealerIdOverview,
      images: IList(),
      inStock: -1,
      isDeleted: false);

  Product toProduct(DealerOverview dealerOverview) => Product(
      discount: discount,
      productId: productId,
      name: name,
      price: price,
      dealerOverview: dealerOverview,
      images: images,
      inStock: inStock,
      isDeleted: isDeleted);
}

@MappableClass()
class Product with ProductMappable {
  final String productId;
  final String name;
  final DealerOverview dealerOverview;
  final double price;
  final IList<String> images;
  final int inStock;
  final double discount;
  final bool isDeleted;

  double get priceAfterDiscount => price * (1 - discount);

  bool get stocked => inStock > 0;

  const Product(
      {required this.productId,
      required this.name,
      required this.price,
      required this.dealerOverview,
      required this.images,
      required this.inStock,
      required this.discount,
      required this.isDeleted});

  static const fromMap = ProductMapper.fromMap;

  factory Product.fromDTO(Product product, DealerOverview dealerOverview) =>
      Product(
          discount: product.discount,
          productId: product.productId,
          name: product.name,
          price: product.price,
          dealerOverview: dealerOverview,
          images: product.images,
          inStock: product.inStock,
          isDeleted: product.isDeleted);

  CartProduct toCartProductWithDealerOverview(int amount) =>
      CartProduct(product: this, discount: discount, amount: amount);

  ProductDTO toDTO() => ProductDTO(
      discount: discount,
      productId: productId,
      name: name,
      price: price,
      dealerOverview: dealerOverview.dealerId,
      images: images,
      inStock: inStock,
      isDeleted: isDeleted);
}
