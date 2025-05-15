import 'package:cloud_firestore/cloud_firestore.dart' as CF;
import 'package:farming_market/Features/CartFeature/Domain/Order.dart';
import 'package:farming_market/Features/DealerShop/Domain/Product.dart';
import 'package:farming_market/Features/_SharedData/AbstractDataRepository.dart';
import 'package:farming_market/utils/FirebaseConstants.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrdersRepository extends AbstractRepository {
  final Ref ref;

  OrdersRepository({required this.ref});

  Stream<IList<Order>> dealerCustomersOrdersStream(String dealerId) =>
      firebaseFireStore
          .collection(FirebaseConstants.ordersCollection)
          .where(OrderDTO.firebaseDealerId, isEqualTo: dealerId)
          .where(OrderDTO.firebaseState, isNull: true)
          .snapshots()
          .asyncMap(
        (event) async {
          var ordersDTO = event.docs.map((e) => OrderDTO.fromMap(e.data()));
          var dealersOverviews = ref
              .read(repositoryClientProvider)
              .dealerRepository
              .getDealersOverviewsById(
                  ordersDTO.map((e) => e.dealerId).toList());
          var customers = ordersDTO
              .map((e) => ref
                  .read(repositoryClientProvider)
                  .authRepository
                  .getCustomerInfoById(e.customerId))
              .wait;
          var products = ordersDTO
              .map((order) => order.products
                  .map((product) => ref
                      .read(repositoryClientProvider)
                      .productsRepository
                      .getProductDTOById(product.productId))
                  .wait)
              .wait;

          var waitedDealersOverviews = await dealersOverviews;
          var waitedCustomers = await customers;
          var waitedProduct = await products;

          return ordersDTO
              .mapIndexedAndLast((index, item, isLast) => item.toOrder(
                  dealerOverview: waitedDealersOverviews.elementAt(index),
                  customerInfo: waitedCustomers.elementAt(index),
                  fetchedProducts: waitedProduct.elementAt(index)))
              .toIList();
        },
      );

  Future<IList<Order>> dealerCustomersOrdersHistory(String dealerId) async =>
      (await (await firebaseFireStore
                  .collection(FirebaseConstants.ordersCollection)
                  .where(OrderDTO.firebaseDealerId, isEqualTo: dealerId)
                  .where(OrderDTO.firebaseState, isNull: false)
                  .get())
              .docs
              .map((e) async {
        var orderDTO = OrderDTO.fromMap(e.data());
        var dealersOverviews = ref
            .read(repositoryClientProvider)
            .dealerRepository
            .getDealersOverviewsById([orderDTO.dealerId]);
        var customer = ref
            .read(repositoryClientProvider)
            .authRepository
            .getCustomerInfoById(orderDTO.customerId);

        var products = await orderDTO.products
            .map((product) => ref
                .read(repositoryClientProvider)
                .productsRepository
                .getProductDTOById(product.productId))
            .wait;

        return orderDTO.toOrder(
            dealerOverview: (await dealersOverviews).elementAt(0),
            customerInfo: await customer,
            fetchedProducts: products);
      }).wait)
          .toIList();

  Future<bool> setOrderState(bool state, Order order) async {
    firebaseFireStore
        .collection(FirebaseConstants.ordersCollection)
        .doc(order.orderId)
        .update({OrderDTO.firebaseState: state});
    if (!state) {
      try {
        await order.products
            .map((e) => firebaseFireStore
                    .collection(FirebaseConstants.productsCollection)
                    .doc(e.product.productId)
                    .update({
                  ProductDTO.firebaseInStock: CF.FieldValue.increment(e.amount)
                }))
            .wait;
      } catch (e, stk) {
        print(e);
      }
    }
    return true;
  }

  Future<List<Order>> customerOrdersHistory(
      String customerId, bool isResolved) async {
    var customer = ref
        .read(repositoryClientProvider)
        .authRepository
        .getCustomerInfoById(customerId);
    return (await (await firebaseFireStore
                .collection(FirebaseConstants.ordersCollection)
                .where(OrderDTO.firebaseCustomerId, isEqualTo: customerId)
                .get())
            .docs
            .map((e) async {
      var orderDTO = OrderDTO.fromMap(e.data());
      var dealersOverviews = ref
          .read(repositoryClientProvider)
          .dealerRepository
          .getDealersOverviewsById([orderDTO.dealerId]);

      var products = await orderDTO.products
          .map((product) => ref
              .read(repositoryClientProvider)
              .productsRepository
              .getProductDTOById(product.productId))
          .wait;
      return orderDTO.toOrder(
          dealerOverview: (await dealersOverviews).elementAt(0),
          customerInfo: await customer,
          fetchedProducts: products);
    }).wait)
        .where((element) =>
            isResolved ? element.state != null : element.state == null)
        .toList();
  }
}
