import 'package:finance_system_controller/features/finance_controller/data/models/system_users/client_model.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/credit.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/transfer.dart';
import '../../entities/account.dart';
import '../../entities/system_users/client.dart';

abstract class ClientRepository {

  Future<bool>register(Client client);
  Future<Client?>login(String username, String password);
}
