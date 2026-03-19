import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/use_cases/get_categories_use_case.dart';
import '../../domain/use_cases/get_products_by_category_use_case.dart';
import '../../domain/use_cases/get_products_use_case.dart';

// --- States ---
sealed class HomeCubitState {}

class HomeInitial extends HomeCubitState {}

class HomeLoading extends HomeCubitState {}

class HomeSuccess extends HomeCubitState {
  final List<ProductEntity> products;
  final List<String> categories;
  final String selectedCategory;

  HomeSuccess({
    required this.products,
    required this.categories,
    this.selectedCategory = 'All',
  });
}

class HomeFailure extends HomeCubitState {
  final String errMessage;
  HomeFailure(this.errMessage);
}

// --- Cubit ---
class HomeCubit extends Cubit<HomeCubitState> {
  final GetProductsUseCase _getProductsUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetProductsByCategoryUseCase _getProductsByCategoryUseCase;

  List<String> _categories = [];

  HomeCubit(
    this._getProductsUseCase,
    this._getCategoriesUseCase,
    this._getProductsByCategoryUseCase,
  ) : super(HomeInitial());

  Future<void> getHomeData() async {
    emit(HomeLoading());

    // Fetch categories and products in parallel
    final categoriesResult = await _getCategoriesUseCase.call();
    final productsResult = await _getProductsUseCase.call();

    categoriesResult.when(
      success: (categories) {
        _categories = ['All', ...categories];
      },
      failure: (_) {
        _categories = ['All'];
      },
    );

    productsResult.when(
      success: (products) {
        emit(
          HomeSuccess(
            products: products,
            categories: _categories,
            selectedCategory: 'All',
          ),
        );
      },
      failure: (err) => emit(HomeFailure(err)),
    );
  }

  Future<void> filterByCategory(String category) async {
    if (category == 'All') {
      emit(HomeLoading());
      final result = await _getProductsUseCase.call();
      result.when(
        success: (products) => emit(
          HomeSuccess(
            products: products,
            categories: _categories,
            selectedCategory: 'All',
          ),
        ),
        failure: (err) => emit(HomeFailure(err)),
      );
    } else {
      emit(HomeLoading());
      final result = await _getProductsByCategoryUseCase.call(category);
      result.when(
        success: (products) => emit(
          HomeSuccess(
            products: products,
            categories: _categories,
            selectedCategory: category,
          ),
        ),
        failure: (err) => emit(HomeFailure(err)),
      );
    }
  }
}
