import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
import '../../../../core/networking/request_bodies/add_to_cart_request_body.dart';
import '../../data/models/cart_response.dart';
import '../../domain/repos/cart_repo.dart';

class CartRepoImpl implements CartRepo {
  final ApiService _apiService;

  CartRepoImpl(this._apiService);

  @override
  Future<ApiResult<CartResponse>> addToCart(AddToCartRequestBody body) async {
    try {
      final response = await _apiService.addToCart(body);
      return Success(response);
    } catch (error) {
      return Failure(ApiErrorHandler.handle(error));
    }
  }
}
