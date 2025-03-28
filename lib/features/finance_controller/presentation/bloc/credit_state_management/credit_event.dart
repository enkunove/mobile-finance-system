import 'package:equatable/equatable.dart';

import '../../../domain/entities/credit.dart';

abstract class CreditEvent extends Equatable {
  const CreditEvent();

  @override
  List<Object?> get props => [];
}

class SelectTermEvent extends CreditEvent {
  final int term;

  const SelectTermEvent(this.term);

  @override
  List<Object?> get props => [term];
}

class UpdateSumEvent extends CreditEvent {
  final double sum;

  const UpdateSumEvent(this.sum);

  @override
  List<Object?> get props => [sum];
}

class SetUserPercentageEvent extends CreditEvent{
  final double percentage;

  const SetUserPercentageEvent(this.percentage);

  @override
  List<Object?> get props => [percentage];
}

class SendCreditRequestEvent extends CreditEvent{
  final int months;
  final double percentage;
  final double sum;

  const SendCreditRequestEvent(this.months, this.percentage, this.sum);

  @override
  List<Object?> get props => [months, percentage, sum];
}

class UpdateCreditEvent extends CreditEvent {
  final Credit? credit;
  const UpdateCreditEvent(this.credit);
}

class CancelCreditRequestEvent extends CreditEvent{}

class PutMonthlyPayment extends CreditEvent{}
