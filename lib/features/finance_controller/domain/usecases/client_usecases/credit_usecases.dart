import 'package:finance_system_controller/features/finance_controller/domain/entities/account.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/credit.dart';
import 'package:finance_system_controller/features/finance_controller/domain/repositories/account_repository.dart';

import '../../entities/system_users/client.dart';
import '../../entities/transfer.dart';
import '../../repositories/credit_repository.dart';


class CreditUsecases {
  final CreditRepository creditRepository;
  final AccountRepository accountRepository;
  final Client client;

  CreditUsecases(this.creditRepository, this.client, this.accountRepository);

  Future<List<Credit>> getCreditsForClient() async {
    return await creditRepository.getCreditsForClient(client.idNumber);
  }

  Future<List<Credit>> getAllCredits() async {
    return await creditRepository.getAllCredits();
  }

  Future<Credit?> getCreditForAccount(int accountId) async {
    return await creditRepository.getCreditForAccount(accountId);
  }

  Future<void> addCredit(Credit credit) async {
    return await creditRepository.openCreditRequest(credit);
  }

  Future<void> deleteCredit(int id) async {
    return await creditRepository.closeCredit(id);
  }

  Future<Credit?> putMonthlyPayment(int creditId) async {
    Credit credit = await creditRepository.getCreditById(creditId);
    double monthlyPayment = double.parse(
      (((credit.amount + credit.amount * credit.percentage * 0.01) /
          credit.months) + 0.01)
          .toStringAsFixed(2),
    );
    final account = await accountRepository.getAccount(credit.accountId);
    if (account!.balance >= monthlyPayment && !account.isFrozen &&
        !account.isBlocked) {
      if (credit.remainedToPay >= monthlyPayment) {
        DateTime dateTime = DateTime.now();
        Transfer transfer = Transfer(account.accountId.toString(), "Банк",  monthlyPayment, dateTime);
        final newAccount = Account(
          clientId: account.clientId,
          bankId: account.bankId,
          balance: account.balance - monthlyPayment,
          accountId: account.accountId,
        );
        await accountRepository.actTransfer(newAccount, Account(clientId: 0, bankId: 0), transfer);
        double newRemainedToPay = double.parse(
          (credit.remainedToPay - monthlyPayment).toStringAsFixed(2),
        );
        final updatedCredit = Credit(
          percentage: credit.percentage,
          amount: credit.amount,
          months: credit.months,
          id: credit.id,
          clientId: credit.clientId,
          accountId: credit.accountId,
          remainedToPay: newRemainedToPay,
          isApproved: true,
        );
        await creditRepository.editCredit(updatedCredit);
        return updatedCredit;
      } else {
        DateTime dateTime = DateTime.now();
        Transfer transfer = Transfer(account.accountId.toString(), "Банк", credit.remainedToPay, dateTime);
        final newAccount = Account(
          clientId: account.clientId,
          bankId: account.bankId,
          balance: account.balance - credit.remainedToPay,
          accountId: account.accountId,
        );
        await accountRepository.actTransfer(newAccount, Account(clientId: 0, bankId: 0), transfer);
        await creditRepository.closeCredit(credit.id);
        return null;
      }
    } else {
      return credit;
    }
  }
}