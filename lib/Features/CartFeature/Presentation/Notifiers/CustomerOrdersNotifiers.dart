import 'package:farming_market/Features/AuthenticationFeature/Data/Repositories/AuthController.dart';
import 'package:farming_market/Features/_SharedData/AbstractDataRepository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../Domain/Order.dart';

part 'CustomerOrdersNotifiers.g.dart';

@riverpod
Future<List<Order>> customerOrdersHistory(
    CustomerOrdersHistoryRef ref, bool isResolved) async {
  return ref
      .read(repositoryClientProvider)
      .ordersRepository
      .customerOrdersHistory(
          ref.read(authControllerProvider).requireValue!.user!.uid, isResolved);
}
