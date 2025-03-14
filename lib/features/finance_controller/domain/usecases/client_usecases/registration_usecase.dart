import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/client.dart';
import 'package:finance_system_controller/features/finance_controller/domain/repositories/system_users/client_repository.dart';

class RegisterUsecase{
  final ClientRepository clientRepository;

  const RegisterUsecase(this.clientRepository);

  Future<Client> register(Client client) async{
    await clientRepository.register(client);
    return client;
  }
}