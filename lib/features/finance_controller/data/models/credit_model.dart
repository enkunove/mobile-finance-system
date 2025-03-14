import 'package:finance_system_controller/features/finance_controller/domain/entities/credit.dart';

class CreditModel extends Credit{
  @override
  final double percentage;
  @override
  final double amount;

  CreditModel(this.percentage, this.amount) : super(percentage, amount);

  Map<String, dynamic> toMap() {
    return {
      'percentage': percentage,
      'amount': amount,
    };
  }

  factory CreditModel.fromMap(Map<String, dynamic> map) {
    return CreditModel(
      map['percentage'],
      map['amount'],
    );
  }
}
