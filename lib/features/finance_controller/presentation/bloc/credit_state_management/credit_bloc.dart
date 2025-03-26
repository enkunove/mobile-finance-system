import 'package:finance_system_controller/features/finance_controller/domain/entities/account.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/credit.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/client.dart';
import 'package:finance_system_controller/features/finance_controller/domain/usecases/client_usecases/credit_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'credit_event.dart';
import 'credit_state.dart';

class CreditBloc extends Bloc<CreditEvent, CreditState> {

  final CreditUsecases _usecases;
  final Client _client;
  final Account account;
  final Credit? credit;

  CreditBloc(this._usecases, this._client, this.account, this.credit)
      : super(credit != null
      ? CreditState.initial().copyWith(
    term: credit!.months,
    sum: credit!.amount,
    percentage: (credit!.months * 1.2).toStringAsFixed(2),
    credit: credit,
  )
      : CreditState.initial()) {
    on<SelectTermEvent>((event, emit) {
      final newPercentage = (event.term * 1.2).toStringAsFixed(2);
      emit(state.copyWith(term: event.term, percentage: newPercentage, credit: null));
    });

    on<UpdateSumEvent>((event, emit) {
      emit(state.copyWith(sum: event.sum));
    });

    on<SetUserPercentageEvent>((event, emit){
      emit(state.copyWith(percentage: state.percentage));
    });

    on<SendCreditRequestEvent>((event, emit) async {
      final credit = Credit(percentage: event.percentage, amount: event.sum, months: event.months, id: 0, clientId: _client.idNumber, accountId: account.accountId, remainedToPay: (event.sum + event.sum*event.percentage*0.01), isApproved: false);
      await _usecases.addCredit(credit);
      emit(UpdateStatusState(term: event.months, percentage: event.percentage.toString(), sum: event.sum, credit: credit));
    });

    on<CancelCreditRequestEvent>((event, emit) async {
      await _usecases.deleteCredit(state.credit!.id);
      emit(UpdateStatusState(credit: null, term: state.term, percentage: state.percentage, sum: double.parse(state.percentage)));
    });

    on<PutMonthlyPayment>((event, emit) async {
      final cr = await _usecases.putMonthlyPayment(state.credit!.id);
      emit(UpdateStatusState(term: state.term, percentage: state.percentage, sum: state.sum, credit: cr));
      emit(state.copyWith());
    });
  }
}
