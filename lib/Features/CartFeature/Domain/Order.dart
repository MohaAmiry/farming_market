import 'package:dart_mappable/dart_mappable.dart';
import 'package:farming_market/Features/AuthenticationFeature/Domain/User/UserResponseDTO.dart';
import 'package:farming_market/Features/DealerShop/Domain/DealerOverview.dart';
import 'package:farming_market/Features/DealerShop/Domain/Product.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'CartProduct.dart';

part 'Order.mapper.dart';

@MappableClass()
class OrderDTO with OrderDTOMappable {
  final String orderId;
  final DateTime orderTime;
  final String dealerId;
  final String customerId;
  final List<CartProductDTO> products;
  final bool takeFromStore;
  final bool? state;

  const OrderDTO(
      {required this.orderId,
      required this.orderTime,
      required this.dealerId,
      required this.customerId,
      required this.products,
      required this.takeFromStore,
      this.state});

  static const fromMap = OrderDTOMapper.fromMap;

  static get firebaseOrderId => "orderId";

  static get firebaseState => "state";

  static get firebaseDealerId => "dealerId";

  static get firebaseCustomerId => "customerId";

  Order toOrder(
          {required DealerOverview dealerOverview,
          required List<ProductDTO> fetchedProducts,
          required UserResponseDTO customerInfo}) =>
      Order(
          state: state,
          orderId: orderId,
          orderTime: orderTime,
          takeFromStore: takeFromStore,
          dealerOverview: dealerOverview,
          customerInfo: customerInfo,
          products: products
              .mapIndexedAndLast((index, item, isLast) =>
                  item.toCartProductWithDealerOverview(
                      fetchedProducts.elementAt(index), dealerOverview))
              .toList());
}

@MappableClass()
class Order with OrderMappable {
  final String orderId;
  final DateTime orderTime;
  final DealerOverview dealerOverview;
  final UserResponseDTO customerInfo;
  final List<CartProduct> products;
  final bool takeFromStore;
  final bool? state;

  String get deliveryString => takeFromStore ? "اخذ من المتجر" : "توصيل";

  String get stateString => state == null
      ? "قيد الانتظار"
      : state!
          ? "تم القبول"
          : "تم الرفض";

  double get totalRaw => products.fold(
      0.0, (previousValue, element) => previousValue + element.totalRaw);

  double get totalWithDiscount => products.fold(0.0,
      (previousValue, element) => previousValue + element.totalWithDiscount);

  String getOtherId(String currentId) => currentId == dealerOverview.dealerId
      ? customerInfo.userId
      : dealerOverview.dealerId;

  String getOtherName(String currentName) =>
      currentName == dealerOverview.dealerName
          ? customerInfo.name
          : dealerOverview.dealerName;

  const Order(
      {required this.orderId,
      required this.takeFromStore,
      required this.orderTime,
      required this.dealerOverview,
      required this.customerInfo,
      required this.products,
      this.state});
}
