import 'dart:async';
import 'package:finance_system_controller/features/finance_controller/data/models/account_model.dart';
import 'package:finance_system_controller/features/finance_controller/data/models/transfer_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:finance_system_controller/core/database_helper.dart';

class AccountsDatasource {
  static final AccountsDatasource _instance = AccountsDatasource._internal();
  factory AccountsDatasource() => _instance;
  AccountsDatasource._internal();

  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> insertAccount(Map<String, dynamic> accountData) async {
    final db = await _dbHelper.database;
    return await db.insert('accounts', accountData,
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<Map<String, dynamic>>> getAccounts() async {
    final db = await _dbHelper.database;
    return await db.query('accounts');
  }
  Future<List<Map<String, dynamic>>> getAccountsForClient(int id) async {
    final db = await _dbHelper.database;
    return await db.query('accounts', where: 'clientId = ?', whereArgs: [id]);
  }

  Future<Map<String, dynamic>?> getAccountById(int id) async {
    final db = await _dbHelper.database;
    final maps =
    await db.query('accounts', where: 'accountId = ?', whereArgs: [id]);
    return maps.isNotEmpty ? maps[0] : null;
  }

  Future<int> deleteAccount(int id) async {
    final db = await _dbHelper.database;
    return await db.delete('accounts', where: 'accountId = ?', whereArgs: [id]);
  }

  Future<int> updateAccount(AccountModel account) async {
    final db = await _dbHelper.database;
    return await db.update(
      'accounts',
      account.toMap(),
      where: 'accountId = ?',
      whereArgs: [account.accountId],
    );
  }

  Future<void> addTransfer(TransferModel model) async {
    final db = await _dbHelper.database;
    await db.insert('transfers', model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<Map<String, dynamic>>> getAllTransfersForClient(int clientId) async {
    final db = await _dbHelper.database;
    final accountsMaps =
    await db.query('accounts', where: 'clientId = ?', whereArgs: [clientId]);
    final List<int> accountIds =
    accountsMaps.map((account) => account['accountId'] as int).toList();
    if (accountIds.isEmpty) {
      return [];
    }
    return await db.query(
      'transfers',
      where:
      'source IN (${List.filled(accountIds.length, '?').join(', ')}) OR target IN (${List.filled(accountIds.length, '?').join(', ')})',
      whereArgs: [...accountIds, ...accountIds],
    );
  }
}
