// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_product_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddProductRequestBody _$AddProductRequestBodyFromJson(
  Map<String, dynamic> json,
) => AddProductRequestBody(
  title: json['title'] as String,
  price: (json['price'] as num).toDouble(),
  description: json['description'] as String,
  image: json['image'] as String,
  category: json['category'] as String,
);

Map<String, dynamic> _$AddProductRequestBodyToJson(
  AddProductRequestBody instance,
) => <String, dynamic>{
  'title': instance.title,
  'price': instance.price,
  'description': instance.description,
  'image': instance.image,
  'category': instance.category,
};
