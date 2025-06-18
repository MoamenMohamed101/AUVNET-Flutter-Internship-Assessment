import 'package:nawel/domain/models/restaurants_model.dart';
import 'package:nawel/domain/models/service_model.dart';

abstract class Repository {
  Future<void> register(String email, String password);

  Future<void> login(String email, String password);

  Future<void> createUser(String email, String password, String uId);

  Future<List<ServiceModel>> getServices();

  Future<List<RestaurantsModel>> getRestaurants();
}
