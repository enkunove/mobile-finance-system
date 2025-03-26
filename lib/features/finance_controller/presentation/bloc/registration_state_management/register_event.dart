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

class RegisterSpecialist extends RegisterEvent{
  final ExternalSpecialist externalSpecialist;

  RegisterSpecialist(this.externalSpecialist);
  @override
  List<Object> get props => [externalSpecialist];
}
