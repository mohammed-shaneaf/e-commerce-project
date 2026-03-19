import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/networking/api_service.dart';
import '../../../home/domain/entities/product_entity.dart';

// --- States ---
sealed class ProductDetailsState {}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsSuccess extends ProductDetailsState {
  final ProductEntity product;
  final int quantity;

  ProductDetailsSuccess({required this.product, this.quantity = 1});
}

class ProductDetailsFailure extends ProductDetailsState {
  final String errMessage;
  ProductDetailsFailure(this.errMessage);
}

// --- Cubit ---
class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ApiService _apiService;

  int _quantity = 1;
  ProductEntity? _product;

  ProductDetailsCubit(this._apiService) : super(ProductDetailsInitial());

  int get quantity => _quantity;
  ProductEntity? get product => _product;

  Future<void> getProductById(int id) async {
    emit(ProductDetailsLoading());
    try {
      final response = await _apiService.getProductById(id);
      _product = response.toEntity();
      _quantity = 1;
      emit(ProductDetailsSuccess(product: _product!, quantity: _quantity));
    } catch (error) {
      emit(ProductDetailsFailure('Failed to load product details.'));
    }
  }

  void incrementQuantity() {
    if (_product != null) {
      _quantity++;
      emit(ProductDetailsSuccess(product: _product!, quantity: _quantity));
    }
  }

  void decrementQuantity() {
    if (_product != null && _quantity > 1) {
      _quantity--;
      emit(ProductDetailsSuccess(product: _product!, quantity: _quantity));
    }
  }
}
