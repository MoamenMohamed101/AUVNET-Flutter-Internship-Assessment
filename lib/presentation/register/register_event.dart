part of 'register_bloc.dart';

sealed class RegisterEvent {}

final class RegisterPressed extends RegisterEvent {
  final String email, password, confirmPassword;

  RegisterPressed(this.email, this.password, this.confirmPassword);
}