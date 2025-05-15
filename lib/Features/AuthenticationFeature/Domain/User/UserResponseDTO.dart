import 'package:dart_mappable/dart_mappable.dart';

import 'UserRole.dart';

part 'UserResponseDTO.mapper.dart';

@MappableClass()
class UserResponseDTO with UserResponseDTOMappable {
  final String userId;
  final String email;
  final String password;
  final String name;
  final String? phoneNumber;
  final String? address;
  final UserRoleEnum userRole;

  const UserResponseDTO(
      {required this.userId,
      required this.email,
      this.phoneNumber,
      this.address,
      required this.password,
      required this.name,
      required this.userRole});

  factory UserResponseDTO.empty() => const UserResponseDTO(
      userId: "",
      email: "",
      password: "",
      name: "",
      userRole: UserRoleEnum.customer);

  static const fromMap = UserResponseDTOMapper.fromMap;

  static get firebaseUserRole => "userRole";

  static get firebaseName => "name";
}

@MappableClass()
class CustomerOrderData with CustomerOrderDataMappable {
  final String name;
  final String? phoneNumber;
  final String? address;

  const CustomerOrderData(
      {required this.name, required this.phoneNumber, required this.address});
}
