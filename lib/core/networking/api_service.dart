import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/cart/data/models/cart_response.dart';
import '../../features/home/data/models/product_response.dart';
import 'api_constants.dart';
import 'request_bodies/add_product_request_body.dart';
import 'request_bodies/add_to_cart_request_body.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // --- Products ---
  @GET(ApiConstants.products)
  Future<List<ProductResponse>> getAllProducts();

  @GET(ApiConstants.products)
  Future<List<ProductResponse>> getProductsByLimit(@Query('limit') int limit);

  @GET('/products/{id}')
  Future<ProductResponse> getProductById(@Path('id') int id);

  @GET(ApiConstants.categories)
  Future<List<String>> getCategories();

  @GET('/products/category/{category}')
  Future<List<ProductResponse>> getProductsByCategory(
    @Path('category') String category,
  );

  @POST(ApiConstants.products)
  Future<ProductResponse> addProduct(@Body() AddProductRequestBody body);

  // --- Carts ---
  @GET(ApiConstants.carts)
  Future<List<CartResponse>> getAllCarts();

  @GET('/carts/{id}')
  Future<CartResponse> getCartById(@Path('id') int id);

  @POST(ApiConstants.carts)
  Future<CartResponse> addToCart(@Body() AddToCartRequestBody body);

  @PUT('/carts/{id}')
  Future<CartResponse> updateCart(
    @Path('id') int id,
    @Body() AddToCartRequestBody body,
  );
}
