import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farming_market/Features/CartFeature/Data/OrdersRepository.dart';
import 'package:farming_market/Features/ChatFeature/Data/Repositories/ChatRepository.dart';
import 'package:farming_market/Features/DealerShop/Data/DealerRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../AuthenticationFeature/Data/Repositories/AuthRepository.dart';
import '../CartFeature/Data/CartRepository.dart';
import '../DealerShop/Data/ProductRepository.dart';

part 'AbstractDataRepository.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(ref);
}

@Riverpod(keepAlive: true)
ProductsRepository productsRepository(ProductsRepositoryRef ref) {
  return ProductsRepository(ref: ref);
}

@Riverpod(keepAlive: true)
DealerRepository dealersRepository(DealersRepositoryRef ref) {
  return DealerRepository(ref: ref);
}

@Riverpod(keepAlive: true)
CartRepository cartRepository(CartRepositoryRef ref) {
  return CartRepository(ref: ref);
}

@Riverpod(keepAlive: true)
OrdersRepository ordersRepository(OrdersRepositoryRef ref) {
  return OrdersRepository(ref: ref);
}

@Riverpod(keepAlive: true)
ChatRepository chatRepository(ChatRepositoryRef ref) {
  return ChatRepository(ref: ref);
}

@Riverpod(keepAlive: true)
_RepositoryClient repositoryClient(RepositoryClientRef ref) {
  return _RepositoryClient(
      authRepository: ref.read(authRepositoryProvider),
      dealerRepository: ref.read(dealersRepositoryProvider),
      productsRepository: ref.read(productsRepositoryProvider),
      cartRepository: ref.read(cartRepositoryProvider),
      ordersRepository: ref.read(ordersRepositoryProvider),
      chatRepository: ref.read(chatRepositoryProvider));
}

abstract class AbstractRepository {
  final FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
}

class _RepositoryClient {
  final AuthRepository authRepository;
  final DealerRepository dealerRepository;
  final ProductsRepository productsRepository;
  final CartRepository cartRepository;
  final OrdersRepository ordersRepository;
  final ChatRepository chatRepository;

  const _RepositoryClient(
      {required this.productsRepository,
      required this.dealerRepository,
      required this.authRepository,
      required this.cartRepository,
      required this.ordersRepository,
      required this.chatRepository});
}
