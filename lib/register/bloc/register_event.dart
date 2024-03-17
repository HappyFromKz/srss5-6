part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

class RegisterButtonPressed extends RegisterEvent {
  final String email;
  final String password;
  final String phone;
  RegisterButtonPressed(this.email, this.password, this.phone);
}