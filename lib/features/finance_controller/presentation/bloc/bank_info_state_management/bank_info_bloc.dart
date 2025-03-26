import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:finance_system_controller/features/finance_controller/domain/usecases/client_usecases/credit_usecases.dart';
import 'package:meta/meta.dart';
import '../../../domain/entities/account.dart';
import '../../../domain/entities/bank.dart';
import '../../../domain/entities/credit.dart';
import '../../../domain/entities/system_users/client.dart';
import '../../../domain/usecases/client_usecases/account_management_usecases.dart';

part 'bank_info_event.dart';
part 'bank_info_state.dart';

class BankInfoBloc extends Bloc<BankInfoEvent, BankInfoState> {
  final AccountManagementUsecases accountUsecase;
  final CreditUsecases creditUsecases;
  final Client client;
  final Bank bank;

  BankInfoBloc(this.accountUsecase, this.creditUsecases, this.client, this.bank) : super(BankInfoInitial()) {
    on<FetchBankInfo>(_onFetchBankInfo);
  }

  Future<void> _onFetchBankInfo(FetchBankInfo event, Emitter<BankInfoState> emit) async {
    emit(BankInfoLoading());
    final accounts = await accountUsecase.getAccountsForClient(client);
    final account = accounts.firstWhereOrNull((a) => a.bankId == bank.id);
    if (account == null) {
      emit(BankInfoLoaded(null, null));
    } else {
      final credit = await creditUsecases.getCreditForAccount(account.accountId);
      print(credit);
      emit(BankInfoLoaded(account, credit));
    }
  }
}
