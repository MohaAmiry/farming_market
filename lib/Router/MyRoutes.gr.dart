// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i18;
import 'package:farming_market/Features/AuthenticationFeature/Domain/User/UserResponseDTO.dart'
    as _i22;
import 'package:farming_market/Features/AuthenticationFeature/Presentation/EditProfileView.dart'
    as _i11;
import 'package:farming_market/Features/AuthenticationFeature/Presentation/LoginView.dart'
    as _i12;
import 'package:farming_market/Features/AuthenticationFeature/Presentation/ProfileView.dart'
    as _i13;
import 'package:farming_market/Features/AuthenticationFeature/Presentation/RegisterAsCustomerView.dart'
    as _i14;
import 'package:farming_market/Features/AuthenticationFeature/Presentation/RegisterAsDealerView.dart'
    as _i15;
import 'package:farming_market/Features/CartFeature/Domain/Order.dart' as _i20;
import 'package:farming_market/Features/CartFeature/Presentation/CartView.dart'
    as _i3;
import 'package:farming_market/Features/CartFeature/Presentation/CustomerActiveOrdersView.dart'
    as _i5;
import 'package:farming_market/Features/CartFeature/Presentation/CustomerOrdersHistoryView.dart'
    as _i6;
import 'package:farming_market/Features/CartFeature/Presentation/DealerAllOrdersView.dart'
    as _i7;
import 'package:farming_market/Features/CartFeature/Presentation/DealerCustomerSingleOrderView.dart'
    as _i8;
import 'package:farming_market/Features/CartFeature/Presentation/DealerOrdersHistoryView.dart'
    as _i9;
import 'package:farming_market/Features/ChatFeature/Presentation/ChatView.dart'
    as _i4;
import 'package:farming_market/Features/DealerShop/Domain/DealerOverview.dart'
    as _i23;
import 'package:farming_market/Features/DealerShop/Domain/Product.dart' as _i21;
import 'package:farming_market/Features/DealerShop/Presentation/AddProductView.dart'
    as _i1;
import 'package:farming_market/Features/DealerShop/Presentation/AllDealersOverviewView.dart'
    as _i2;
import 'package:farming_market/Features/DealerShop/Presentation/EditProductView.dart'
    as _i10;
import 'package:farming_market/Features/DealerShop/Presentation/SingleDealerShopView.dart'
    as _i16;
import 'package:farming_market/Features/SplashFeature/SplashView.dart' as _i17;
import 'package:flutter/material.dart' as _i19;

/// generated route for
/// [_i1.AddProductView]
class AddProductRoute extends _i18.PageRouteInfo<void> {
  const AddProductRoute({List<_i18.PageRouteInfo>? children})
      : super(
          AddProductRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddProductRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i1.AddProductView();
    },
  );
}

/// generated route for
/// [_i2.AllDealersOverviewView]
class AllDealersOverviewRoute extends _i18.PageRouteInfo<void> {
  const AllDealersOverviewRoute({List<_i18.PageRouteInfo>? children})
      : super(
          AllDealersOverviewRoute.name,
          initialChildren: children,
        );

  static const String name = 'AllDealersOverviewRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i2.AllDealersOverviewView();
    },
  );
}

/// generated route for
/// [_i3.CartView]
class CartRoute extends _i18.PageRouteInfo<void> {
  const CartRoute({List<_i18.PageRouteInfo>? children})
      : super(
          CartRoute.name,
          initialChildren: children,
        );

  static const String name = 'CartRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i3.CartView();
    },
  );
}

/// generated route for
/// [_i4.ChatView]
class ChatRoute extends _i18.PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    _i19.Key? key,
    required String otherID,
    required String otherName,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          ChatRoute.name,
          args: ChatRouteArgs(
            key: key,
            otherID: otherID,
            otherName: otherName,
          ),
          initialChildren: children,
        );

  static const String name = 'ChatRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChatRouteArgs>();
      return _i4.ChatView(
        key: args.key,
        otherID: args.otherID,
        otherName: args.otherName,
      );
    },
  );
}

class ChatRouteArgs {
  const ChatRouteArgs({
    this.key,
    required this.otherID,
    required this.otherName,
  });

  final _i19.Key? key;

  final String otherID;

  final String otherName;

  @override
  String toString() {
    return 'ChatRouteArgs{key: $key, otherID: $otherID, otherName: $otherName}';
  }
}

/// generated route for
/// [_i5.CustomerActiveOrdersView]
class CustomerActiveOrdersRoute extends _i18.PageRouteInfo<void> {
  const CustomerActiveOrdersRoute({List<_i18.PageRouteInfo>? children})
      : super(
          CustomerActiveOrdersRoute.name,
          initialChildren: children,
        );

  static const String name = 'CustomerActiveOrdersRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i5.CustomerActiveOrdersView();
    },
  );
}

/// generated route for
/// [_i6.CustomerOrdersHistoryView]
class CustomerOrdersHistoryRoute extends _i18.PageRouteInfo<void> {
  const CustomerOrdersHistoryRoute({List<_i18.PageRouteInfo>? children})
      : super(
          CustomerOrdersHistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'CustomerOrdersHistoryRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i6.CustomerOrdersHistoryView();
    },
  );
}

/// generated route for
/// [_i7.DealerAllOrdersView]
class DealerAllOrdersRoute extends _i18.PageRouteInfo<void> {
  const DealerAllOrdersRoute({List<_i18.PageRouteInfo>? children})
      : super(
          DealerAllOrdersRoute.name,
          initialChildren: children,
        );

  static const String name = 'DealerAllOrdersRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i7.DealerAllOrdersView();
    },
  );
}

