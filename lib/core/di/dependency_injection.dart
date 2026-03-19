import 'package:get_it/get_it.dart';

import '../networking/api_service.dart';
import '../networking/dio_factory.dart';
import '../../features/add_product/data/repos/add_product_repo_impl.dart';
import '../../features/add_product/domain/repos/add_product_repo.dart';
import '../../features/add_product/domain/use_cases/add_product_use_case.dart';
import '../../features/add_product/presentation/cubits/add_product_cubit.dart';
import '../../features/cart/data/repos/cart_repo_impl.dart';
import '../../features/cart/domain/repos/cart_repo.dart';
import '../../features/cart/domain/use_cases/add_to_cart_use_case.dart';
import '../../features/cart/presentation/cubits/cart_cubit.dart';
import '../../features/home/data/repos/home_repo_impl.dart';
import '../../features/home/domain/repos/home_repo.dart';
import '../../features/home/domain/use_cases/get_categories_use_case.dart';
import '../../features/home/domain/use_cases/get_products_by_category_use_case.dart';
import '../../features/home/domain/use_cases/get_products_use_case.dart';
import '../../features/home/presentation/cubits/home_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  // --- Core ---
  final dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  // --- Home Feature ---
  getIt.registerLazySingleton<HomeRepo>(
    () => HomeRepoImpl(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<GetProductsUseCase>(
    () => GetProductsUseCase(getIt<HomeRepo>()),
  );
  getIt.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(getIt<HomeRepo>()),
  );
  getIt.registerLazySingleton<GetProductsByCategoryUseCase>(
    () => GetProductsByCategoryUseCase(getIt<HomeRepo>()),
  );
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(
      getIt<GetProductsUseCase>(),
      getIt<GetCategoriesUseCase>(),
      getIt<GetProductsByCategoryUseCase>(),
    ),
  );

  // --- Cart Feature ---
  getIt.registerLazySingleton<CartRepo>(
    () => CartRepoImpl(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<AddToCartUseCase>(
    () => AddToCartUseCase(getIt<CartRepo>()),
  );
  // Cart cubit is a SINGLETON so state persists across pages
  getIt.registerLazySingleton<CartCubit>(() => CartCubit());

  // --- Add Product Feature ---
  getIt.registerLazySingleton<AddProductRepo>(
    () => AddProductRepoImpl(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<AddProductUseCase>(
    () => AddProductUseCase(getIt<AddProductRepo>()),
  );
  getIt.registerFactory<AddProductCubit>(
    () => AddProductCubit(getIt<AddProductUseCase>()),
  );
}
