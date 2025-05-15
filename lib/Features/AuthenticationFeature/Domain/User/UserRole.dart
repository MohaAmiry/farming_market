import 'package:dart_mappable/dart_mappable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'UserRole.mapper.dart';

@MappableEnum()
enum UserRoleEnum { admin, customer, dealer }

@MappableClass()
sealed class UserRole with UserRoleMappable {
  final User? user;
  final String name;
  final String email;
  final String password;

  const UserRole(
      {this.user,
      required this.name,
      required this.email,
      required this.password});

  @override
  String toString() {
    return 'Customer{user: $user, name: $name, email: $email, password: $password}';
  }
}

@MappableClass()
class Admin extends UserRole with AdminMappable {
  const Admin(
      {super.user,
      required super.name,
      required super.email,
      required super.password});

  static const fromMap = AdminMapper.fromMap;
}

@MappableClass()
class Customer extends UserRole with CustomerMappable {
  final String address;
  final String phoneNumber;

  const Customer(
      {super.user,
      required super.name,
      required super.email,
      required super.password,
      required this.address,
      required this.phoneNumber});

  static const fromMap = CustomerMapper.fromMap;
}

@MappableClass()
class Dealer extends UserRole with DealerMappable {
  const Dealer(
      {super.user,
      required super.name,
      required super.email,
      required super.password});

  static const fromMap = DealerMapper.fromMap;
}
