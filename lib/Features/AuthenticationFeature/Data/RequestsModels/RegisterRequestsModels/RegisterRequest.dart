import 'package:dart_mappable/dart_mappable.dart';

import '../../../Domain/User/UserRole.dart';

part 'RegisterRequest.mapper.dart';

@MappableClass()
class RegisterRequest with RegisterRequestMappable {
  final String userId;
  final String name;
  final String email;
  final String password;
  final UserRoleEnum userRole;

  const RegisterRequest(
      {required this.userId,
      required this.name,
      required this.email,
      required this.password,
      this.userRole = UserRoleEnum.dealer});
}

@MappableClass()
class CustomerRegisterRequest extends RegisterRequest
    with CustomerRegisterRequestMappable {
  final String address;
  final String phoneNumber;

  const CustomerRegisterRequest(
      {required super.userId,
      required super.name,
      required super.email,
      required super.password,
      required this.phoneNumber,
      required this.address,
      super.userRole = UserRoleEnum.customer});
}
