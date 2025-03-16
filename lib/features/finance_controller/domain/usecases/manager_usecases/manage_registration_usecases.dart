import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/client.dart';
import 'package:finance_system_controller/features/finance_controller/domain/repositories/system_users/client_repository.dart';

class ManageRegistrationUsecases{
  final ClientRepository clientRepository;

  ManageRegistrationUsecases(this.clientRepository);

  Future<void> confirmRegistration(Client client) async{
    Client ne = Client(client.username, client.password, fullName: client.fullName, passportSeriesAndNumber: client.passportSeriesAndNumber, idNumber: client.idNumber, phone: client.phone, email: client.email, isApproved: true);
    await clientRepository.updateClientById(ne);
  }

  Future<void> declineRegistration(Client client) async{
    await clientRepository.deleteClient(client.idNumber);
  }

  Future<List<Client>> getAllRegistrationRequests() async{
    return await clientRepository.getAllRegistrationRequests();
  }
}