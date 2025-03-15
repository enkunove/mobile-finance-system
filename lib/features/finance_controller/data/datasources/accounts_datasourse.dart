import 'dart:async';
import 'package:finance_system_controller/features/finance_controller/data/models/account_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AccountsDatasource {
  static final AccountsDatasource _instance = AccountsDatasource._internal();
  static Database? _database;

  factory AccountsDatasource() => _instance;

  AccountsDatasource._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE accounts (
        accountId INTEGER PRIMARY KEY AUTOINCREMENT,
        clientId INTEGER,
        bankId INTEGER,
        balance REAL DEFAULT 0.0,
        isBlocked INTEGER DEFAULT 0,
        isFrozen INTEGER DEFAULT 0,
        FOREIGN KEY (bankId) REFERENCES banks (id) ON DELETE CASCADE,
        FOREIGN KEY (clientId) REFERENCES clients (idNumber) ON DELETE CASCADE
      );''');
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'accounts_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<int> insertAccount(Map<String, dynamic> accountData) async {
    final db = await database;
    print(accountData);
    return await db.insert('accounts', accountData,
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<Map<String, dynamic>>> getAccounts() async {
    final db = await database;
    return await db.query('accounts');
  }

  Future<Map<String, dynamic>> getAccountById(int id) async{
    final db = await database;
    final maps = await db.query('accounts', where: 'accountId = ?', whereArgs: [id]);
    final ac = maps[0];
    return ac;
  }

  Future<List<Map<String, dynamic>>> getAccountsForClient(int clientId) async {
    final db = await database;
    return await db
        .query('accounts', where: 'clientId = ?', whereArgs: [clientId]);
  }

  Future<int> deleteAccount(String id) async {
    final db = await database;
    return await db.delete('accounts', where: 'accountId = ?', whereArgs: [id]);
  }

  Future<int> updateAccount(AccountModel account) async {
    final db = await database;
    return await db.update(
      'accounts',
      account.toMap(),
      where: 'accountId = ?',
      whereArgs: [account.accountId],
    );
  }
}
