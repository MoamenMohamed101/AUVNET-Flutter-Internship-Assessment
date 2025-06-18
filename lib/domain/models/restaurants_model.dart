import 'package:hive/hive.dart';
part 'restaurants_model.g.dart';
@HiveType(typeId: 2) // Use a unique typeId (different from ServiceModel)
class RestaurantsModel extends HiveObject {
  @HiveField(0)
  String image;

  @HiveField(1)
  String title;

  @HiveField(2)
  String minute;

  RestaurantsModel(this.image, this.title, this.minute);

  factory RestaurantsModel.fromJson(Map<String, dynamic> json) {
    return RestaurantsModel(
      json['image'] ?? '',
      json['name'] ?? '',
      json['minute'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': title,
      'minute': minute,
    };
  }
}

