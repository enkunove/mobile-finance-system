import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

import '../../../../core/database_helper.dart';
import '../models/system_users/client_model.dart';

class ClientsDatasource {
  static final ClientsDatasource _instance = ClientsDatasource._internal();
  factory ClientsDatasource() => _instance;
  ClientsDatasource._internal();

  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> insertClient(ClientModel client) async {
    final db = await _dbHelper.database;
    return await db.insert('clients', client.toMap());
  }

  Future<dynamic> login(String password, String username) async{
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('clients', where: 'username = ? AND password = ?', whereArgs: [username, password]);
    return maps[0];
  }

  Future<List<ClientModel>> getClients() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('clients');
    return List.generate(maps.length, (i) {
      return ClientModel.fromMap(maps[i]);
    });
  }

  Future<List<ClientModel>> getUnconfirmedClients() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('clients', where: 'isApproved = ?', whereArgs: [0]);
    print(maps);
    return List.generate(maps.length, (i) {
      return ClientModel.fromMap(maps[i]);
    });
  }

  Future<ClientModel> getClient(int id) async{
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('clients', where: 'idNumber = ?', whereArgs: [id]);
    final clientmodel = ClientModel.fromMap(maps[0]);
    return clientmodel;
  }

  Future<int> deleteClient(int id) async {
    final db = await _dbHelper.database;
    return await db.delete('clients', where: 'idNumber = ?', whereArgs: [id]);
  }

  Future<int> updateClient(ClientModel client) async {
    final db = await _dbHelper.database;
    print(client);
    return await db.update(
      'clients',
      client.toMap(),
      where: 'idNumber = ?',
      whereArgs: [client.idNumber],
    );
  }
}
