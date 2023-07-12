import 'package:adminapp/features/store/repository/store_repository.dart';
import 'package:adminapp/model/store_category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storeControllerProvider = NotifierProvider<StoreController, bool>(() {
  return StoreController();
});

final getStoreCategoriesProvider =
    StreamProvider.family<List<StoreCategoryModel>, bool>((ref, category) {
  return ref
      .watch(storeControllerProvider.notifier)
      .getStoreCategories(category: category);
});

class StoreController extends Notifier<bool> {
  StoreController();

  @override
  bool build() {
    return false;
  }

  Stream<List<StoreCategoryModel>> getStoreCategories(
      {required bool category}) {
    var storeRepository = ref.watch(storeRepositoryProvider);
    return storeRepository.getStoreCategories(category: category);
  }
}
