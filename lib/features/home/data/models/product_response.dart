import 'package:json_annotation/json_annotation.dart';

import '../../../home/domain/entities/product_entity.dart';
import 'rating_response.dart';

part 'product_response.g.dart';

@JsonSerializable()
class ProductResponse {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final RatingResponse? rating;

  const ProductResponse({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    this.rating,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);

  ProductEntity toEntity() => ProductEntity(
    id: id,
    title: title,
    price: price,
    description: description,
    category: category,
    image: image,
    rate: rating?.rate ?? 0.0,
    ratingCount: rating?.count ?? 0,
  );
}
