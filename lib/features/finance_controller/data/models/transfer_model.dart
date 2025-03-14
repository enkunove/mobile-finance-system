import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/client.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/transfer.dart';

class TransferModel extends Transfer{
  @override
  final dynamic source;
  @override
  final dynamic target;
  @override
  final double amount;
  @override
  DateTime dateTime;

  TransferModel(this.source, this.target, this.amount) : dateTime = DateTime.now(), super(source, target, amount);

  Map<String, dynamic> toMap() {
    return {
      'source': source is Client ? source.username : source.accountId,
      'target': target is Client ? target.username : target.accountId,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  factory TransferModel.fromMap(Map<String, dynamic> map) {
    return TransferModel(
      map['source'],
      map['target'],
      map['amount']
    )..dateTime = DateTime.parse(map['dateTime']);
  }
}
