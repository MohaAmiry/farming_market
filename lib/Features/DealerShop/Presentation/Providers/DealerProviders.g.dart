// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DealerProviders.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allDealersOverviewHash() =>
    r'0a8bb209db9784dff3925d1ba6c28b53915457f0';

/// See also [allDealersOverview].
@ProviderFor(allDealersOverview)
final allDealersOverviewProvider =
    AutoDisposeStreamProvider<List<DealerOverview>>.internal(
  allDealersOverview,
  name: r'allDealersOverviewProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$allDealersOverviewHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AllDealersOverviewRef
    = AutoDisposeStreamProviderRef<List<DealerOverview>>;
String _$dealerAllProductsHash() => r'b6f238c60c717a77a000ba22dad33e6d447bcfe9';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [dealerAllProducts].
@ProviderFor(dealerAllProducts)
const dealerAllProductsProvider = DealerAllProductsFamily();

/// See also [dealerAllProducts].
class DealerAllProductsFamily extends Family<AsyncValue<IList<Product>>> {
  /// See also [dealerAllProducts].
  const DealerAllProductsFamily();

  /// See also [dealerAllProducts].
  DealerAllProductsProvider call(
    DealerOverview dealerOverview,
  ) {
    return DealerAllProductsProvider(
      dealerOverview,
    );
  }

  @override
  DealerAllProductsProvider getProviderOverride(
    covariant DealerAllProductsProvider provider,
  ) {
    return call(
      provider.dealerOverview,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'dealerAllProductsProvider';
}

/// See also [dealerAllProducts].
class DealerAllProductsProvider
    extends AutoDisposeStreamProvider<IList<Product>> {
  /// See also [dealerAllProducts].
  DealerAllProductsProvider(
    DealerOverview dealerOverview,
  ) : this._internal(
          (ref) => dealerAllProducts(
            ref as DealerAllProductsRef,
            dealerOverview,
          ),
          from: dealerAllProductsProvider,
          name: r'dealerAllProductsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dealerAllProductsHash,
          dependencies: DealerAllProductsFamily._dependencies,
          allTransitiveDependencies:
              DealerAllProductsFamily._allTransitiveDependencies,
          dealerOverview: dealerOverview,
        );

  DealerAllProductsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.dealerOverview,
  }) : super.internal();

  final DealerOverview dealerOverview;

  @override
  Override overrideWith(
    Stream<IList<Product>> Function(DealerAllProductsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DealerAllProductsProvider._internal(
        (ref) => create(ref as DealerAllProductsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        dealerOverview: dealerOverview,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<IList<Product>> createElement() {
    return _DealerAllProductsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DealerAllProductsProvider &&
        other.dealerOverview == dealerOverview;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, dealerOverview.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DealerAllProductsRef on AutoDisposeStreamProviderRef<IList<Product>> {
  /// The parameter `dealerOverview` of this provider.
  DealerOverview get dealerOverview;
}

class _DealerAllProductsProviderElement
    extends AutoDisposeStreamProviderElement<IList<Product>>
    with DealerAllProductsRef {
  _DealerAllProductsProviderElement(super.provider);

  @override
  DealerOverview get dealerOverview =>
      (origin as DealerAllProductsProvider).dealerOverview;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
