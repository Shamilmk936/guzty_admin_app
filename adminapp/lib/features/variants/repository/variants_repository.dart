import 'package:adminapp/core/constatnts/firebase_constants.dart';
import 'package:adminapp/core/providers/firebase_providers.dart';
import 'package:adminapp/model/variant_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final variantRepositoryProvider = Provider<variantRepository>((ref) {
  return variantRepository(firestore: ref.watch(firestoreProvider));
});

class variantRepository {
  final FirebaseFirestore _firestore;
  variantRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Stream<List<VariantModel>> getVariants() {
    return _variants.snapshots().map((event) => event.docs
        .map((e) => VariantModel.fromJson(e.data() as Map<String, dynamic>))
        .toList());
  }

  CollectionReference get _variants =>
      _firestore.collection(FirebaseConstants.variants);
}
