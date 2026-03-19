import 'package:json_annotation/json_annotation.dart';

part 'add_to_cart_request_body.g.dart';

@JsonSerializable()
class AddToCartRequestBody {
  final int userId;
  final String date;
  final List<CartProductRequestBody> products;

  const AddToCartRequestBody({
    required this.userId,
    required this.date,
    required this.products,
  });

  factory AddToCartRequestBody.fromJson(Map<String, dynamic> json) =>
      _$AddToCartRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AddToCartRequestBodyToJson(this);
}

@JsonSerializable()
class CartProductRequestBody {
  final int productId;
  final int quantity;

  const CartProductRequestBody({
    required this.productId,
    required this.quantity,
  });

  factory CartProductRequestBody.fromJson(Map<String, dynamic> json) =>
      _$CartProductRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CartProductRequestBodyToJson(this);
}
