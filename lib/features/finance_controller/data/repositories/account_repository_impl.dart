import 'package:finance_system_controller/features/finance_controller/data/datasources/clients_datasource.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/account.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/client.dart';
import 'package:finance_system_controller/features/finance_controller/domain/repositories/account_repository.dart';

import '../datasources/accounts_datasourse.dart';
import '../models/account_model.dart';

class AccountRepositoryImpl implements AccountRepository{
  final AccountsDatasource accountsDatasource;
  final ClientsDatasource clientsDatasource;

  AccountRepositoryImpl({required this.accountsDatasource, required this.clientsDatasource});


  @override
  Future<void> createAccount(Client client, int bankId) async {
    AccountModel accountModel = AccountModel(
      clientId: client.idNumber,
      bankId : bankId
    );
    await accountsDatasource.insertAccount(accountModel.toMap());
  }
  @override
  Future<List<Account>> getAccountsForClient(Client client) async {
    int id =  client.idNumber;
    final maps = await accountsDatasource.getAccountsForClient(id);
    final models =  List.generate(maps.length, (i) {
      return AccountModel.fromMap(maps[i]);
    });
    final List<Account> result = [];
    for(var m in models){
      result.add(Account(clientId: m.clientId, balance:  m.balance, accountId: m.accountId, isBlocked: m.isBlocked, isFrozen: m.isFrozen, bankId: m.bankId));
    }
    return result;
  }

  @override
  Future<bool> deleteAccount(int accountId) async{
    await accountsDatasource.deleteAccount(accountId);
    return true;
  }

  @override
  Future<Account> getAccount(int accountId) async {
    final map = await accountsDatasource.getAccountById(accountId);
    final model = AccountModel.fromMap(map);
    return Account(clientId: model.clientId, bankId: model.bankId, balance: model.balance, accountId: model.accountId, isFrozen: model.isFrozen, isBlocked: model.isBlocked);
  }

  @override
  Future<bool> updateAccount(int accountId, Account account) async {
    final AccountModel model = AccountModel(clientId: account.clientId, balance:  account.balance, accountId: account.accountId, isBlocked: account.isBlocked, isFrozen: account.isFrozen, bankId: account.bankId);
    await accountsDatasource.updateAccount(model);
    return true;
  }

}