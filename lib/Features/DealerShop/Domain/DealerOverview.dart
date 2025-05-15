import 'package:dart_mappable/dart_mappable.dart';
import 'package:farming_market/Features/AuthenticationFeature/Domain/User/UserRole.dart';

part 'DealerOverview.mapper.dart';

@MappableClass()
class DealerOverview with DealerOverviewMappable {
  final String dealerId;
  final String dealerName;

  const DealerOverview({required this.dealerId, required this.dealerName});

  static const fromMap = DealerOverviewMapper.fromMap;

  factory DealerOverview.fromDealer(Dealer dealer) =>
      DealerOverview(dealerId: dealer.user!.uid, dealerName: dealer.name);
}
