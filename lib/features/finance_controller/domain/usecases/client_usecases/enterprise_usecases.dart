import 'package:finance_system_controller/features/finance_controller/domain/repositories/enterprise_repository.dart';

import '../../entities/enterprise.dart';
import '../../entities/system_users/client.dart';

class EnterpriseUsecases{
  final EnterpriseRepository enterpriseRepository;
  final Client client;

  EnterpriseUsecases(this.client, {required this.enterpriseRepository});

  Future<void> registerInEnterprise(String enterpriseId) async {
    Enterprise enterprise = await enterpriseRepository.getEnterpriseById(enterpriseId);
    enterprise.clients.add(client);
    await enterpriseRepository.registerWorker(client);
  }
}