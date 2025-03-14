import 'dart:async';
import 'package:finance_system_controller/features/finance_controller/data/models/account_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BanksDatasource {
  static final BanksDatasource _instance = BanksDatasource._internal();
  static Database? _database;

  factory BanksDatasource() => _instance;

  BanksDatasource._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE banks (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      type TEXT NOT NULL,
      name TEXT NOT NULL,
      pin TEXT NOT NULL,
      bic TEXT NOT NULL,
      address TEXT NOT NULL,
      clients TEXT, 
    )
  ''');
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'banks_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<int> insertBank(Map<String, dynamic> bankData) async {
    final db = await database;
    return await db.insert('banks', bankData,
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<Map<String, dynamic>>> getBanks() async {
    final db = await database;
    return await db.query('banks');
  }

  Future<List<Map<String, dynamic>>> getBanksForClient(int clientId) async {
    final db = await database;
    return await db
        .query('banks', where: 'clientId = ?', whereArgs: [clientId]);
  }

  Future<int> deleteBank(String id) async {
    final db = await database;
    return await db.delete('banks', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateBank(AccountModel account) async {
    final db = await database;
    return await db.update(
      'banks',
      account.toMap(),
      where: 'id = ?',
      whereArgs: [account.accountId],
    );
  }
}
