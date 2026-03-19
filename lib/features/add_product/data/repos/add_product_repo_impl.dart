import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
import '../../../../core/networking/request_bodies/add_product_request_body.dart';
import '../../../home/domain/entities/product_entity.dart';
import '../../domain/repos/add_product_repo.dart';

class AddProductRepoImpl implements AddProductRepo {
  final ApiService _apiService;

  AddProductRepoImpl(this._apiService);

  @override
  Future<ApiResult<ProductEntity>> addProduct(
    AddProductRequestBody body,
  ) async {
    try {
      final response = await _apiService.addProduct(body);
      return Success(response.toEntity());
    } catch (error) {
      return Failure(ApiErrorHandler.handle(error));
    }
  }
}
