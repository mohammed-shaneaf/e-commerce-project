import '../../../../core/networking/api_result.dart';
import '../entities/product_entity.dart';
import '../repos/home_repo.dart';

class GetProductsUseCase {
  final HomeRepo _homeRepo;

  GetProductsUseCase(this._homeRepo);

  Future<ApiResult<List<ProductEntity>>> call() {
    return _homeRepo.getProducts();
  }
}
