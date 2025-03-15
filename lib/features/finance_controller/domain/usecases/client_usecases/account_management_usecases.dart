import 'package:finance_system_controller/features/finance_controller/domain/entities/bank.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/client.dart';
import 'package:finance_system_controller/features/finance_controller/domain/repositories/account_repository.dart';
import '../../entities/account.dart';

class AccountManagementUsecases{
  final Client client;
  final AccountRepository accountRepository;

  AccountManagementUsecases(this.client, this.accountRepository);

  Future<void> createAccount(Client client, Bank bank) async {
    try {
      await accountRepository.createAccount(client, bank.id);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<bool> closeAccount(int accountId) async {
    try {
      return await accountRepository.deleteAccount(accountId);
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<Account>> getAccountsForClient(Client client) async{
    return await accountRepository.getAccountsForClient(client);
  }

  Future<bool> deposit(int accountId, double amount) async {
    try {
      Account a = await accountRepository.getAccount(accountId);
      double balance = a.balance;
      balance += amount;
      a.balance = balance;
      return await accountRepository.updateAccount(accountId, a);

    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> withdraw(int accountId, double amount) async{
    try {
      Account a = await accountRepository.getAccount(accountId);
      double balance = a.balance;
      if (amount <= balance) balance -= amount;
      a.balance = balance;
      return await accountRepository.updateAccount(accountId, a);
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  /*Future<bool> transfer(String fromAccountId, String toAccountId, double amount) async {
    try {
      Account fromAccount = client.accounts.firstWhere((Account e) => e.accountId == fromAccountId);
      Account toAccount = client.accounts.firstWhere((Account e) => e.accountId == toAccountId);
      double fromBalance = fromAccount.balance;
      double toBalance = toAccount.balance;
      if (amount <= fromBalance) {
        fromBalance -= amount;
        toBalance += amount;
      }
      Transfer transfer = Transfer(fromAccount, toAccount, amount);
      client.transfers.add(transfer);
      await accountRepository.actTransfer(transfer);
      await accountRepository.updateBalance(toAccountId, toBalance);
      return await accountRepository.updateBalance(fromAccountId, fromBalance);
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }*/
  Future<bool> freezeAccount(int accountId) async {
    Account a = await accountRepository.getAccount(accountId);
    a.isFrozen = !a.isFrozen;
    return await accountRepository.updateAccount(accountId, a);
  }
  Future<bool> blockAccount(int accountId) async {
    Account a = await accountRepository.getAccount(accountId);
    a.isBlocked = !a.isBlocked;
    return await accountRepository.updateAccount(accountId, a);
  }
}