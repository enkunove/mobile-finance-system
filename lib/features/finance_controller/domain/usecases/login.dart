import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/client.dart';
import 'package:finance_system_controller/features/finance_controller/domain/repositories/system_users/client_repository.dart';

class LoginUsecase {
  final ClientRepository authRepository;

  LoginUsecase(this.authRepository);

  Future<Client?> login(String username, String password) async {
    return await authRepository.login(username, password);
  }
}
