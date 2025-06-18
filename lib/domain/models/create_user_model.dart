class CreateUserModel {
  final String email;
  final String password;


  CreateUserModel({required this.email, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }
}