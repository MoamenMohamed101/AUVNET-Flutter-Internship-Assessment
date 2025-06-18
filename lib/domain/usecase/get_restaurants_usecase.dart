import 'package:nawel/domain/models/restaurants_model.dart';
import 'package:nawel/domain/repository/repository.dart';

class GetRestaurantsUseCase {
  final Repository repository;

  GetRestaurantsUseCase(this.repository);

  Future<List<RestaurantsModel>> call() {
    return repository.getRestaurants();
  }
}