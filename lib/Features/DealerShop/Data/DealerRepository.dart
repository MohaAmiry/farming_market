import 'package:farming_market/Features/AuthenticationFeature/Domain/User/UserResponseDTO.dart';
import 'package:farming_market/Features/AuthenticationFeature/Domain/User/UserRole.dart';
import 'package:farming_market/Features/DealerShop/Domain/DealerOverview.dart';
import 'package:farming_market/Features/DealerShop/Domain/Product.dart';
import 'package:farming_market/Features/_SharedData/AbstractDataRepository.dart';
import 'package:farming_market/utils/FirebaseConstants.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DealerRepository extends AbstractRepository {
  final Ref ref;

  DealerRepository({required this.ref});

  Stream<Iterable<ProductDTO>> _getDealerProductsDTOs(String dealerId) {
    return firebaseFireStore
        .collection(FirebaseConstants.productsCollection)
        .where(ProductDTO.firebaseDealerOverview, isEqualTo: dealerId)
        .snapshots()
        .asyncMap(
            (event) => event.docs.map((e) => ProductDTO.fromMap(e.data())));
  }

  Stream<IList<Product>> getDealerProducts(DealerOverview dealerOverview) {
    var dealerProductsDTO = _getDealerProductsDTOs(dealerOverview.dealerId);
    return dealerProductsDTO.asyncMap((event) => event
        .map((e) => e.toProduct(dealerOverview))
        .where((element) => !element.isDeleted)
        .toIList());
  }

  Stream<List<DealerOverview>> getDealersOverviews() {
    return firebaseFireStore
        .collection(FirebaseConstants.usersCollection)
        .where(UserResponseDTO.firebaseUserRole,
            isEqualTo: UserRoleEnum.dealer.toValue())
        .snapshots()
        .asyncMap((event) {
      return event.docs.map((e) {
        var dealer = UserResponseDTO.fromMap(e.data());
        return DealerOverview(dealerId: e.id, dealerName: dealer.name);
      }).toList();
    });
  }

  Future<DealerOverview> getDealerOverviewById(String dealerId) async {
    var result = UserResponseDTO.fromMap((await firebaseFireStore
            .collection(FirebaseConstants.usersCollection)
            .doc(dealerId)
            .get())
        .data()!);
    return DealerOverview(dealerId: dealerId, dealerName: result.name);
  }

  Future<List<DealerOverview>> getDealersOverviewsById(List<String> ids) async {
    return ids.map((element) => getDealerOverviewById(element)).toList().wait;
  }
}
