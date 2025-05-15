import 'package:farming_market/Features/DealerShop/Domain/DealerOverview.dart';
import 'package:farming_market/Features/_SharedData/AbstractDataRepository.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../Domain/Product.dart';

part 'DealerProviders.g.dart';

@riverpod
Stream<List<DealerOverview>> allDealersOverview(AllDealersOverviewRef ref) {
  return ref
      .read(repositoryClientProvider)
      .dealerRepository
      .getDealersOverviews();
}

@riverpod
Stream<IList<Product>> dealerAllProducts(
    DealerAllProductsRef ref, DealerOverview dealerOverview) {
  return ref
      .read(repositoryClientProvider)
      .dealerRepository
      .getDealerProducts(dealerOverview);
}
