import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/domain/entities/product_entity.dart';

// --- States ---
sealed class CartState {}

class CartUpdated extends CartState {
  final Map<ProductEntity, int> items;

  CartUpdated(this.items);

  double get totalPrice {
    double total = 0;
    items.forEach((product, qty) {
      total += product.price * qty;
    });
    return total;
  }

  int get totalItems {
    int total = 0;
    items.forEach((_, qty) {
      total += qty;
    });
    return total;
  }
}

// --- Cubit ---
class CartCubit extends Cubit<CartState> {
  final Map<ProductEntity, int> _items = {};

  CartCubit() : super(CartUpdated(const {}));

  Map<ProductEntity, int> get items => Map.unmodifiable(_items);

  double get totalPrice {
    double total = 0;
    _items.forEach((product, qty) {
      total += product.price * qty;
    });
    return total;
  }

  int get totalItems {
    int total = 0;
    _items.forEach((_, qty) {
      total += qty;
    });
    return total;
  }

  void addItem(ProductEntity product, [int quantity = 1]) {
    if (_items.containsKey(product)) {
      _items[product] = _items[product]! + quantity;
    } else {
      _items[product] = quantity;
    }
    emit(CartUpdated(Map.from(_items)));
  }

  void removeItem(ProductEntity product) {
    _items.remove(product);
    emit(CartUpdated(Map.from(_items)));
  }

  void incrementQty(ProductEntity product) {
    if (_items.containsKey(product)) {
      _items[product] = _items[product]! + 1;
      emit(CartUpdated(Map.from(_items)));
    }
  }

  void decrementQty(ProductEntity product) {
    if (_items.containsKey(product)) {
      if (_items[product]! > 1) {
        _items[product] = _items[product]! - 1;
      } else {
        _items.remove(product);
      }
      emit(CartUpdated(Map.from(_items)));
    }
  }

  void clearCart() {
    _items.clear();
    emit(CartUpdated(Map.from(_items)));
  }
}
