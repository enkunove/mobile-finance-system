import 'dart:async';
import 'package:finance_system_controller/features/finance_controller/data/models/account_model.dart';
import 'package:finance_system_controller/features/finance_controller/data/models/bank_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../../../core/database_helper.dart';

class BanksDatasource {
  static final BanksDatasource _instance = BanksDatasource._internal();
  factory BanksDatasource() => _instance;
  BanksDatasource._internal();

  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> insertBank(Map<String, dynamic> bankData) async {
    final db = await _dbHelper.database;
    print(bankData);
    return await db.insert('banks', bankData,
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<Map<String, dynamic>>> getBanks() async {
    final db = await _dbHelper.database;
    return await db.query('banks');
  }

  Future<Map<String, dynamic>> getBankById(int id) async {
    final db = await _dbHelper.database;
    final maps = await db
        .query('banks', where: 'id = ?', whereArgs: [id]);
    return maps[0];
  }

  Future<List<Map<String, dynamic>>> getBanksForClient(int clientId) async {
    final db = await _dbHelper.database;
    return await db
        .query('banks', where: 'clientId = ?', whereArgs: [clientId]);
  }

  Future<int> deleteBank(String id) async {
    final db = await _dbHelper.database;
    return await db.delete('banks', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateBank(AccountModel account) async {
    final db = await _dbHelper.database;
    return await db.update(
      'banks',
      account.toMap(),
      where: 'id = ?',
      whereArgs: [account.accountId],
    );
  }

  Future<void> initBanks() async {
    List<Map<String, dynamic>> banks = [
      BankModel(id: 0, type: "ОАО", name: "Ебанк", pin: "7892312314421", bic: "089-4242882", address: "ул. Пиздюлькина, дом 1").toMap(),
      BankModel(id: 0, type: "АО", name: "Пизданк", pin: "1234567890123", bic: "045004234", address: "ул. Пиздюлькина, дом 2").toMap(),
      BankModel(id: 0, type: "ЗАО", name: "Владислав Клепацкий", pin: "2345678901234", bic: "049876543", address: "где-то возле общаги").toMap(),
      BankModel(id: 0, type: "ОАО", name: "Рехаб-банк", pin: "3456789012345", bic: "040354345", address: "ул. Пиздюлькина, дом 3").toMap(),
      BankModel(id: 0, type: "АО", name: "СВО-банк", pin: "4567890123456", bic: "041876543", address: "ул. Пиздюлькина, дом 4").toMap(),
      BankModel(id: 0, type: "ЗАО", name: "кнаБ", pin: "5678901234567", bic: "042348734", address: "ул. Пиздюлькина, дом 5").toMap(),
      BankModel(id: 0, type: "ОАО", name: "Хуянк", pin: "6789012345678", bic: "040612563", address: "ул. Пиздюлькина, дом 6").toMap(),
      BankModel(id: 0, type: "АО", name: "Пельмень", pin: "7890123456789", bic: "042145678", address: "ул. Пиздюлькина, дом 7").toMap(),
      BankModel(id: 0, type: "ЗАО", name: "Чебупель", pin: "8901234567890", bic: "044525666", address: "ул. Пиздюлькина, дом 8").toMap(),
      BankModel(id: 0, type: "ОАО", name: "Пиздабанк", pin: "9012345678901", bic: "040614752", address: "ул. Пиздюлькина, дом 9").toMap(),
    ];
    for (var bank in banks) {
      await insertBank(bank);
    }
  }

}

