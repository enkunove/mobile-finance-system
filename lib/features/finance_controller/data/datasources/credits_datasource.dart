import 'package:finance_system_controller/features/finance_controller/data/models/credit_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../../../core/database_helper.dart';

class CreditsDatasource {
  static final CreditsDatasource _instance = CreditsDatasource._internal();
  factory CreditsDatasource() => _instance;
  CreditsDatasource._internal();

  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> addCredit(CreditModel model) async{
    final db = await _dbHelper.database;
    await db.insert('credits', model.toMap());
  }
  Future<List<Map<String, Object?>>> getCredit(int id) async{
    final db = await _dbHelper.database;
    return await db.query('credits', where: 'id = ?', whereArgs: [id]);
  }
  Future<void> deleteCredit(int id) async{
    final db = await _dbHelper.database;
    await db.delete('credits', where: 'id = ?', whereArgs: [id]);
  }
  Future<void> editCredit(CreditModel model) async{
    final db = await _dbHelper.database;
    await db.update('credits', model.toMap(), where: 'id = ?', whereArgs: [model.id]);
  }
  Future<List<Map<String, dynamic>>> getCreditsForClient(int clientId) async{
    final db = await _dbHelper.database;
    var a= await db.query('credits', where: 'clientId = ?', whereArgs: [clientId]);
    print(a);
    return a;
  }
  Future<List<Map<String, dynamic>>> getCredits() async{
    final db = await _dbHelper.database;
    var a= await db.query('credits');
    return a;
  }
  Future<Map<String, dynamic>?> getCreditForAccount(int accountId) async{
    final db = await _dbHelper.database;
    final maps = await db.query('credits', where: 'accountId = ?', whereArgs: [accountId]);
    print(maps);
    if (maps.isEmpty) {
      return null;
    } else {
      return maps[0];
    }
  }
}
