import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repos/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService _apiService;

  HomeRepoImpl(this._apiService);

  @override
  Future<ApiResult<List<ProductEntity>>> getProducts() async {
    try {
      final response = await _apiService.getAllProducts();
      final products = response.map((e) => e.toEntity()).toList();
      return Success(products);
    } catch (error) {
      return Failure(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<List<String>>> getCategories() async {
    try {
      final response = await _apiService.getCategories();
      return Success(response);
    } catch (error) {
      return Failure(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<List<ProductEntity>>> getProductsByCategory(
    String category,
  ) async {
    try {
      final response = await _apiService.getProductsByCategory(category);
      final products = response.map((e) => e.toEntity()).toList();
      return Success(products);
    } catch (error) {
      return Failure(ApiErrorHandler.handle(error));
    }
  }
}
