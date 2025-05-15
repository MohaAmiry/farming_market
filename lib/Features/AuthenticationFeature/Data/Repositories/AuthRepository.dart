import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/FirebaseConstants.dart';
import '../../../_SharedData/AbstractDataRepository.dart';
import '../../Domain/User/UserResponseDTO.dart';
import '../../Domain/User/UserRole.dart';
import '../RequestsModels/LoginRequest/LoginEntityRequest.dart';
import '../RequestsModels/RegisterRequestsModels/RegisterRequest.dart';

class AuthRepository extends AbstractRepository {
  final Ref ref;

  AuthRepository(this.ref);

  User? get getCurrentUser => FirebaseAuth.instance.currentUser;

  String get getCurrentUserID => getCurrentUser!.uid;

  Future<UserRole> signUp(RegisterRequest registerRequest) async {
    await firebaseAuth.signOut();
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: registerRequest.email, password: registerRequest.password);
      if (firebaseAuth.currentUser != null) {
        await getCurrentCustomerDoc().set(registerRequest
            .copyWith(userId: firebaseAuth.currentUser!.uid)
            .toMap());
      }
      switch (registerRequest.runtimeType) {
        case CustomerRegisterRequest:
          return Customer(
            user: firebaseAuth.currentUser!,
            name: registerRequest.name,
            address: (registerRequest as CustomerRegisterRequest).address,
            phoneNumber: (registerRequest).phoneNumber,
            email: registerRequest.email,
            password: registerRequest.password,
          );
        case RegisterRequest:
          return Dealer(
              user: firebaseAuth.currentUser!,
              name: registerRequest.name,
              email: registerRequest.email,
              password: registerRequest.password);
      }
      throw Exception("Can't Register Admin");
    } on Exception {
      rethrow;
    }
  }

  DocumentReference<Map<String, dynamic>> getCurrentCustomerDoc() =>
      FirebaseFirestore.instance
          .collection(FirebaseConstants.usersCollection)
          .doc(AuthRepository(ref).getCurrentUser!.uid);

  Future<void> createAdminUser() async {
    var req = const RegisterRequest(
        userId: "",
        name: "admin",
        email: "admin@admin.com",
        password: "1231231",
        userRole: UserRoleEnum.admin);
    await firebaseAuth.createUserWithEmailAndPassword(
        email: req.email, password: req.password);
    if (firebaseAuth.currentUser != null) {
      await getCurrentCustomerDoc().set(req.toMap());
    }
    await firebaseAuth.signOut();
  }

  Future<UserRole> signIn(LoginRequest loginReqModel) async {
    try {
      var userCredentials = (await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: loginReqModel.email, password: loginReqModel.password));
      if (userCredentials.user == null) {
        throw Exception("User is Null");
      }
      var userData = await getUserTypeDoc();

      return userData;
    } on Exception {
      rethrow;
    }
  }

  Future<UserResponseDTO> getCustomerInfoById(String customerId) async {
    return UserResponseDTO.fromMap((await firebaseFireStore
            .collection(FirebaseConstants.usersCollection)
            .doc(customerId)
            .get())
        .data()!);
  }

  Stream<UserResponseDTO> getUserInfoByIdStream(String customerId) {
    return firebaseFireStore
        .collection(FirebaseConstants.usersCollection)
        .doc(customerId)
        .snapshots()
        .asyncMap((event) => UserResponseDTO.fromMap(event.data()!));
  }

  Future<bool> updateUser(UserResponseDTO updatedInfo, String userId) async {
    await firebaseFireStore
        .collection(FirebaseConstants.usersCollection)
        .doc(userId)
        .update(updatedInfo.toMap());
    return true;
  }

  Future<void> signOut() async => await firebaseAuth.signOut();

  Future<UserRole> getUserTypeDoc() async {
    try {
      var userID = getCurrentUser?.uid ?? " ";
      if ((await FirebaseFirestore.instance
              .collection(FirebaseConstants.usersCollection)
              .doc(userID)
              .get())
          .exists) {
        var userData = UserResponseDTO.fromMap((await FirebaseFirestore.instance
                .collection(FirebaseConstants.usersCollection)
                .doc(userID)
                .get())
            .data()!);
        switch (userData.userRole) {
          case UserRoleEnum.admin:
            return Admin(
                user: getCurrentUser!,
                name: userData.name,
                email: userData.email,
                password: userData.password);
          case UserRoleEnum.customer:
            return Customer(
                user: getCurrentUser!,
                phoneNumber: userData.phoneNumber!,
                address: userData.address!,
                name: userData.name,
                email: userData.email,
                password: userData.password);
          case UserRoleEnum.dealer:
            return Dealer(
                user: getCurrentUser!,
                name: userData.name,
                email: userData.email,
                password: userData.password);
        }
      }
      throw Exception("User Document Does Not Exist");
    } on Exception {
      rethrow;
    }
  }

/*
  Future<CustomerInfo> getCustomerInfoById(String id) async {
    String name = (await firebaseFireStore
            .collection(firebaseConstants.userDataCollection)
            .doc(id)
            .get())
        .get(firebaseConstants.userName);

    return CustomerInfo(name: name, userId: id);
  }
  */
}
