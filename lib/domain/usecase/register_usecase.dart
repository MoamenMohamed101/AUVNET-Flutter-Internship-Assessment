import 'package:nawel/domain/repository/repository.dart';

class RegisterUseCase {
  Repository repository;

  RegisterUseCase(this.repository);

  Future<void> register(String email, String password) async {
    try {
      await repository.register(email, password);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
