
import 'package:nawel/domain/models/service_model.dart';
import 'package:nawel/domain/repository/repository.dart';

class GetServicesUseCase {
  final Repository repository;

  GetServicesUseCase(this.repository);

  Future<List<ServiceModel>> call() {
    return repository.getServices();
  }
}