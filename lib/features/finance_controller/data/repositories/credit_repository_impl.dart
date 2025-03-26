import 'package:finance_system_controller/features/finance_controller/data/datasources/credits_datasource.dart';
import 'package:finance_system_controller/features/finance_controller/data/models/credit_model.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/credit.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/client.dart';
import 'package:finance_system_controller/features/finance_controller/domain/repositories/credit_repository.dart';

class CreditRepositoryImpl implements CreditRepository{

  final CreditsDatasource datasource;

  CreditRepositoryImpl(this.datasource);

  @override
  Future<void> editCredit(Credit credit) async {
    CreditModel model = CreditModel(accountId: credit.accountId, percentage: credit.percentage, amount: credit.amount, months: credit.months, id: credit.id, clientId: credit.clientId, remainedToPay: credit.remainedToPay, isApproved: credit.isApproved);
    await datasource.editCredit(model);
  }
  

  @override
  Future<void> openCreditRequest(Credit credit) async {
    CreditModel model = CreditModel(accountId: credit.accountId, percentage: credit.percentage, amount: credit.amount, months: credit.months, id: credit.id, clientId: credit.clientId, remainedToPay: credit.remainedToPay, isApproved: credit.isApproved);
    await datasource.addCredit(model);
  }

  @override
  Future<void> closeCredit(int id) async {
    await datasource.deleteCredit(id);
  }

  @override
  Future<List<Credit>> getCreditsForClient(int clientId) async {
    List<Map<String, dynamic>> maps = await datasource.getCreditsForClient(clientId);
    final models =  List.generate(maps.length, (i) {
      return CreditModel.fromMap(maps[i]);
    });
    final List<Credit> result = [];
    for(var m in models){
      result.add(Credit(accountId: m.accountId, percentage: m.percentage, amount: m.amount, months: m.months, id: m.id, clientId: m.clientId, remainedToPay: m.remainedToPay, isApproved: m.isApproved));
    }
    return result;
  }

  @override
  Future<Credit?> getCreditForAccount(int accountId) async {
    final m = await datasource.getCreditForAccount(accountId);
    if (m == null) return null;
    print(m);
    return CreditModel.fromMap(m);
  }

  @override
  Future<List<Credit>> getAllCredits() async {
    List<Map<String, dynamic>> maps = await datasource.getCredits();
    final models =  List.generate(maps.length, (i) {
      return CreditModel.fromMap(maps[i]);
    });
    final List<Credit> result = [];
    for(var m in models){
      result.add(Credit(accountId: m.accountId, percentage: m.percentage, amount: m.amount, months: m.months, id: m.id, clientId: m.clientId, remainedToPay: m.remainedToPay, isApproved: m.isApproved));
    }
    print(result);
    return result;
  }

  @override
  Future<Credit> getCreditById(int creditId) async {
    final maps = await datasource.getCredit(creditId);
    return CreditModel.fromMap(maps[0]);
  }
}