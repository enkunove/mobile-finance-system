import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'finance_system.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
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
        isApproved INTEGER,
        role TEXT
      )
    ''');

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
      );
    ''');

    await db.execute('''
      CREATE TABLE transfers (
        transferId INTEGER PRIMARY KEY AUTOINCREMENT,
        source TEXT,
        target TEXT,
        amount REAL DEFAULT 0.0,
        dateTime TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE enterprises (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT NOT NULL,
        name TEXT NOT NULL,
        pin TEXT NOT NULL,
        bic TEXT NOT NULL,
        address TEXT NOT NULL,
        bankId INTEGER,
        specialistId INTEGER
      );
    ''');

    await db.execute('''
      CREATE TABLE credits (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        clientId INTEGER,
        accountId INTEGER,
        amount REAL NOT NULL,
        isApproved INTEGER,
        percentage REAL,
        remainedToPay REAL NOT NULL,
        months INTEGER,
        FOREIGN KEY (clientId) REFERENCES clients (idNumber) ON DELETE CASCADE
        FOREIGN KEY (accountId) REFERENCES accounts (accountId) ON DELETE CASCADE
        
      );
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute('DROP TABLE IF EXISTS transfers');
    await db.execute('DROP TABLE IF EXISTS accounts');
    await db.execute('DROP TABLE IF EXISTS enterprises');
    await db.execute('DROP TABLE IF EXISTS clients');
    await db.execute('DROP TABLE IF EXISTS credits');
    await _onCreate(db, newVersion);
  }
  Future<void> clearDatabase() async {
    final db = await database;
    await db.execute('DELETE FROM clients');
    await db.execute('DELETE FROM accounts');
    await db.execute('DELETE FROM transfers');
    await db.execute('DELETE FROM enterprises');
    await db.execute('DELETE FROM credits');
    String path = join(await getDatabasesPath(), 'finance_system.db');
    await deleteDatabase(path);
  }
}