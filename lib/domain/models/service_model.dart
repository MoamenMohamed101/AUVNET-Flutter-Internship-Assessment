import 'package:hive/hive.dart';

part 'service_model.g.dart';

@HiveType(typeId: 1)
class ServiceModel extends HiveObject {
  @HiveField(0)
  String productName;

  @HiveField(1)
  String productImage;

  @HiveField(2)
  String productNumber;

  ServiceModel({
    required this.productName,
    required this.productImage,
    required this.productNumber,
  });

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      productImage: map['image'] ?? '',
      productName: map['name'] ?? '',
      productNumber: map['number'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': productImage,
      'name': productName,
      'number': productNumber,
    };
  }
}
