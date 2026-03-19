import '../../../../core/networking/api_result.dart';
import '../../domain/entities/product_entity.dart';

abstract class HomeRepo {
  Future<ApiResult<List<ProductEntity>>> getProducts();
  Future<ApiResult<List<String>>> getCategories();
  Future<ApiResult<List<ProductEntity>>> getProductsByCategory(String category);
}
