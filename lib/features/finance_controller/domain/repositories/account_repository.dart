import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/client.dart';

import '../entities/account.dart';
import '../entities/bank.dart';

abstract class AccountRepository{
  Future<void> createAccount(Client client, int bankId);
  Future<Account> getAccount(int accountId);
  Future<List<Account>> getAccountsForClient(Client client);
  Future<bool> deleteAccount(int accountId);
  Future<bool> updateAccount(int accountId, Account account);
}