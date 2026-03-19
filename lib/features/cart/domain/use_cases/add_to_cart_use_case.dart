import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/request_bodies/add_to_cart_request_body.dart';
import '../../../cart/data/models/cart_response.dart';
import '../repos/cart_repo.dart';

class AddToCartUseCase {
  final CartRepo _cartRepo;

  AddToCartUseCase(this._cartRepo);

  Future<ApiResult<CartResponse>> call(AddToCartRequestBody body) {
    return _cartRepo.addToCart(body);
  }
}
