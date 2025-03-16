import 'package:finance_system_controller/features/finance_controller/domain/entities/credit.dart';

class CreditModel extends Credit{
  final int id;
  final int clientId;
  final double percentage;
  final double amount;
  final double remainedToPay;

  CreditModel(
      {required this.percentage,
        required this.amount,
        required this.id,
        required this.clientId,
        required this.remainedToPay}) : super(percentage: percentage, amount: amount, id: id, clientId: clientId, remainedToPay: remainedToPay);

  Map<String, dynamic> toMap() {
    return {
      'clientId' : clientId,
      'percentage': percentage,
      'amount': amount,
      'remainedToPay' : remainedToPay
    };
  }

  factory CreditModel.fromMap(Map<String, dynamic> map) {
    return CreditModel(
      id: map['id'],
      clientId: map['clientId'],
      percentage: map['percentage'],
      amount: map['amount'],
      remainedToPay: map['remainedToPay']
    );
  }
}
