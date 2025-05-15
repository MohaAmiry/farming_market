// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SharedPrefProvider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sharedPrefHash() => r'4dba1e32f5e8d0a7478fd116b94c8e572106f168';

/// See also [sharedPref].
@ProviderFor(sharedPref)
final sharedPrefProvider = FutureProvider<SharedPreferences>.internal(
  sharedPref,
  name: r'sharedPrefProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$sharedPrefHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SharedPrefRef = FutureProviderRef<SharedPreferences>;
String _$firstTimeHash() => r'e480461d5e42d724ff94bd61b7fd14f9937f9e44';

/// See also [firstTime].
@ProviderFor(firstTime)
final firstTimeProvider = AutoDisposeFutureProvider<bool>.internal(
  firstTime,
  name: r'firstTimeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$firstTimeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FirstTimeRef = AutoDisposeFutureProviderRef<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
