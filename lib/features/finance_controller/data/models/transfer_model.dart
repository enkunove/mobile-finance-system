import 'package:finance_system_controller/features/finance_controller/domain/entities/transfer.dart';

class TransferModel extends Transfer{
  @override
  final String source;
  @override
  final String target;
  @override
  final double amount;
  @override
  final DateTime dateTime;

  TransferModel(this.source, this.target, this.amount, this.dateTime) : super(source, target, amount, dateTime);

  Map<String, dynamic> toMap() {
    return {
      'source': source,
      'target': target,
      'amount' : amount,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  factory TransferModel.fromMap(Map<String, dynamic> map) {
    return TransferModel(
      map['source'],
      map['target'],
      map['amount'],
      DateTime.parse(map['dateTime']
    ));
  }
}
