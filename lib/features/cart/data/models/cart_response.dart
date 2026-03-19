import 'package:json_annotation/json_annotation.dart';

part 'cart_response.g.dart';

@JsonSerializable()
class CartResponse {
  final int id;
  final int userId;
  final String date;
  final List<CartProductResponse> products;

  const CartResponse({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) =>
      _$CartResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CartResponseToJson(this);
}

@JsonSerializable()
class CartProductResponse {
  final int productId;
  final int quantity;

  const CartProductResponse({required this.productId, required this.quantity});

  factory CartProductResponse.fromJson(Map<String, dynamic> json) =>
      _$CartProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CartProductResponseToJson(this);
}
