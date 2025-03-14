import 'package:finance_system_controller/features/finance_controller/domain/entities/bank.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/client.dart';
import 'package:finance_system_controller/features/finance_controller/domain/repositories/enterprise_repository.dart';

class Enterprise{
  final int id;
  final String type;
  final String name;
  final String pin;
  final String bic;
  final String address;
  final List<Client> clients;

  Enterprise(
      {
        required this.id,
        required this.type,
        required this.pin,
        required this.address,
        required this.name,
        required this.bic,
        List<Client>? clients,
      })
      : clients = clients ?? [];
}
