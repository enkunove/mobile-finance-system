import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/client.dart';

class Transfer{
  final dynamic source;
  final dynamic target;
  final double amount;
  DateTime dateTime;

  Transfer(this.source, this.target, this.amount) : dateTime = DateTime.now();
}