import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/client.dart';

import '../entities/account.dart';
import '../entities/bank.dart';

abstract class AccountRepository{
  Future<void> createAccount(Client client, Bank bank);
  Future<Account> getAccount(String accountId);
  Future<List<Account>> getAccountsForClient(Client client);
  Future<bool> deleteAccount(String accountId);
  Future<bool> updateAccount(String accountId, Account account);
}