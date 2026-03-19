import 'package:json_annotation/json_annotation.dart';

part 'add_product_request_body.g.dart';

@JsonSerializable()
class AddProductRequestBody {
  final String title;
  final double price;
  final String description;
  final String image;
  final String category;

  const AddProductRequestBody({
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.category,
  });

  factory AddProductRequestBody.fromJson(Map<String, dynamic> json) =>
      _$AddProductRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AddProductRequestBodyToJson(this);
}
