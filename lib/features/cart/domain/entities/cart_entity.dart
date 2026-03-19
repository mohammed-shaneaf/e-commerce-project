import 'package:equatable/equatable.dart';

import '../../../home/domain/entities/product_entity.dart';

class CartEntity extends Equatable {
  final Map<ProductEntity, int> items;

  const CartEntity({this.items = const {}});

  double get totalPrice {
    double total = 0;
    items.forEach((product, quantity) {
      total += product.price * quantity;
    });
    return total;
  }

  int get totalItems {
    int total = 0;
    items.forEach((_, quantity) {
      total += quantity;
    });
    return total;
  }

  @override
  List<Object?> get props => [items];
}
