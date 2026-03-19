import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/request_bodies/add_product_request_body.dart';
import '../../../home/domain/entities/product_entity.dart';

abstract class AddProductRepo {
  Future<ApiResult<ProductEntity>> addProduct(AddProductRequestBody body);
}
