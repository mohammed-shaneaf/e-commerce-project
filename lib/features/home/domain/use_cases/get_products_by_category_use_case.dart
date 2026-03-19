import '../../../../core/networking/api_result.dart';
import '../entities/product_entity.dart';
import '../repos/home_repo.dart';

class GetProductsByCategoryUseCase {
  final HomeRepo _homeRepo;

  GetProductsByCategoryUseCase(this._homeRepo);

  Future<ApiResult<List<ProductEntity>>> call(String category) {
    return _homeRepo.getProductsByCategory(category);
  }
}
