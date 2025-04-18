part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final Client client;

  RegisterSuccess(this.client);

  @override
  List<Object> get props => [client];
}

class RegisterFailure extends RegisterState {
  final String message;

  RegisterFailure(this.message);

  @override
  List<Object> get props => [message];
}
