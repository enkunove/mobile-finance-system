import 'package:finance_system_controller/features/finance_controller/data/datasources/clients_datasource.dart';
import 'package:finance_system_controller/features/finance_controller/data/models/bank_model.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/account.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/client.dart';
import 'package:finance_system_controller/features/finance_controller/domain/repositories/account_repository.dart';

import '../../domain/entities/bank.dart';
import '../datasources/accounts_datasourse.dart';
import '../models/account_model.dart';

class AccountRepositoryImpl implements AccountRepository{
  final AccountsDatasource accountsDatasource;
  final ClientsDatasource clientsDatasource;

  AccountRepositoryImpl({required this.accountsDatasource, required this.clientsDatasource});


  @override
  Future<void> createAccount(Client client, Bank bank) async {
    BankModel bankModel = BankModel(id: bank.id, type: bank.type, name: bank.name, pin: bank.pin, bic: bank.bic, address: bank.address);
    AccountModel accountModel = AccountModel(
      clientId: client.idNumber,
      bankModel: bankModel
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
      result.add(Account(clientId: m.clientId, balance:  m.balance, accountId: m.accountId, isBlocked: m.isBlocked, isFrozen: m.isFrozen, bank: m.bank));
    }
    return result;
  }

  @override
  Future<bool> deleteAccount(String accountId) {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }

  @override
  Future<Account> getAccount(String accountId) {
    // TODO: implement getAccount
    throw UnimplementedError();
  }

  @override
  Future<bool> updateAccount(String accountId, Account account) {
    // TODO: implement updateAccount
    throw UnimplementedError();
  }

}