import 'package:finance_system_controller/features/finance_controller/domain/entities/bank.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/client.dart';
import 'package:finance_system_controller/features/finance_controller/domain/repositories/account_repository.dart';
import '../../entities/account.dart';
import '../../entities/transfer.dart';

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

  Future<Account?> getAccountById(int id) async {
    return await accountRepository.getAccount(id);
  }

  Future<bool> deposit(int accountId, double amount) async {
    try {
      Account? a = await accountRepository.getAccount(accountId);
      if (!a!.isFrozen && !a.isBlocked) {
        double balance = a.balance;
        balance += amount;
        a.balance = balance;
        await accountRepository.updateAccount(accountId, a);
        return true;
      } else {
        return false;
      }

    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> withdraw(int accountId, double amount) async{
    try {
      Account? a = await accountRepository.getAccount(accountId);
      if (!a!.isFrozen && !a.isBlocked) {
        double balance = a.balance;
        if (amount <= balance) balance -= amount;
        a.balance = balance;
        await accountRepository.updateAccount(accountId, a);
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> transfer(String fromAccountId, String toAccountId, double amount) async {
    try {
      Account? fromAccount = await accountRepository.getAccount(int.parse(fromAccountId));
      Account? toAccount = await accountRepository.getAccount(int.parse(toAccountId));
      double fromBalance = fromAccount!.balance;
      double toBalance = toAccount!.balance;
      if (fromAccount.isBlocked != true && fromAccount.isFrozen != true) {
        if (amount <= fromBalance) {
          fromBalance -= amount;
          toBalance += amount;
        }
        fromAccount.balance = fromBalance;
        toAccount.balance = toBalance;
        DateTime dateTime = DateTime.now();
        Transfer transfer = Transfer(fromAccountId.toString(), toAccountId.toString(), amount, dateTime);
        await accountRepository.actTransfer(fromAccount, toAccount, transfer);
        return true;
      } else {
        return false;
      }

    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> freezeAccount(int accountId) async {
    Account? a = await accountRepository.getAccount(accountId);
    a!.isFrozen = !a.isFrozen;
    return await accountRepository.updateAccount(accountId, a);
  }
  Future<bool> blockAccount(int accountId) async {
    Account? a = await accountRepository.getAccount(accountId);
    a!.isBlocked = !a.isBlocked;
    return await accountRepository.updateAccount(accountId, a);
  }

  Future<List<Transfer>> getAllTransferredForClient(int clientId) async {
    return await accountRepository.getAllTransferredForClient(clientId);
  }
  Future<List<Transfer>> getAllTransfers() async {
    return await accountRepository.getAllTransfers();
  }

  Future<void> revertTransfer(Transfer transfer) async{
    await accountRepository.revertTransfer(transfer);
  }
}