part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginClient extends LoginEvent {
  final String username;
  final String password;

  LoginClient(this.username, this.password);

  @override
  List<Object> get props => [username, password];
}
