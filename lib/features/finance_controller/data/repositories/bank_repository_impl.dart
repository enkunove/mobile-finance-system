import 'package:finance_system_controller/features/finance_controller/data/datasources/banks_datasource.dart';
import 'package:finance_system_controller/features/finance_controller/data/models/bank_model.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/bank.dart';
import 'package:finance_system_controller/features/finance_controller/domain/repositories/bank_repository.dart';

class BankRepositoryImpl implements BankRepository{

  final BanksDatasource banksDatasource;

  BankRepositoryImpl({required this.banksDatasource});

  @override
  Future<bool> addBank(Bank bank) async {
    BankModel model = BankModel(id: bank.id, type: bank.type, name: bank.name, pin: bank.pin, bic: bank.bic, address: bank.address);
    await banksDatasource.insertBank(model.toMap());
    return true;
  }

  @override
  Future<bool> deleteBank(String id) {
    // TODO: implement deleteBank
    throw UnimplementedError();
  }

  @override
  Future<List<Bank>> getAllBanks() {
    // TODO: implement getAllBanks
    throw UnimplementedError();
  }

  @override
  Future<Bank?> getBankById(String id) {
    // TODO: implement getBankById
    throw UnimplementedError();
  }

  @override
  Future<bool> updateBank(Bank bank) {
    // TODO: implement updateBank
    throw UnimplementedError();
  }

}