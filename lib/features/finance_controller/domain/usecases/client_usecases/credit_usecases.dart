import 'package:finance_system_controller/features/finance_controller/domain/repositories/system_users/client_repository.dart';

import '../../entities/credit.dart';

class CreditUsecases{
  final ClientRepository clientRepository;

  CreditUsecases({required this.clientRepository});

}