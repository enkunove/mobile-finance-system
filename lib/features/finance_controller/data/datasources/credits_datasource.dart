import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CreditsDatasource {
  static final CreditsDatasource _instance = CreditsDatasource._internal();
  static Database? _database;

  factory CreditsDatasource() => _instance;

  CreditsDatasource._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'accounts_database.db');

    return await openDatabase(
      path,
      version: 3,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS credits (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            clientId INTEGER,
            percentage REAL,
            amount REAL,
            remainedToPay REAL,
            FOREIGN KEY (clientId) REFERENCES clients (idNumber) ON DELETE CASCADE
          );
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 3) {
          await db.execute('''
            CREATE TABLE IF NOT EXISTS credits (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              clientId INTEGER,
              percentage REAL,
              amount REAL,
              remainedToPay REAL,
              FOREIGN KEY (clientId) REFERENCES clients (idNumber) ON DELETE CASCADE
            );
          ''');
          print('Таблица credits создана при обновлении!');
        }
      },
      onOpen: (db) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS credits (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            clientId INTEGER,
            percentage REAL,
            amount REAL,
            remainedToPay REAL,
            FOREIGN KEY (clientId) REFERENCES clients (idNumber) ON DELETE CASCADE
          );
        ''');
      },
    );
  }
}
