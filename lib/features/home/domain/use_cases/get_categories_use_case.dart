import '../../../../core/networking/api_result.dart';
import '../repos/home_repo.dart';

class GetCategoriesUseCase {
  final HomeRepo _homeRepo;

  GetCategoriesUseCase(this._homeRepo);

  Future<ApiResult<List<String>>> call() {
    return _homeRepo.getCategories();
  }
}
