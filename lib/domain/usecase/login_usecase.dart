import 'package:nawel/domain/repository/repository.dart';

class LoginUseCase {
  Repository repository;

  LoginUseCase(this.repository);

  Future<void> login(String email, String password) async {
    try {
      await repository.login(email, password);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
