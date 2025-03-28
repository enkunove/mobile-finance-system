import 'package:finance_system_controller/features/finance_controller/domain/repositories/system_users/client_repository.dart';

import '../../entities/system_users/system_user.dart';

class ManageRegistrationUsecases{
  final ClientRepository clientRepository;

  ManageRegistrationUsecases(this.clientRepository);

  Future<void> confirmRegistration(User user) async{
    User ne = User(username: user.username, password: user.password, fullName: user.fullName, passportSeriesAndNumber: user.passportSeriesAndNumber, idNumber: user.idNumber, phone: user.phone, email: user.email, isApproved: true, role: user.role);
    await clientRepository.updateClientById(ne);
  }

  Future<void> declineRegistration(User user) async{
    await clientRepository.deleteClient(user.idNumber);
  }

  Future<List<User>> getAllRegistrationRequests() async{
    return await clientRepository.getAllRegistrationRequests();
  }
}