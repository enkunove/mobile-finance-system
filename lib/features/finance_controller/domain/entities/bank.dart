import 'package:finance_system_controller/features/finance_controller/domain/entities/enterprise.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/client.dart';
import 'package:finance_system_controller/features/finance_controller/domain/repositories/bank_repository.dart';

class Bank extends Enterprise {
  Bank(
      {
        required super.id,
        required super.type,
        required super.pin,
        required super.address,
        required super.name,
        required super.bic,
        super.clients,
      });
}
