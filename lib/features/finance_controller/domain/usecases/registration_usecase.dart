import 'package:finance_system_controller/features/finance_controller/domain/repositories/system_users/client_repository.dart';

import '../entities/system_users/system_user.dart';

class RegisterUsecase {
  final ClientRepository clientRepository;

  const RegisterUsecase(this.clientRepository);

  Future<User> register(User user) async {
    await clientRepository.register(user);
    return user;
  }
}
