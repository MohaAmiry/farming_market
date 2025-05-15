import 'dart:io';

import 'package:farming_market/Features/DealerShop/Domain/Product.dart';
import 'package:farming_market/Features/_SharedData/AbstractDataRepository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/FirebaseConstants.dart';

class ProductsRepository extends AbstractRepository {
  final Ref ref;

  ProductsRepository({required this.ref});

  Future<bool> addProduct(ProductDTO product) async {
    var result = await firebaseFireStore
        .collection(FirebaseConstants.productsCollection)
        .add(product.toMap());
    result.update({ProductDTO.firebaseProductId: result.id});

    if (product.images.isEmpty) return true;
    try {
      var storageRef = firebaseStorage.ref();
      List<UploadTask> tasks = [];
      for (int i = 0; i < product.images.length; i++) {
        tasks.add(storageRef
            .child("${result.id}/$i")
            .putFile(File(product.images.elementAt(i))));
      }
      var res = await tasks.wait;
      var urls = res.map((e) => e.ref.getDownloadURL());
      await firebaseFireStore
          .collection(FirebaseConstants.productsCollection)
          .doc(result.id)
          .update({ProductDTO.firebaseImagesLink: (await urls.wait)});

      return true;
    } catch (e, stk) {
      await firebaseFireStore
          .collection(FirebaseConstants.productsCollection)
          .doc(result.id)
          .delete();
      rethrow;
    }
  }

  Future<bool> updateProduct(ProductDTO product) async {
    var postRef = await firebaseFireStore
        .collection(FirebaseConstants.productsCollection)
        .doc(product.productId);

    postRef.update(product.toMap()..remove(ProductDTO.firebaseImagesLink));

    if (product.images.isEmpty) return true;
    try {
      var storageRef = firebaseStorage.ref().child(product.productId);

      await storageRef.listAll().then(
            (value) => value.items.forEach(
              (element) async {
                await element.delete();
              },
            ),
          );

      List<UploadTask> tasks = [];
      for (int i = 0; i < product.images.length; i++) {
        tasks.add(storageRef
            .child("${product.productId}/$i")
            .putFile(File(product.images.elementAt(i))));
      }
      var res = await tasks.wait;
      var urls = res.map((e) => e.ref.getDownloadURL());
      await firebaseFireStore
          .collection(FirebaseConstants.productsCollection)
          .doc(product.productId)
          .update({ProductDTO.firebaseImagesLink: (await urls.wait)});

      return true;
    } catch (e, stk) {
      rethrow;
    }
  }

  Future<bool> removeProduct(String productId) async {
    await firebaseFireStore
        .collection(FirebaseConstants.productsCollection)
        .doc(productId)
        .update({ProductDTO.firebaseIsDeleted: true});

    return true;
  }

  Future<ProductDTO> getProductDTOById(String id) async =>
      ProductDTO.fromMap((await firebaseFireStore
              .collection(FirebaseConstants.productsCollection)
              .doc(id)
              .get())
          .data()!);
}
