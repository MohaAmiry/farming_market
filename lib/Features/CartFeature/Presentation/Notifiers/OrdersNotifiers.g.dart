// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrdersNotifiers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dealerCustomerOrdersHistoryHash() =>
    r'b346fb14ca0832409d5836b893e2653bcbd18ad4';

/// See also [dealerCustomerOrdersHistory].
@ProviderFor(dealerCustomerOrdersHistory)
final dealerCustomerOrdersHistoryProvider =
    AutoDisposeFutureProvider<IList<Order>>.internal(
  dealerCustomerOrdersHistory,
  name: r'dealerCustomerOrdersHistoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dealerCustomerOrdersHistoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DealerCustomerOrdersHistoryRef
    = AutoDisposeFutureProviderRef<IList<Order>>;
String _$dealerCustomerOrdersHash() =>
    r'e2164ecd84fc69a0e2361c41fe6a207047d0b674';

/// See also [DealerCustomerOrders].
@ProviderFor(DealerCustomerOrders)
final dealerCustomerOrdersProvider = AutoDisposeStreamNotifierProvider<
    DealerCustomerOrders, IList<Order>>.internal(
  DealerCustomerOrders.new,
  name: r'dealerCustomerOrdersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dealerCustomerOrdersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DealerCustomerOrders = AutoDisposeStreamNotifier<IList<Order>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
