import 'package:finance_system_controller/features/finance_controller/domain/entities/account.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/transfer.dart';
import 'package:finance_system_controller/features/finance_controller/domain/repositories/account_repository.dart';
import 'package:finance_system_controller/features/finance_controller/domain/repositories/credit_repository.dart';

import '../../entities/credit.dart';

class ManageCreditsUsecases{
  final CreditRepository creditRepository;
  final AccountRepository accountRepository;

  ManageCreditsUsecases(this.creditRepository, this.accountRepository);

  Future<void> confirmRegistration(Credit credit) async{
    Credit ne = Credit(percentage: credit.percentage, amount: credit.amount, months: credit.months, id: credit.id, clientId: credit.clientId, accountId: credit.accountId, remainedToPay: credit.remainedToPay, isApproved: true);
    await creditRepository.editCredit(ne);
    final account = await accountRepository.getAccount(credit.accountId);
    final newAccount = Account(clientId: account!.clientId, bankId: account.bankId, balance: account.balance + credit.amount, accountId: account.accountId, isFrozen: account.isFrozen, isBlocked: account.isBlocked);
    DateTime dateTime = DateTime.now();
    Transfer transfer = Transfer("Банк", account.accountId.toString(), credit.amount, dateTime);
    await accountRepository.actTransfer(Account(clientId: 0, bankId: 0), newAccount, transfer);
  }

  Future<void> declineRegistration(Credit credit) async{
    await creditRepository.closeCredit(credit.id);
  }

  Future<List<Credit>> getAllRegistrationRequests() async{
    var s =  await creditRepository.getAllCredits();
    Iterable<Credit> a =  s.where((e) => e.isApproved == false);
    return a.toList();
  }
}