/// generated route for
/// [_i8.DealerCustomerSingleOrderView]
class DealerCustomerSingleOrderRoute
    extends _i18.PageRouteInfo<DealerCustomerSingleOrderRouteArgs> {
  DealerCustomerSingleOrderRoute({
    _i19.Key? key,
    required _i20.Order order,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          DealerCustomerSingleOrderRoute.name,
          args: DealerCustomerSingleOrderRouteArgs(
            key: key,
            order: order,
          ),
          initialChildren: children,
        );

  static const String name = 'DealerCustomerSingleOrderRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DealerCustomerSingleOrderRouteArgs>();
      return _i8.DealerCustomerSingleOrderView(
        key: args.key,
        order: args.order,
      );
    },
  );
}

class DealerCustomerSingleOrderRouteArgs {
  const DealerCustomerSingleOrderRouteArgs({
    this.key,
    required this.order,
  });

  final _i19.Key? key;

  final _i20.Order order;

  @override
  String toString() {
    return 'DealerCustomerSingleOrderRouteArgs{key: $key, order: $order}';
  }
}

/// generated route for
/// [_i9.DealerOrdersHistoryView]
class DealerOrdersHistoryRoute extends _i18.PageRouteInfo<void> {
  const DealerOrdersHistoryRoute({List<_i18.PageRouteInfo>? children})
      : super(
          DealerOrdersHistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'DealerOrdersHistoryRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i9.DealerOrdersHistoryView();
    },
  );
}

/// generated route for
/// [_i10.EditProductView]
class EditProductRoute extends _i18.PageRouteInfo<EditProductRouteArgs> {
  EditProductRoute({
    _i19.Key? key,
    required _i21.ProductDTO productDTO,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          EditProductRoute.name,
          args: EditProductRouteArgs(
            key: key,
            productDTO: productDTO,
          ),
          initialChildren: children,
        );

  static const String name = 'EditProductRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditProductRouteArgs>();
      return _i10.EditProductView(
        key: args.key,
        productDTO: args.productDTO,
      );
    },
  );
}

class EditProductRouteArgs {
  const EditProductRouteArgs({
    this.key,
    required this.productDTO,
  });

  final _i19.Key? key;

  final _i21.ProductDTO productDTO;

  @override
  String toString() {
    return 'EditProductRouteArgs{key: $key, productDTO: $productDTO}';
  }
}

/// generated route for
/// [_i11.EditProfileView]
class EditProfileRoute extends _i18.PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({
    _i19.Key? key,
    required _i22.UserResponseDTO userResponseDTO,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          EditProfileRoute.name,
          args: EditProfileRouteArgs(
            key: key,
            userResponseDTO: userResponseDTO,
          ),
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditProfileRouteArgs>();
      return _i11.EditProfileView(
        key: args.key,
        userResponseDTO: args.userResponseDTO,
      );
    },
  );
}

class EditProfileRouteArgs {
  const EditProfileRouteArgs({
    this.key,
    required this.userResponseDTO,
  });

  final _i19.Key? key;

  final _i22.UserResponseDTO userResponseDTO;

  @override
  String toString() {
    return 'EditProfileRouteArgs{key: $key, userResponseDTO: $userResponseDTO}';
  }
}

/// generated route for
/// [_i12.LoginView]
class LoginRoute extends _i18.PageRouteInfo<void> {
  const LoginRoute({List<_i18.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i12.LoginView();
    },
  );
}

/// generated route for
/// [_i13.ProfileView]
class ProfileRoute extends _i18.PageRouteInfo<void> {
  const ProfileRoute({List<_i18.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i13.ProfileView();
    },
  );
}

/// generated route for
/// [_i14.RegisterAsCustomerView]
class RegisterAsCustomerRoute extends _i18.PageRouteInfo<void> {
  const RegisterAsCustomerRoute({List<_i18.PageRouteInfo>? children})
      : super(
          RegisterAsCustomerRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterAsCustomerRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i14.RegisterAsCustomerView();
    },
  );
}

/// generated route for
/// [_i15.RegisterAsDealerView]
class RegisterAsDealerRoute extends _i18.PageRouteInfo<void> {
  const RegisterAsDealerRoute({List<_i18.PageRouteInfo>? children})
      : super(
          RegisterAsDealerRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterAsDealerRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i15.RegisterAsDealerView();
    },
  );
}

/// generated route for
/// [_i16.SingleDealerShopView]
class SingleDealerShopRoute
    extends _i18.PageRouteInfo<SingleDealerShopRouteArgs> {
  SingleDealerShopRoute({
    _i19.Key? key,
    required _i23.DealerOverview dealerOverview,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          SingleDealerShopRoute.name,
          args: SingleDealerShopRouteArgs(
            key: key,
            dealerOverview: dealerOverview,
          ),
          initialChildren: children,
        );

  static const String name = 'SingleDealerShopRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SingleDealerShopRouteArgs>();
      return _i16.SingleDealerShopView(
        key: args.key,
        dealerOverview: args.dealerOverview,
      );
    },
  );
}

class SingleDealerShopRouteArgs {
  const SingleDealerShopRouteArgs({
    this.key,
    required this.dealerOverview,
  });

  final _i19.Key? key;

  final _i23.DealerOverview dealerOverview;

  @override
  String toString() {
    return 'SingleDealerShopRouteArgs{key: $key, dealerOverview: $dealerOverview}';
  }
}

/// generated route for
/// [_i17.SplashView]
class SplashRoute extends _i18.PageRouteInfo<void> {
  const SplashRoute({List<_i18.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i17.SplashView();
    },
  );
}
