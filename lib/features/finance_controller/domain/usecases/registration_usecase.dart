import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/client.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/externalspecialist.dart';
import 'package:finance_system_controller/features/finance_controller/domain/repositories/system_users/client_repository.dart';

import '../entities/system_users/system_user.dart';

class RegisterUsecase{
  final ClientRepository clientRepository;

  const RegisterUsecase(this.clientRepository);

  Future<User> register(User user) async{
    if (user is Client){
      await clientRepository.register(user as Client);
      return user;
    }
    else {
      await clientRepository.register(user as ExternalSpecialist);
      return user;
    }
  }
}