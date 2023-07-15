import 'package:adminapp/features/variants/repository/variants_repository.dart';
import 'package:adminapp/model/variant_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final variantsControllerProvider =
    NotifierProvider<VariantsController, int>(() {
  return VariantsController();
});

final getVariantsProvider = StreamProvider<List<VariantModel>>((ref) {
  return ref.watch(variantsControllerProvider.notifier).getVariants();
});

class VariantsController extends Notifier<int> {
  VariantsController();

  @override
  build() {
    return 0;
  }

  Stream<List<VariantModel>> getVariants() {
    var variantRepository = ref.watch(variantRepositoryProvider);
    return variantRepository.getVariants();
  }
}
