import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

import '../models/system_users/client_model.dart';

class ClientsDatasource {
  static final ClientsDatasource _instance = ClientsDatasource._internal();
  static Database? _database;

  factory ClientsDatasource() => _instance;

  ClientsDatasource._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'client_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE clients (
        username TEXT,
        password TEXT,
        fullName TEXT,
        passportSeriesAndNumber TEXT,
        idNumber INTEGER PRIMARY KEY AUTOINCREMENT,
        phone TEXT,
        email TEXT,
        accounts TEXT,
        credits TEXT,
        transfers TEXT
      )
    ''');
  }

  Future<int> insertClient(ClientModel client) async {
    final db = await database;
    return await db.insert('clients', client.toMap());
  }

  Future<ClientModel> login(String password, String username) async{
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('clients', where: 'username = ? AND password = ?', whereArgs: [username, password]);
    final clientmodel = ClientModel.fromMap(maps[0]);
    return clientmodel;
  }

  Future<List<ClientModel>> getClients() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('clients');
    return List.generate(maps.length, (i) {
      return ClientModel.fromMap(maps[i]);
    });
  }

  Future<ClientModel> getClient(int id) async{
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('clients', where: 'idNumber = ?', whereArgs: [id]);
    final clientmodel = ClientModel.fromMap(maps[0]);
    return clientmodel;
  }

  Future<int> deleteClient(String id) async {
    final db = await database;
    return await db.delete('clients', where: 'idNumber = ?', whereArgs: [id]);
  }

  Future<int> updateClient(ClientModel client) async {
    final db = await database;
    return await db.update(
      'clients',
      client.toMap(),
      where: 'idNumber = ?',
      whereArgs: [client.idNumber],
    );
  }
}
