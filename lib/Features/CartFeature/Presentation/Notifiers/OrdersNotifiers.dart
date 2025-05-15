import 'package:farming_market/Features/AuthenticationFeature/Data/Repositories/AuthController.dart';
import 'package:farming_market/Features/_SharedData/AbstractDataRepository.dart';
import 'package:farming_market/utils/Extensions.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../Domain/Order.dart';

part 'OrdersNotifiers.g.dart';

@riverpod
class DealerCustomerOrders extends _$DealerCustomerOrders {
  @override
  Stream<IList<Order>> build() {
    return ref
        .read(repositoryClientProvider)
        .ordersRepository
        .dealerCustomersOrdersStream(
            ref.read(authControllerProvider).requireValue!.user!.uid);
  }

  Future<bool> setOrderState(bool state, Order order) async {
    var result = await ref.operationPipeLine(
        func: () => ref
            .read(repositoryClientProvider)
            .ordersRepository
            .setOrderState(state, order));
    if (result.hasError) return false;
    return true;
  }
}

@riverpod
Future<IList<Order>> dealerCustomerOrdersHistory(
    DealerCustomerOrdersHistoryRef ref) async {
  return ref
      .read(repositoryClientProvider)
      .ordersRepository
      .dealerCustomersOrdersHistory(
          ref.read(authControllerProvider).requireValue!.user!.uid);
}
