import 'package:adminapp/core/constatnts/firebase_constants.dart';
import 'package:adminapp/core/providers/firebase_providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/store_category.dart';

final storeRepositoryProvider = Provider<StoreRepository>((ref) {
  return StoreRepository(firestore: ref.watch(firestoreProvider));
});

class StoreRepository {
  final FirebaseFirestore _firestore;
  StoreRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Stream<List<StoreCategoryModel>> getStoreCategories(
      {required bool category}) {
    return _storeCategory.where("kit", isEqualTo: category).snapshots().map(
        (event) => event.docs
            .map((e) =>
                StoreCategoryModel.fromJson(e.data() as Map<String, dynamic>))
            .toList());
  }

  CollectionReference get _storeCategory =>
      _firestore.collection(FirebaseConstants.storeCategory);
}
