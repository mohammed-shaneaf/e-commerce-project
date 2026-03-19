import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/request_bodies/add_product_request_body.dart';
import '../../../home/domain/entities/product_entity.dart';
import '../repos/add_product_repo.dart';

class AddProductUseCase {
  final AddProductRepo _addProductRepo;

  AddProductUseCase(this._addProductRepo);

  Future<ApiResult<ProductEntity>> call(AddProductRequestBody body) {
    return _addProductRepo.addProduct(body);
  }
}
