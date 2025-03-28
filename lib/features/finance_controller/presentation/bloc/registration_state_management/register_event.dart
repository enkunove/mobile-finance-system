part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterClient extends RegisterEvent {
  final Client client;

  RegisterClient(this.client);

  @override
  List<Object> get props => [client];
}

class RegisterEnterprise extends RegisterEvent{
  final Enterprise enterprise;

  RegisterEnterprise(this.enterprise);

  @override
  List<Object> get props => [enterprise];
}
