import 'package:finance_system_controller/features/finance_controller/data/models/system_users/externalspecialist_model.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/client.dart';
import 'package:finance_system_controller/features/finance_controller/domain/repositories/system_users/client_repository.dart';

import '../../data/models/system_users/client_model.dart';
import '../../data/models/system_users/manager_model.dart';
import '../../data/models/system_users/operator_model.dart';
import '../entities/system_users/system_user.dart';

class LoginUsecase {
  final ClientRepository authRepository;

  LoginUsecase(this.authRepository);

  Future<dynamic> login(String username, String password) async {
    final map = await authRepository.login(username, password);
    if (map == null) return null;
    switch (map['role']){
      case "Client":
        return ClientModel.fromMap(map);
      case "Manager":
        return ManagerModel.fromMap(map);
      case "Operator":
        return OperatorModel.fromMap(map);
      case "ExternalSpecialist":
        return ExternalSpecialistModel.fromMap(map);
    }
  }
}
