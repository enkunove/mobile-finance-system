import 'dart:async';
import 'package:finance_system_controller/features/finance_controller/data/models/account_model.dart';
import 'package:finance_system_controller/features/finance_controller/data/models/bank_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/database_helper.dart';

class EnterprisesDatasource {
  static final EnterprisesDatasource _instance = EnterprisesDatasource._internal();
  factory EnterprisesDatasource() => _instance;
  EnterprisesDatasource._internal();

  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> insertBank(Map<String, dynamic> bankData) async {
    final db = await _dbHelper.database;
    print(bankData);
    return await db.insert('enterprises', bankData,
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<Map<String, dynamic>>> getBanks() async {
    final db = await _dbHelper.database;
    return await db.query('enterprises');
  }

  Future<Map<String, dynamic>> getBankById(int id) async {
    final db = await _dbHelper.database;
    final maps = await db
        .query('enterprises', where: 'id = ?', whereArgs: [id]);
    return maps[0];
  }

  Future<List<Map<String, dynamic>>> getBanksForClient(int clientId) async {
    final db = await _dbHelper.database;
    return await db
        .query('enterprises', where: 'clientId = ?', whereArgs: [clientId]);
  }

  Future<int> deleteBank(String id) async {
    final db = await _dbHelper.database;
    return await db.delete('enterprises', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateBank(AccountModel account) async {
    final db = await _dbHelper.database;
    return await db.update(
      'enterprises',
      account.toMap(),
      where: 'id = ?',
      whereArgs: [account.accountId],
    );
  }

  Future<void> initBanks() async {
    List<Map<String, dynamic>> banks = [
      BankModel(id: 0, type: "ОАО", name: "Банк1", pin: "7892312314421", bic: "089-4242882", address: "ул. Вффыфы, дом 1").toMap(),
      BankModel(id: 0, type: "АО", name: "Банк2", pin: "1234567890123", bic: "045004234", address: "ул. Вффыфы, дом 2").toMap(),
      BankModel(id: 0, type: "ЗАО", name: "Банк3", pin: "2345678901234", bic: "049876543", address: "ул. Вффыфы, дом 3").toMap(),
    ];
    for (var bank in banks) {
      await insertBank(bank);
    }
  }

}

