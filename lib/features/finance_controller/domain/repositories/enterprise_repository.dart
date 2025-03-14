import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/client.dart';

import '../entities/enterprise.dart';

abstract class EnterpriseRepository {
  Future<List<Enterprise>> getAllEnterprises();
  Future<Enterprise> getEnterpriseById(String id);
  Future<bool> registerWorker(Client client);
}
