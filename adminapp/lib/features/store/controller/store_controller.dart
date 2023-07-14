import 'package:adminapp/features/store/repository/store_repository.dart';
import 'package:adminapp/model/store_category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storeControllerProvider = NotifierProvider<StoreController, bool>(() {
  return StoreController();
});

final getStoreCategoriesProvider =
    StreamProvider<List<StoreCategoryModel>>((ref) {
  return ref.watch(storeControllerProvider.notifier).getStoreCategories();
});

class StoreController extends Notifier<bool> {
  StoreController();

  @override
  bool build() {
    return false;
  }

  Stream<List<StoreCategoryModel>> getStoreCategories() {
    var storeRepository = ref.watch(storeRepositoryProvider);
    return storeRepository.getStoreCategories();
  }
}
