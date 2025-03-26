import 'package:equatable/equatable.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/credit.dart';

class CreditState extends Equatable {
  final int term;
  final String percentage;
  final double sum;
  final Credit? credit;

  const CreditState({
    required this.term,
    required this.percentage,
    required this.sum,
    required this.credit
  });

  factory CreditState.initial() {
    return CreditState(
      term: 3,
      percentage: (3 * 1.2).toStringAsFixed(2),
      sum: 0.0,
      credit: null
    );
  }

  CreditState copyWith({
    int? term,
    String? percentage,
    double? sum,
    Credit? credit
  }) {
    return CreditState(
      term: term ?? this.term,
      percentage: percentage ?? this.percentage,
      sum: sum ?? this.sum,
      credit: credit ?? this.credit
    );
  }

  @override
  List<Object?> get props => [term, percentage, sum];
}

class UpdateStatusState extends CreditState{
  UpdateStatusState({required super.term, required super.percentage, required super.sum, required super.credit});

}
