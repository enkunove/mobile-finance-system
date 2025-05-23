import 'package:finance_system_controller/features/finance_controller/domain/entities/credit.dart';

class CreditModel extends Credit{
  @override
  final int id;
  @override
  final int clientId;
  @override
  final int accountId;
  @override
  final int months;
  @override
  final double percentage;
  @override
  final double amount;
  @override
  final double remainedToPay;
  @override
  final bool isApproved;

  CreditModel(
      {required this.percentage,
        required this.amount,
        required this.months,
        required this.id,
        required this.clientId,
        required this.accountId,
        required this.remainedToPay,
        required this.isApproved}) : super(isApproved: isApproved, accountId: accountId, months: months, percentage: percentage, amount: amount, id: id, clientId: clientId, remainedToPay: remainedToPay);

  Map<String, dynamic> toMap() {
    return {
      'clientId' : clientId,
      'accountId' : accountId,
      'percentage': percentage,
      'amount': amount,
      'remainedToPay' : remainedToPay,
      'months': months,
      'isApproved' : isApproved? 1:0
    };
  }

  factory CreditModel.fromMap(Map<String, dynamic> map) {
    return CreditModel(
      id: map['id'],
      clientId: map['clientId'],
      accountId: map['accountId'],
      percentage: map['percentage'],
      amount: map['amount'],
      remainedToPay: map['remainedToPay'],
      months: map['months'],
      isApproved: map['isApproved'] == 1? true: false
    );
  }
}
