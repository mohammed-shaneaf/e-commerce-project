import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/networking/request_bodies/add_product_request_body.dart';
import '../../domain/use_cases/add_product_use_case.dart';

// --- States ---
sealed class AddProductState {}

class AddProductInitial extends AddProductState {}

class AddProductLoading extends AddProductState {}

class AddProductSuccess extends AddProductState {
  final String message;
  AddProductSuccess(this.message);
}

class AddProductFailure extends AddProductState {
  final String errMessage;
  AddProductFailure(this.errMessage);
}

// --- Cubit ---
class AddProductCubit extends Cubit<AddProductState> {
  final AddProductUseCase _addProductUseCase;

  AddProductCubit(this._addProductUseCase) : super(AddProductInitial());

  Future<void> addProduct({
    required String title,
    required double price,
    required String description,
    required String category,
    required String image,
  }) async {
    emit(AddProductLoading());

    final body = AddProductRequestBody(
      title: title,
      price: price,
      description: description,
      image: image,
      category: category,
    );

    final result = await _addProductUseCase.call(body);

    result.when(
      success: (_) => emit(AddProductSuccess('Product added successfully!')),
      failure: (err) => emit(AddProductFailure(err)),
    );
  }
}
