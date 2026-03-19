import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/request_bodies/add_to_cart_request_body.dart';
import '../../../cart/data/models/cart_response.dart';

abstract class CartRepo {
  Future<ApiResult<CartResponse>> addToCart(AddToCartRequestBody body);
}
