// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_to_cart_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddToCartRequestBody _$AddToCartRequestBodyFromJson(
  Map<String, dynamic> json,
) => AddToCartRequestBody(
  userId: (json['userId'] as num).toInt(),
  date: json['date'] as String,
  products: (json['products'] as List<dynamic>)
      .map((e) => CartProductRequestBody.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AddToCartRequestBodyToJson(
  AddToCartRequestBody instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'date': instance.date,
  'products': instance.products,
};

CartProductRequestBody _$CartProductRequestBodyFromJson(
  Map<String, dynamic> json,
) => CartProductRequestBody(
  productId: (json['productId'] as num).toInt(),
  quantity: (json['quantity'] as num).toInt(),
);

Map<String, dynamic> _$CartProductRequestBodyToJson(
  CartProductRequestBody instance,
) => <String, dynamic>{
  'productId': instance.productId,
  'quantity': instance.quantity,
};
