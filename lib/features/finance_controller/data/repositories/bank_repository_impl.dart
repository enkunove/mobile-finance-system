import 'package:finance_system_controller/features/finance_controller/data/datasources/enterprises_datasource.dart';
import 'package:finance_system_controller/features/finance_controller/data/models/bank_model.dart';
import 'package:finance_system_controller/features/finance_controller/data/models/enterprise_model.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/bank.dart';
import 'package:finance_system_controller/features/finance_controller/domain/repositories/bank_repository.dart';

import '../../domain/entities/enterprise.dart';

class BankRepositoryImpl implements BankRepository{

  final EnterprisesDatasource banksDatasource;

  BankRepositoryImpl({required this.banksDatasource});

  @override
  Future<bool> addBank(Enterprise bank) async {
    EnterpriseModel model = EnterpriseModel(id: bank.id, type: bank.type, name: bank.name, pin: bank.pin, bic: bank.bic, address: bank.address, specialistId: bank.specialistId);
    await banksDatasource.insertBank(model.toMap());
    print("Impl: $model");
    return true;
  }

  @override
  Future<bool> deleteBank(int id) {
    // TODO: implement deleteBank
    throw UnimplementedError();
  }

  @override
  Future<List<Bank>> getAllBanks() async {
    final maps = await banksDatasource.getBanks();
    final models =  List.generate(maps.length, (i) {
      return BankModel.fromMap(maps[i]);
    });
    final List<Bank> result = [];
    for(var m in models){
      result.add(Bank(id: m.id, type: m.type, pin: m.pin, address: m.address, name: m.name, bic: m.bic));
    }
    return result;
  }

  @override
  Future<Bank> getBankById(int id) async  {
    final map = await banksDatasource.getBankById(id);
    final model = BankModel.fromMap(map);
    return model;
  }

  @override
  Future<bool> updateBank(Bank bank) {
    // TODO: implement updateBank
    throw UnimplementedError();
  }

}